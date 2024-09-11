---
sidebar_position: 8
---

# Python APIs

## FedML Launch API Overview

Simple launcher apis for running any AI job across multiple public and/or decentralized GPU clouds, offering lower prices without cloud vendor lock-in, the highest GPU availability, training across distributed low-end GPUs, and user-friendly Ops to save time on environment setup.

#### Example Usage

```python
import fedml
api_key="YOUR_API_KEY"
yaml_file = "/home/fedml/train.yaml"
login_ret = fedml.api.fedml_login(api_key)
if login_ret == 0:
    launch_result = fedml.api.launch_job(yaml_file)
    if launch_result.result_code == 0:
        print("Job launched successfully")
    else:
        print("Failed to launch job")
```

More about the launch APIs can be found [here](../open-source/api/api-launch#launch-apis)

## FedML Cluster API Overview

APIs to manage clusters on ChainOpera AI Platform

#### Example Usage

```python
import fedml
api_key="YOUR_API_KEY"
yaml_file = "/home/fedml/train.yaml"
cluster_name = "my_cluster"
login_ret = fedml.api.fedml_login(api_key)
if login_ret == 0:
    launch_result = fedml.api.launch_job_on_cluster(yaml_file, cluster=cluster_name)
    if launch_result.result_code == 0:
        print("Job launched successfully on cluster")
        if fedml.api.cluster_stop((cluster_name)):
            print("Cluster stopped successfully")
        else:
            print("Failed to stop cluster")
    else:
        print("Failed to launch job on cluster")
```

More about the cluster APIs can be found [here](../open-source/api/api-launch#cluster-apis)

## FedML Run API Overview

APIs to manage run on ChainOpera AI Platform

#### Example Usage

```python
import fedml
api_key="YOUR_API_KEY"
yaml_file = "/home/fedml/train.yaml"
cluster_name = "my_cluster"
login_ret = fedml.api.fedml_login(api_key)
if login_ret == 0:
    launch_result = fedml.api.launch_job_on_cluster(yaml_file, cluster=cluster_name)
    if launch_result.result_code == 0:
        print("Job launched successfully on cluster")
        run_logs_result = fedml.api.run_logs(run_id=launch_result.run_id)
        run_logs = run_logs_result.run_logs
        for index, log in enumerate(run_logs):
            print(f"Log {index}: {log}")
    else:
        print("Failed to launch job on cluster")
```

More about the run APIs can be found [here](../open-source/api/api-launch#run-apis)
