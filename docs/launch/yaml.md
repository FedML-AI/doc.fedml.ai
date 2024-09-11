---
sidebar_position: 6
---

# Job YAML

## Minimalist `Job.yaml`

```yaml title="job.yaml"
# Local directory where your source code resides.
# It should be the relative path to this job yaml file.
# If your job doesn't contain any source code, it can be empty.
workspace: hello_world

# Bootstrap shell commands which will be executed before running entry commands.
# Support multiple lines, which can be empty.
bootstrap: |
  pip install -r requirements.txt
  echo "Bootstrap finished."

# Running entry commands which will be executed as the job entry point.
# If an error occurs, you should exit with a non-zero code, e.g. exit 1.
# Otherwise, you should exit with a zero code, e.g. exit 0.
# Support multiple lines, which can not be empty.
job: |
  echo "Hello, Here is the launch platform."
  echo "Current directory is as follows."
  pwd
  python hello_world.py

computing:
  minimum_num_gpus: 1 # minimum # of GPUs to provision
  # max cost per hour of all machines for your job.
  # E.g., if your job are assigned 2 x A100 nodes (8 GPUs), each GPU cost $1/GPU/Hour, "maximum_cost_per_hour" = 16 * $1 = $16
  maximum_cost_per_hour: $1.75
```

:::tip Tip
For most cases, you just need to use the above minimalist `job.yaml` with following four properties:

1. `workspace`, It is the local directory where your source code resides.
2. `job`, It is the running entry command which will be executed as the job entry point.
3. `bootstrap`, It is the bootstrap shell command which will be executed before running entry commands.
4. `computing`, It is the computing resource configuration for your job.
   :::

## Fully loaded `Job.yaml`

Below is `job.yaml` loaded with all properties. You can use it as a reference to create your own `job.yaml` tailored to your specific needs.

```yaml title="job.yaml"
fedml_env:
  project_name:

# Local directory where your source code resides.
# It should be the relative path to this job yaml file or the absolute path.
# If your job doesn't contain any source code, it can be empty.
workspace: hello_world

# Running entry commands which will be executed as the job entry point.
# If an error occurs, you should exit with a non-zero code, e.g. exit 1.
# Otherwise, you should exit with a zero code, e.g. exit 0.
# Support multiple lines, which can not be empty.
job: |
  echo "Hello, Here is the launch platform."
  echo "Current directory is as follows."
  pwd
  python hello_world.py

# Bootstrap shell commands which will be executed before running entry commands.
# Support multiple lines, which can be empty.
bootstrap: |
  pip install -r requirements.txt
  echo "Bootstrap finished."

computing:
  minimum_num_gpus: 1 # minimum # of GPUs to provision

  # max cost per hour of all machines for your job.
  # E.g., if your job are assigned 2 x A100 nodes (8 GPUs), each GPU cost $1/GPU/Hour, "maximum_cost_per_hour" = 16 * $1 = $16
  maximum_cost_per_hour: $1.75

  allow_cross_cloud_resources: false # true, false
  device_type: GPU # options: GPU, CPU, hybrid
  resource_type: A100-80G # e.g., A100-80G, please check the resource type list by "fedml show-resource-type" or visiting URL: https://tensoropera.ai/accelerator_resource_type

job_type: train # options: train, deploy, federate
framework_type: fedml # options: fedml, deepspeed, pytorch, general

# train subtype: general_training, single_machine_training, cluster_distributed_training, cross_cloud_training
# federate subtype: cross_silo, simulation, web, smart_phone
# deploy subtype: none
job_subtype: general_training

# Running entry commands on the server side which will be executed as the job entry point.
# Support multiple lines, which can not be empty.
server_job: |
  echo "Hello, Here is the server job."
  echo "Current directory is as follows."
  pwd

# If you want to use the job created by the MLOps platform,
# just uncomment the following three, then set job_id and config_id to your desired job id and related config.
#job_args:
#  job_id: 2070
#  config_id: 111

# If you want to create the job with specific name, just uncomment the following line and set job_name to your desired job name.
#job_name: cv_job

# If you want to pass your API key to your job for calling ChainOpera APIs, you may uncomment the following line and set your API key here.
# You may use the environment variable FEDML_RUN_API_KEY to get your API key in your job commands or scripts.
#run_api_key: my_api_key

# If you want to use the model created by the MLOps platform or create your own model card with a specified name,
# just uncomment the following four lines, then set model_name to your desired model name or set your desired endpoint name
#serving_args:
#  model_name: "fedml-launch-sample-model" # Model card from MLOps platform or create your own model card with a specified name
#  model_version: "" # Model version from MLOps platform or set as empty string "" which will use the latest version.
#  endpoint_name: "fedml-launch-endpoint" # Set your end point name which will be deployed, it can be empty string "" which will be auto generated.

# Dataset related arguments
fedml_data_args:
  dataset_name: mnist
  dataset_path: ./dataset
  dataset_type: csv

# Model related arguments
fedml_model_args:
  input_dim: '784'
  model_cache_path: /Users/alexliang/fedml_models
  model_name: lr
  output_dim: '10'
```
