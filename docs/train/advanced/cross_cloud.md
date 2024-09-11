---
sidebar_position: 1
---

# Cross-cloud Training

[ChainOpera® UnitedLLM](https://github.com/FedML-AI/FedML/tree/master/python/spotlight_prj/unitedllm)
is an MLOps-supported training pipeline for decentralized pretraining and finetuning of large language models.

## Getting Started

Clone the repo then go to UnitedLLM directory:

```shell
# clone the repo and the submodules
git clone https://github.com/FedML-AI/FedML.git -b unitedllm

# go to the project directory
cd python/spotlight_prj/unitedllm

# Install dependencies
pip install -r requirements.txt

# Update the repo
git pull

# Download the example datasets.
bash scripts/setup.sh
```

## Conventional/Centralized Training

See [LLM Train examples](https://github.com/FedML-AI/FedML/tree/master/python/examples/train/llm_train) for details.

## Decentralized Cross-cloud Training with FedML

### 1. Install FedML

Install FedML with the following command

```shell
pip install fedml
```

### 2. Prepare a Configuration File

To train/fine-tune in decentralized setting, you need to provide a FedML config file.
A concrete example can be found in `fedml_config/fedml_config.yaml`.

```yaml
common_args:
  training_type: 'cross_cloud' # decentralized training type, we recommend `cross_cloud` for LLMs
  scenario: 'horizontal' # decentralized training scenario, we recommend `horizontal` for LLMs
  use_customized_hierarchical: True # if `True`, will use customized hierarchical cross-cloud; this could improve the training stability
  random_seed: 0

environment_args:
  bootstrap: fedml_config/bootstrap.sh # change to "config/bootstrap.sh" when using MLOps
  launcher: 'auto' # program launcher, choose from `auto`, `torch`, `deepspeed`

data_args:
  dataset: 'databricks-dolly' # dataset name; this setting is required for FedML built-in datasets
  dataset_name: 'fedml/databricks-dolly-15k-niid'
  dataset_path: []
  client_dataset_path: []
  test_dataset_size: 200 # this is ignored when `dataset_path` has more than 1 element
  remove_long_seq: True # if `True` remove all data whose sequence length > max_seq_length
  truncate_long_seq: True # if `True` truncate long sequences whose length > max_seq_length

model_args:
  skip_log_model_net: True # toggle auto model input shape inference; if set to `False`, could slow down the training
  model_name_or_path: 'EleutherAI/pythia-70m' # choose any decoder-only hugging face model
  # need to install `flash_attn` package first, see https://github.com/Dao-AILab/flash-attention for detail
  use_flash_attention: False
  load_pretrained: False # Whether to load pretrained weights
  # PEFT configs
  peft_type: 'lora'

train_args:
  federated_optimizer: 'FedAvg'
  client_optimizer: 'adamw_torch'
  server_optimizer: 'FedAvg'
  client_num_in_total: 2 # number of clients
  client_num_per_round: 2 # choose from 1~client_num_in_total
  comm_round: 5 # number of rounds of aggregation
  # below are the same as HuggingFace settings
  deepspeed: 'configs/deepspeed/ds_z3_bf16_config.json'
  ddp_find_unused_parameters: False
  seed: 1234
  fp16: False
  bf16: False
  gradient_checkpointing: True
  per_device_train_batch_size: 8
  per_device_eval_batch_size: 8
  gradient_accumulation_steps: 1
  eval_accumulation_steps: 4
  learning_rate: 3.0e-4
  warmup_steps: 50
  output_dir: '.logs/UnitedLLM/{run_id}'
  logging_steps: 20
  eval_steps: 200
  save_steps: 200
  save_total_limit: 10
  logging_strategy: 'no'
  evaluation_strategy: 'no' # should be turned off
  save_strategy: 'no'
  save_on_each_node: True
  # extra options
  # model weights type.
  model_dtype: 'fp32' # choose from "bf16" | "fp16" | "fp32"
  # number of training epoch for each communication round, total epoch is local_num_train_epochs * comm_round
  local_num_train_epochs: 1
  # number of training steps for each communication round, total step is local_max_steps * comm_round;
  #   this option overwrites `local_num_train_epochs`; set to a non-positive value to disable it.
  local_max_steps: 200

validation_args:
  frequency_of_the_test: 1
  test_on_clients: 'after_aggregation' # choose from "before_aggregation" | "after_aggregation" | "no" | "both"
  is_aggregator_test: False # set to `True` to enable testing on aggregator after each aggregation
  test_on_client_ranks: [1] # the rank of the clients to run test
  # Number of updates steps before two checkpoint saves. Set to 0 to disable saving. Set to a negative number or
  # null to save after every test (i.e. same as `frequency_of_the_test`).
  save_frequency: null

device_args:
  using_gpu: True

comm_args:
  backend: 'MQTT_S3'
  is_mobile: 0

tracking_args:
  enable_wandb: False
  wandb_only_server: True
```

### 3. Run FedML

To launch an experiment, a `RUN_ID` should be provided. For each experiment, the same `RUN_ID` should
be used across all the client(s) and aggregator server.
For clients, `client_rank` is also required. Each client should have a unique `client_rank` and
the value should be in range from 1 to N where N is the number of clients.
`client_rank` is the distributed rank which is similar to an index in an array; each client can be
"indexed" by its rank.

> **Note**
> since we use `RUN_ID` to uniquely identify experiments, we recommend that you carefully choose the `RUN_ID`.
> You may also generate a UUID for your `RUN_ID` with built-in Python module `uuid`;
> e.g. use `RUN_ID="$(python3 -c "import uuid; print(uuid.uuid4().hex)")"` in your shell script.

Example scripts:

```shell
# run aggregator server
bash scripts/run_fedml_server.sh "$RUN_ID"

# run client(s)
bash scripts/run_fedml_client.sh 1 "$RUN_ID"
bash scripts/run_fedml_client.sh 2 "$RUN_ID"
bash scripts/run_fedml_client.sh 3 "$RUN_ID"
...
```

_See ChainOpera® FedML's [Getting Started](https://docs.tensoropera.ai/federate/getting_started) for details._

# Use ChainOpera AI for Scalable Experiments

Please refer to https://github.com/FedML-AI/FedML/tree/master/python/spotlight_prj/unitedllm
