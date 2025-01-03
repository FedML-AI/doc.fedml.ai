---
sidebar_position: 4
---
# Launch Job - fedml launch

### `fedml launch [OPTIONS] YAML_FILE`

Launch jobs on the TensorOpera® Launch platform (fedml.ai).

#### Options

| Option        | Description                                                                                                                                                 |
|---------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <nobr>`--help`</nobr> <br/> or `-h` | Show this message and exit.                                                                                                                                  |
| <nobr>`--cluster`</nobr> <br/> or `-c` | Please provide a cluster name. If a cluster with that name already exists, it will be used; otherwise, a new cluster with the provided name will be created. |
| <nobr>`--api_key`</nobr> <br/> or `-k` | The user API key.                                                                                                                                               |
| <nobr>`--version`</nobr> <br/> or `-v` | The version of the TensorOpera AI Platform. It should be dev, test or release.                                                                                      |
                                                                                                                                                                                                                                                                                                                    

#### Notes

Before launching any job, first, you need to define your job properties in the job yaml file, e.g. entry file, config file, command arguments, etc. The job yaml file is as follows:

```
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
  minimum_num_gpus: 1             # minimum # of GPUs to provision

  # max cost per hour of all machines for your job.
  # E.g., if your job are assigned 2 x A100 nodes (8 GPUs), each GPU cost $1/GPU/Hour, "maximum_cost_per_hour" = 16 * $1 = $16
  maximum_cost_per_hour: $1.75

  allow_cross_cloud_resources: false # true, false
  device_type: GPU              # options: GPU, CPU, hybrid
  resource_type: A100-80G       # e.g., A100-80G, please check the resource type list by "fedml show-resource-type" or visiting URL: https://tensoropera.ai/compute

framework_type: fedml         # options: fedml, deepspeed, pytorch, general
task_type: train              # options: serve, train, dev-environment

# Running entry commands on the server side which will be executed as the job entry point.
# Support multiple lines, which can not be empty.
server_job: |
    echo "Hello, Here is the server job."
    echo "Current directory is as follows."
    pwd
```


You just need to customize the following config items:

1. `workspace`, this is the local directory where your source code resides.

2. `job`, this is the running entry command which will be executed as the job entry point.

3. `bootstrap`, this is the bootstrap shell command which will be executed before running entry commands.

Then you can use the following example CLI to launch the job at the MLOps platform.
(Replace `$YourApiKey` with your own account API key from fedml.ai)

#### Example: Launch job on TensorOpera® Launch platform
 

```
fedml launch hello_job.yaml
```

:::info 
Note that you might be prompted for **API_KEY** the first time you run the command. Please get this key from your account on TensorOpera AI Platform. You can also specify the API_KEY with the `-k` option.
:::


After the launch CLI is executed, you will get the following output prompting for confirmation of resources:

```
Submitting your job to TensorOpera® Launch platform: 100%|████████████████████████████████████████████████████████████████████████████████████████| 6.07k/6.07k [00:01<00:00, 4.94kB/s]

Searched and matched the following GPU resource for your job:
+-----------+-------------------+---------+------------+-------------------------+---------+-------+----------+
|  Provider |      Instance     | vCPU(s) | Memory(GB) |          GPU(s)         |  Region |  Cost | Selected |
+-----------+-------------------+---------+------------+-------------------------+---------+-------+----------+
| FedML Inc | fedml_a100_node_2 |   256   |   2003.9   | NVIDIA A100-SXM4-80GB:8 | DEFAULT | 40.00 |    √     |
+-----------+-------------------+---------+------------+-------------------------+---------+-------+----------+

You can also view the matched GPU resource with Web UI at:
https://tensoropera.ai/launch/confirm-start-job?projectId=1692900612607447040&projectName=default-project&jobId=1716563514434392064

Are you sure to launch it? [y/N]:

```

You can either confirm through terminal or may even open the run url to confirm.
Once resources are confirmed, it will then run your job and you will get the following output:

```
Are you sure to launch it? [y/N]: y

Your launch result is as follows:
+-------------------+---------------------+--------------+---------------------+------------------+------+
|      Run Name     |        Run ID       |    Status    |       Created       | Spend Time(hour) | Cost |
+-------------------+---------------------+--------------+---------------------+------------------+------+
| anseladams_beaver | 1716563514434392064 | PROVISIONING | 2023-10-23 21:13:28 |       None       | 0.0  |
+-------------------+---------------------+--------------+---------------------+------------------+------+

You can track your run details at this URL:
https://tensoropera.ai/run?projectId=1692900612607447040&runId=1716563514434392064

For querying the realtime status of your run, please run the following command.
fedml run logs -rid 1716563514434392064
```

#### Example: Launch job on a cluster on TensorOpera® Launch platform

```
fedml launch hello_job.yaml -c demo_cluster
```


:::info 
Note that if a cluster with provided name already exists, it will be used; otherwise, a new cluster with the provided name will be created.
:::

```
Submitting your job to TensorOpera AI Platform: 100%|██████████████████████████████████████████████████████████████████████████████████████████| 3.48k/3.48k [00:00<00:00, 9.34kB/s]

Searched and matched the following GPU resource for your job:
+-----------+-------------------+---------+------------+-------------------------+---------+-------+----------+
|  Provider |      Instance     | vCPU(s) | Memory(GB) |          GPU(s)         |  Region |  Cost | Selected |
+-----------+-------------------+---------+------------+-------------------------+---------+-------+----------+
| FedML Inc | fedml_a100_node_2 |   256   |   2003.9   | NVIDIA A100-SXM4-80GB:8 | DEFAULT | 40.00 |    √     |
+-----------+-------------------+---------+------------+-------------------------+---------+-------+----------+

You can also view the matched GPU resource with Web UI at:
https://tensoropera.ai/run?projectId=1692900612607447040&runId=1716580465432989696
Do you want to launch the job with the above matched GPU resource? [y/N]: y

Your run result is as follows:
+--------------+---------------------+---------+---------------------+------------------+------+
|   Run Name   |        Run ID       |  Status |       Created       | Spend Time(hour) | Cost |
+--------------+---------------------+---------+---------------------+------------------+------+
| renoir_eagle | 1716580465432989696 | RUNNING | 2023-10-23 22:20:50 |       None       | 0.0  |
+--------------+---------------------+---------+---------------------+------------------+------+

You can track your run details at this URL:
https://tensoropera.ai/run?projectId=1692900612607447040&runId=1716580465432989696

For querying the realtime status of your run, please run the following command.
fedml run logs -rid 1716580465432989696
```