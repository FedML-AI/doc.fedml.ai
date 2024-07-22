---
sidebar_position: 9
---
# Model Configuration YAML
This document describes the configuration options available in the model configuration YAML file. 
The model configuration YAML file is used to define the model card configuration, including the workspace, 
entry point, and other settings.

## Full example of a model configuration YAML file
The yaml example below exposes every supported configuration option for creating a model card. 
```yaml
# Common required fields
workspace: "./src"

# Required fields for fedml based docker image, i.e. starts with fedml/ in the Dockerhub
entry_point: "main_entry.py"

# Required fields for customized docker image
container_run_command: "tritonserver --model-repository=/repo_inside_container"

# Common optional fields
inference_image_name: "fedml/fedml-default-inference-backend"
image_pull_policy: "IfNotPresent"
registry_specs:
    registry_user_name: "fedml"
    registry_user_password: "passwd"
    registry_provider: "DockerHub"
bootstrap: |
  echo "Bootstrap start..."
  sh ./config/bootstrap.sh
  echo "Bootstrap finished"
port: 2345
volume_mounts: 
  - workspace_path: "./path/to/workspace"
    mount_path: "/path/to/container"
environment_variables:
  PROMPT_STYLE: "llama_orca"
readiness_probe:
  httpGet:
    path: "/ready"
service:
  httpPost:
    path: "/predict"
enable_serverless_container: true
deploy_timeout: 600
request_input_example: '{"text": "Hello"}'

# GPU Cloud mode optional fields
endpoint_api_type: "text2text_llm_openai_chat_completions"

# On-premise mode optional fields
use_gpu: true
num_gpus: 1
authentication_token: "myPrivateToken"
```

## Detailed specification

| Name                          | Type (Default Value)                                                                                | Description                                                                                                                                                                                                                                                                                                                                                     |
|-------------------------------|-----------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `workspace`                   | str (Required)                                                                                      | Directory where your source code directory is located.                                                                                                                                                                                                                                                                                                          |
| `entry_point`                 | str (`""`)                                                                                          | Entry point file name, should be a relative path to the workspace.                                                                                                                                                                                                                                                                                              |
| `container_run_command`       | str or list of str (`""`)                                                                           | For customized image, you can indicate the run command, similar to `docker run` command.                                                                                                                                                                                                                                                                        |
| `inference_image_name`        | str (`"fedml/fedml-default-inference-backend"`)                                                     | The base image for inference container.                                                                                                                                                                                                                                                                                                                         |
| `image_pull_policy`           | str (`"IfNotPresent"`)                                                                              | When start to deploy / update a endpoint, indicate whether to pull the image (name:tag) again. Could be either "IfNotPresent" or "Always".                                                                                                                                                                                                                      |
| `registry_specs`              | Dict (`{"registry_user_name": "", "registry_user_password": "", "registry_provider": "DockerHub"}`) | Username, password for private registry (e.g. DockerHub), currently only support DockerHub                                                                                                                                                                                                                                                                      |
| `bootstrap`                   | str (`""`)                                                                                          | Shell commands to install the dependency in the base image before the endpoint starting.                                                                                                                                                                                                                                                                        |
| `port`                        | int (2345)                                                                                          | The service port that been listened to inside the docker.                                                                                                                                                                                                                                                                                                       |
| `volume_mounts`               | Dict (`{"workspace_path": "./path/to/workspace", "mount_path": "/path/to/container"}` )             | `workspace_path` indicate the file / directory's relative path to the model card workspace. `mount_path` indicate the path inside the docker container.                                                                                                                                                                                                         |
| `environment_variables`       | Dict (`{}`)                                                                                         | Environment variables inside the docker container.                                                                                                                                                                                                                                                                                                              |
| `readiness_probe`             | Dict (`{"httpGet": {"path": "/ready"}}`)                                                            | For customized image, indicate command to check the readiness of the service inside the container.                                                                                                                                                                                                                                                              |
| `service`                     | Dict (`{"httpPost": {"path": "/predict"}}`)                                                         | For customized image, indicate the main service path for inference. If you want to open multiple, then enabled `enable_serverless_container`                                                                                                                                                                                                                    |
| `enable_serverless_container` | bool (false)                                                                                        | For customized image, if you want to route all the subdomain, set to true. e.g. localhost:2345/{all-subdomain}, then you do not need to set `service`                                                                                                                                                                                                           |
| `deploy_timeout`              | int (900)                                                                                           | Maximum waiting time for endpoint to be established (Checked by container readiness probe).                                                                                                                                                                                                                                                                     | |
| `request_input_example`       | Dict (`{"text": "What is a good cure for hiccups?"}`)                                               | The input example of the inference endpoint. Will be shown on the UI for reference.                                                                                                                                                                                                                                                                             |
| `endpoint_api_type`           | str (`"general"`)                                                                                   | Related to the UI representation and price counting. Enum of ["text2text_llm_openai_chat_completions", "text2text_llm_openai_completions", "text2image", "text2video", "text2audio", "text23D", "image2image", "image2audio", "image2video", "image23D", "image_stylization", "image2text", "text_embedding", "text2sql_llm_openai_completions", "audio2text"]  |
| `use_gpu`                     | bool (true)                                                                                         | For on-premise mode, specify whether to use GPU for inference.                                                                                                                                                                                                                                                                                                  |
| `num_gpus`                    | int (1)                                                                                             | For on-premise mode, specify how many gpu to use.                                                                                                                                                                                                                                                                                                               |
| `authentication_token`        | str (`""`)                                                                                          | The authentication_token as a parameter in the inference curl command.                                                                                                                                                                                                                                                                                          |

