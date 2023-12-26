---
sidebar_position: 3
---
# Byzantine Attack & Krum Defense (Distributed Simulation)


This example demonstrates how to utilize Krum defense against Byzantine attack (random mode) during FL training with MPI backend. We utilize logistic regression, MNIST dataset, and the optimizer FedAVG. The source code locates at [https://github.com/FedML-AI/FedML/tree/master/python/examples/federate/security/mpi_fedavg_byzantine_krum_mnist_lr_example/config](https://github.com/FedML-AI/FedML/tree/master/python/examples/federate/security/mpi_fedavg_byzantine_krum_mnist_lr_example/config). We set the number of FL clients to be 5. 


> **If you have multiple nodes, you should run the client script on each node**

## APIs

The highly encapsulated server and client API calls are shown as below. 

`run_mpi.sh` is as follows:


```shell
#!/usr/bin/env bash

WORKER_NUM=$1

PROCESS_NUM=`expr $WORKER_NUM + 1`
echo $PROCESS_NUM

hostname > mpi_host_file

mpirun -np $PROCESS_NUM -hostfile mpi_host_file --oversubscribe python torch_mpi.py --cf config/fedml_config.yaml
```

`torch_mpi.py`

```python
import logging
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


Run the following script:
```
bash run_mpi.sh 5
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
  # for CLI running, this can be None; in MLOps deployment, `client_id_list` will be replaced with real-time selected devices
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
  backend: "MPI"
  mqtt_config_path:
  s3_config_path:
  grpc_ipconfig_path: ./config/grpc_ipconfig.csv

tracking_args:
  enable_wandb: false

attack_args:
  enable_attack: true
  attack_type: byzantine
  attack_mode: random
  byzantine_client_num: 1

defense_args:
  enable_defense: true
  defense_type: krum
```

### Training Results

At the end of the training, the window will display the following log:

```shell
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_client_master_manager.py:124:handle_message_receive_model_from_server] handle_message_receive_model_from_server.
[FedML-Client @device-id-4] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_client_master_manager.py:175:send_client_status] send_client_status
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_client_master_manager.py:135:handle_message_receive_model_from_server] current round index 10, total rounds 10
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_comm_manager.py:39:receive_message] receive_message. msg_type = 2, sender_id = 0, receiver_id = 3
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_client_master_manager.py:124:handle_message_receive_model_from_server] handle_message_receive_model_from_server.
[FedML-Client @device-id-4] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_client_master_manager.py:176:send_client_status] self.client_real_id = 4
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_client_master_manager.py:135:handle_message_receive_model_from_server] current round index 10, total rounds 10
[FedML-Client @device-id-4] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_comm_manager.py:67:finish] __finish
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_client_master_manager.py:175:send_client_status] send_client_status
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_comm_manager.py:39:receive_message] receive_message. msg_type = 5, sender_id = 1, receiver_id = 0
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_server_manager.py:163:handle_message_client_status_update] received client status FINISHED
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_client_master_manager.py:176:send_client_status] self.client_real_id = 5
[FedML-Client @device-id-5] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_comm_manager.py:67:finish] __finish
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_server_manager.py:150:process_finished_status] sender_id = 1, all_client_is_finished = False
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_client_master_manager.py:175:send_client_status] send_client_status
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_client_master_manager.py:176:send_client_status] self.client_real_id = 3
[FedML-Client @device-id-3] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_comm_manager.py:67:finish] __finish
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_comm_manager.py:39:receive_message] receive_message. msg_type = 5, sender_id = 2, receiver_id = 0
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_server_manager.py:163:handle_message_client_status_update] received client status FINISHED
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_server_manager.py:150:process_finished_status] sender_id = 2, all_client_is_finished = False
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_comm_manager.py:39:receive_message] receive_message. msg_type = 5, sender_id = 4, receiver_id = 0
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_server_manager.py:163:handle_message_client_status_update] received client status FINISHED
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_server_manager.py:150:process_finished_status] sender_id = 4, all_client_is_finished = False
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_comm_manager.py:39:receive_message] receive_message. msg_type = 5, sender_id = 5, receiver_id = 0
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_server_manager.py:163:handle_message_client_status_update] received client status FINISHED
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_server_manager.py:150:process_finished_status] sender_id = 5, all_client_is_finished = False
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_comm_manager.py:39:receive_message] receive_message. msg_type = 5, sender_id = 3, receiver_id = 0
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_server_manager.py:163:handle_message_client_status_update] received client status FINISHED
[FedML-Server @device-id-0] [Thu, 02 Nov 2023 22:11:46] [INFO] [fedml_server_manager.py:150:process_finished_status] sender_id = 3, all_client_is_finished = True
```
