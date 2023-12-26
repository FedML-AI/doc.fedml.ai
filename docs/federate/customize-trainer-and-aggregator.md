---
sidebar_position: 7
---

# Customize Trainer and Aggregator
At this point, you may be curious about what kind of API design can withstand the open platforms, the app ecosystem, and support so many AI applications. FedML has done a lot of explorations in this direction, and here is an introduction to several key designs for the open source community.

First, from the application point of view, FedML does its best to shield all code details and complex configurations of distributed training. Data scientists and engineers at the application level, such as computer vision, natural language processing, and data mining, only need to write the model, data, and trainer in the same way as a stand-alone program and then pass it to the FedMLRunner object to complete all the processes. This greatly reduces the bar for application developers to perform federated learning.

```python
import fedml
from my_model_trainer import MyModelTrainer
from my_server_aggregator import MyServerAggregator
from fedml import FedMLRunner
if __name__ == "__main__":
   # init FedML framework
   args = fedml.init()
   # init device
   device = fedml.device.get_device(args)
   # load data
   dataset, output_dim = fedml.data.load(args)
   # load model
   model = fedml.model.create(args, output_dim)
   # my customized trainer and aggregator
   trainer = MyModelTrainer(model, args)
   aggregator = MyServerAggregator(model, args)
   # start training
   fedml_runner = FedMLRunner(args, device, dataset, model, trainer, aggregator)
   fedml_runner.run()
```

Secondly, the FedML team believes that the design of the API should conform to the current technology development trend and should not assume that today’s technology is the final solution; rather, it should be iterated as it progresses. We can see that the algorithm innovation of the open source community is still very active, and many more user-valued algorithms continue to be innovated every month. It is based on this background that FedML considers making custom APIs flexible enough to empower algorithm innovation. To this end, FedML abstracts the core trainer and aggregator and provides users with two abstract objects, `FedML.core.ClientTrainer` and `FedML.core.ServerAggregator`, which only need to inherit the interfaces of these two abstract objects and pass them to FedMLRunner. Such customization provides machine learning developers with maximum flexibility. Users can define arbitrary model structures, optimizers, loss functions, etc. These customizations can also be seamlessly connected with the open source community, open platform, and application ecology mentioned above with the help of FedMLRunner, which completely solves the long lag problem from innovative algorithms to commercialization.

The example at hhttps://github.com/FedML-AI/FedML/tree/master/python/examples/federate/prebuilt_jobs/fedcv/image_classification shows how to build your own trainer and aggregator.

## `FedML.core.ClientTrainer`

```
import logging

import torch
from torch import nn

from fedml.core import ClientTrainer


class ClassificationTrainer(ClientTrainer):
    def get_model_params(self):
        return self.model.cpu().state_dict()

    def set_model_params(self, model_parameters):
        self.model.load_state_dict(model_parameters)

    def train(self, train_data, device, args):
        model = self.model

        model.to(device)
        model.train()

        criterion = nn.CrossEntropyLoss().to(device)
        if args.client_optimizer == "sgd":
            optimizer = torch.optim.SGD(model.parameters(), lr=args.lr)
        else:
            optimizer = torch.optim.Adam(
                filter(lambda p: p.requires_grad, model.parameters()),
                lr=args.lr,
                weight_decay=args.weight_decay,
                amsgrad=True,
            )

        epoch_loss = []
        for epoch in range(args.epochs):
            batch_loss = []
            for batch_idx, (x, labels) in enumerate(train_data):
                # logging.info(images.shape)
                x, labels = x.to(device), labels.to(device)
                optimizer.zero_grad()
                log_probs = model(x)
                loss = criterion(log_probs, labels)
                loss.backward()
                optimizer.step()
                batch_loss.append(loss.item())
                if batch_idx % 100 == 0:
                    logging.info(
                        "Epoch: {}/{} | Batch: {}/{} | Loss: {}".format(
                            epoch + 1,
                            args.epochs,
                            batch_idx,
                            len(train_data),
                            loss.item(),
                        )
                    )

            if len(batch_loss) > 0:
                epoch_loss.append(sum(batch_loss) / len(batch_loss))
                logging.info(
                    "(Trainer_ID {}. Local Training Epoch: {} \tLoss: {:.6f}".format(
                        self.id, epoch, sum(epoch_loss) / len(epoch_loss)
                    )
                )
```

## `FedML.core.ServerAggregator`

```

import logging

import numpy as np
import torch
import torch.nn as nn

import fedml
from fedml.core import ServerAggregator


class ClassificationAggregator(ServerAggregator):
    def get_model_params(self):
        return self.model.cpu().state_dict()

    def set_model_params(self, model_parameters):
        logging.info("set_model_params")
        self.model.load_state_dict(model_parameters)

    def test(self, test_data, device, args):
        pass

    def _test(self, test_data, device):
        model = self.model

        model.eval()
        model.to(device)

        metrics = {
            "test_correct": 0,
            "test_loss": 0,
            "test_precision": 0,
            "test_recall": 0,
            "test_total": 0,
        }

        criterion = nn.CrossEntropyLoss().to(device)
        with torch.no_grad():
            for batch_idx, (x, target) in enumerate(test_data):
                x = x.to(device)
                target = target.to(device)
                pred = model(x)
                loss = criterion(pred, target)
                _, predicted = torch.max(pred, 1)
                correct = predicted.eq(target).sum()

                metrics["test_correct"] += correct.item()
                metrics["test_loss"] += loss.item() * target.size(0)
                if len(target.size()) == 1:  #
                    metrics["test_total"] += target.size(0)
                elif len(target.size()) == 2:  # for tasks of next word prediction
                    metrics["test_total"] += target.size(0) * target.size(1)

        return metrics

    def test_all(
        self, train_data_local_dict, test_data_local_dict, device, args=None
    ) -> bool:
        return True
```