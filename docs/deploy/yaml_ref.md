---
sidebar_position: 9
---
# Model Configuration YAML

## Full example of a model configuration YAML file
The yaml example below exposes every supported configuration option for creating a model card. 
```yaml
workspace: "./src"
entry_point: "main_entry.py"
bootstrap: |
  echo "Bootstrap start..."
  sh ./config/bootstrap.sh
  echo "Bootstrap finished"
inference_image_name: "fedml/fedml-default-inference-backend"
enable_custom_image: false
image_pull_policy: "IfNotPresent"
docker_registry_user_name: fedml
docker_registry_user_password: passwd
docker_registry: fedml-official
entry_cmd: tritonserver --model-repository=/model
port_inside_docker: 8000
server_external_port: 2204
server_internal_port: 2203
use_gpu: true
use_triton: true
request_input_example: '{"text": "Hello"}'
authentication_token: "myPrivateToken"
data_cache_dir: "~/data_cache"
environment_variables:
  TOP_K: "5"
  PROMPT_STYLE: "llama_orca"
deploy_timeout: 600
auto_detect_public_ip: true
```

## Detailed specification

| Name                                    | Default                                            | Description                                                                                                                                                                     |
|-----------------------------------------|----------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `workspace`                             |                                                    | Directory where your source code directory is located.  [required]                                                                                                              |
| `entry_point`                           |                                                    | Entry point file name. [required]                                                                                                                                               |
| `bootstrap`                             | `""`                                               | Shell commands to install the dependency during setup stage.                                                                                                                    |
| `inference_image_name`                  | `"fedml/fedml-default-inference-backend"`          | The base image for inference container.                                                                                                                                         |
| `enable_custom_image`                   | false                                              | If you used image other than fedml official image, which is listed in [Advanced Features](advanced_features.md), you need to set it to true.                                    |
| `image_pull_policy`                     | `"IfNotPresent"`                                   | When start to deploy / update a endpoint, indicate whether to pull the image (name:tag) again. Could be either "IfNotPresent" or "Always".                                      |
| `docker_registry_user_name / password ` | None                                               | Username password for your docker registry                                                                                                                                      |
| `entry_cmd`                             | None                                               | If you used your own image, here you can indicate the entry cmd(s) for that container.                                                                                          |
| `port_inside_docker`                    | 2345                                               | Inside a container, we default mount 2345 to the host machine port. But if you want to use another port inside container, please indicate here.                                 |
| `worker_port`                           | random                                             | In the host machine, we default randomly open a port and mount to a port inside docker. This might conflict to your firewall policy. So here you can indicate a accessible one. |
| `use_gpu`                               | true                                               | Enable GPUs for inference. Only works for local, on-premise mode, for GPU cloud mode, please specify in `computing`                                                             |
| `use_triton`                            | false                                              | Set to true if your image is a purely provide the triton server service.                                                                                                        |
| `request_input_example`                 | `""`                                               | The input example of the inference endpoint. Will be shown on the UI for reference.                                                                                             |
| `authentication_token`                  | randomly generated by mlops backend                | The authentication_token as a parameter in the inference curl command.                                                                                                          |
| `data_cache_dir`                        | `""`                                               | For on-premise mode, you can indicate a folder that will not be packaged into the model cards. Instead, the worker will read from the host machine.                             |
| `environment_variables`                 | None                                               | Environment variable that can be read in entry_point file.                                                                                                                      |
| `deploy_timeout`                        | 900                                                | Maximum waiting time for endpoint to be established.                                                                                                                            |
| `auto_detect_public_ip`                 | false                                              | For on-premise mode, auto detect the ip of the master and workers public ip.                                                                                                    |
| `computing`                             | None                                               | For gpu cloud mode, indicate the resource you need for inference. You can visiting URL and check: https://TensorOpera.ai/compute/                                               |

