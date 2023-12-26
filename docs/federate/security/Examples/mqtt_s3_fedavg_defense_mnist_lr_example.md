---
sidebar_position: 2
---
# FedAVG, MNIST, Logistic Regression, and Defenses


This example demonstrates how to activate an attack using local data from multiple clients. The source code locates at [https://github.com/FedML-AI/FedML/tree/master/python/examples/federate/security/mqtt_s3_fedavg_defense_mnist_lr_example](https://github.com/FedML-AI/FedML/tree/master/python/examples/federate/security/mqtt_s3_fedavg_defense_mnist_lr_example). We provide sample configurations for different defense mechanisms at [https://github.com/FedML-AI/FedML/tree/master/python/examples/federate/security/mqtt_s3_fedavg_defense_mnist_lr_example/config](https://github.com/FedML-AI/FedML/tree/master/python/examples/federate/security/mqtt_s3_fedavg_defense_mnist_lr_example/config), including cclip defense, foolsgold, geometric median, krum (and m-krum), crfl, rfa, etc. As an example, We utilize byzantine attack of random mode as an example. 


> **If you have multiple nodes, you should run the client script on each node**

## APIs

The highly encapsulated server and client API calls are shown as below. Note that we set the path of the configuration file in the two bash scripts to be config/byzantine/fedml_config.yaml to load the configuration for byzantine attack.

`run_server.sh` is as follows:


```shell
#!/usr/bin/env bash
RUN_ID=$1
python3 torch_server.py --cf config/krum/fedml_config.yaml --rank 0 --role server --run_id $RUN_ID
```

`torch_server.py`

```python
import fedml
from fedml import FedMLRunner

if __name__ == "__main__":
    args = fedml.init()

    # init device
    device = fedml.device.get_device(args)

    # load data
    dataset, output_dim = fedml.data.load(args)

    # load model
    model = fedml.model.create(args, output_dim)

    # start training
    fedml_runner = FedMLRunner(args, device, dataset, model)
    fedml_runner.run()
```

`run_client.sh`


```shell
#!/usr/bin/env bash
RANK=$1
RUN_ID=$2
python3 torch_client.py --cf config/krum/fedml_config.yaml --rank $RANK --role client --run_id $RUN_ID
```

`torch_client.py`

```python
import fedml
from fedml import FedMLRunner

if __name__ == "__main__":
    args = fedml.init()

    # init device
    device = fedml.device.get_device(args)

    # load data
    dataset, output_dim = fedml.data.load(args)

    # load model
    model = fedml.model.create(args, output_dim)

    # start training
    fedml_runner = FedMLRunner(args, device, dataset, model)
    fedml_runner.run()
```

At the client side, the client ID (a.k.a rank) starts from 1. Please also modify fedml_config.yaml, changing the `client_num_in_total` the as the number of clients you plan to run.

At the server side, run the following script:
```
bash run_server.sh a
```

For client 1, run the following script:
```
bash run_client.sh 1 a
```
For client 2, run the following script:
```
bash run_client.sh 2 a
```

For client 3, run the following script:
```
bash run_client.sh 3 a
```

For client 4, run the following script:
```
bash run_client.sh 4 a
```

For client 5, run the following script:
```
bash run_client.sh 5 a
```



`fedml_config.yaml` is shown below.

```yaml
common_args:
  training_type: "cross_silo"
  scenario: "horizontal"
  using_mlops: false
  random_seed: 0
  config_version: release

environment_args:
  bootstrap: config/bootstrap.sh

data_args:
  dataset: "mnist"
  data_cache_dir: ~/fedml_data
  partition_method: "hetero"
  partition_alpha: 0.5

model_args:
  model: "lr"
  model_file_cache_folder: "./model_file_cache" # will be filled by the server automatically
  global_model_file_path: "./model_file_cache/global_model.pt"

train_args:
  federated_optimizer: "FedAvg"
  client_id_list:
  client_num_in_total: 5
  client_num_per_round: 5
  comm_round: 10
  epochs: 1
  batch_size: 10
  client_optimizer: sgd
  learning_rate: 0.03
  weight_decay: 0.001

validation_args:
  frequency_of_the_test: 1

device_args:
  worker_num: 5
  using_gpu: false
  gpu_mapping_file: config/gpu_mapping.yaml
  gpu_mapping_key: mapping_config3_11

comm_args:
  backend: "MQTT_S3"
  mqtt_config_path:
  s3_config_path:
  grpc_ipconfig_path: ./config/grpc_ipconfig.csv

tracking_args:
  enable_wandb: false

attack_args:
  enable_attack: false
  attack_type: None

defense_args:
  enable_defense: true
  defense_type: krum
  byzantine_client_num: 1
```

### Training Results

At the end of the training, the server window will display the following log:

```shell
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:203:_on_message_impl] mqtt_s3 receive msg deviceType 
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:238:_on_message_impl] mqtt_s3.on_message: not use s3 pack
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:188:_notify] mqtt_s3.notify: msg type = 5
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:39:receive_message] receive_message. msg_type = 5, sender_id = 5, receiver_id = 0
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_server_manager.py:163:handle_message_client_status_update] received client status FINISHED
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_server_manager.py:150:process_finished_status] sender_id = 5, all_client_is_finished = True
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 07:53:03] [INFO] [fedml_comm_manager.py:67:finish] __finish
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 07:53:03] [INFO] [mqtt_s3_multi_clients_comm_manager.py:332:stop_receive_message] mqtt_s3.stop_receive_message: stopping...
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 07:53:03] [INFO] [fedml_comm_manager.py:29:run] finished...
```

At the end of the training, the client 1 window will display the following log:

```shell
[FedML-Client @device-id-1] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:188:_notify] mqtt_s3.notify: msg type = 2
[FedML-Client @device-id-1] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:39:receive_message] receive_message. msg_type = 2, sender_id = 0, receiver_id = 1
[FedML-Client @device-id-1] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:124:handle_message_receive_model_from_server] handle_message_receive_model_from_server.
[FedML-Client @device-id-1] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:135:handle_message_receive_model_from_server] current round index 10, total rounds 10
[FedML-Client @device-id-1] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:175:send_client_status] send_client_status
[FedML-Client @device-id-1] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:176:send_client_status] self.client_real_id = 1
[FedML-Client @device-id-1] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:317:send_message] mqtt_s3.send_message: MQTT msg sent
[FedML-Client @device-id-1] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:67:finish] __finish
[FedML-Client @device-id-1] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:332:stop_receive_message] mqtt_s3.stop_receive_message: stopping...
[FedML-Client @device-id-1] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:29:run] finished...
```

At the end of the training, the client 2 window will display the following log:

```shell
[FedML-Client @device-id-2] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:188:_notify] mqtt_s3.notify: msg type = 2
[FedML-Client @device-id-2] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:39:receive_message] receive_message. msg_type = 2, sender_id = 0, receiver_id = 2
[FedML-Client @device-id-2] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:124:handle_message_receive_model_from_server] handle_message_receive_model_from_server.
[FedML-Client @device-id-2] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:135:handle_message_receive_model_from_server] current round index 10, total rounds 10
[FedML-Client @device-id-2] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:175:send_client_status] send_client_status
[FedML-Client @device-id-2] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:176:send_client_status] self.client_real_id = 2
[FedML-Client @device-id-2] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:317:send_message] mqtt_s3.send_message: MQTT msg sent
[FedML-Client @device-id-2] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:67:finish] __finish
[FedML-Client @device-id-2] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:332:stop_receive_message] mqtt_s3.stop_receive_message: stopping...
[FedML-Client @device-id-2] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:29:run] finished...
```

At the end of the training, the client 3 window will display the following log:

```shell
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:188:_notify] mqtt_s3.notify: msg type = 2
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:39:receive_message] receive_message. msg_type = 2, sender_id = 0, receiver_id = 3
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:124:handle_message_receive_model_from_server] handle_message_receive_model_from_server.
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:135:handle_message_receive_model_from_server] current round index 10, total rounds 10
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:175:send_client_status] send_client_status
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:176:send_client_status] self.client_real_id = 3
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:317:send_message] mqtt_s3.send_message: MQTT msg sent
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:67:finish] __finish
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:332:stop_receive_message] mqtt_s3.stop_receive_message: stopping...
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:29:run] finished...
```


At the end of the training, the client 4 window will display the following log:

```shell
[FedML-Client @device-id-4] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:188:_notify] mqtt_s3.notify: msg type = 2
[FedML-Client @device-id-4] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:39:receive_message] receive_message. msg_type = 2, sender_id = 0, receiver_id = 4
[FedML-Client @device-id-4] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:124:handle_message_receive_model_from_server] handle_message_receive_model_from_server.
[FedML-Client @device-id-4] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:135:handle_message_receive_model_from_server] current round index 10, total rounds 10
[FedML-Client @device-id-4] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:175:send_client_status] send_client_status
[FedML-Client @device-id-4] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:176:send_client_status] self.client_real_id = 4
[FedML-Client @device-id-4] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:317:send_message] mqtt_s3.send_message: MQTT msg sent
[FedML-Client @device-id-4] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:67:finish] __finish
[FedML-Client @device-id-4] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:332:stop_receive_message] mqtt_s3.stop_receive_message: stopping...
[FedML-Client @device-id-4] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:29:run] finished...
```


At the end of the training, the client 5 window will display the following log:

```shell
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:188:_notify] mqtt_s3.notify: msg type = 2
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:39:receive_message] receive_message. msg_type = 2, sender_id = 0, receiver_id = 5
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:124:handle_message_receive_model_from_server] handle_message_receive_model_from_server.
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:135:handle_message_receive_model_from_server] current round index 10, total rounds 10
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:175:send_client_status] send_client_status
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_client_master_manager.py:176:send_client_status] self.client_real_id = 5
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:317:send_message] mqtt_s3.send_message: MQTT msg sent
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:67:finish] __finish
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 07:52:58] [INFO] [mqtt_s3_multi_clients_comm_manager.py:332:stop_receive_message] mqtt_s3.stop_receive_message: stopping...
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 07:52:58] [INFO] [fedml_comm_manager.py:29:run] finished...
```

