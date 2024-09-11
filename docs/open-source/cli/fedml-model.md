---
sidebar_position: 8
---

# Model Deployment - fedml model

![OnPremDevices.jpg](pics%2FCLIsWorkflow.png)

## FedML Model CLI Overview

```
Usage: fedml model [OPTIONS] COMMAND [ARGS]...

Options:
  -h, --help  Show this message and exit.

Commands:
  create  Create a model card in local environment.
  push    Push a model card (local or S3) to remote.
  deploy  Deploy model to the local | on-premise | GPU Cloud.
  run     Request a model inference endpoint.
  pull    Pull a model card from ChainOpera AI Platform to local.
  list    List model card(s) at local environment or ChainOpera AI Platform.
  delete  Delete a local or remote model card.
```

### `fedml model create [OPTIONS]`

Create a model card in local environment.

#### Options {#options-1}

| Name                      | Default   | Description                                                  |
| ------------------------- | --------- | ------------------------------------------------------------ |
| `--name` or `-n`          |           | Model Card name. [required]                                  |
| `--model` or `-m`         | `None`    | Indicate a pre-built model from Hugging Face or GitHub       |
| `--model_config` or `-cf` | `None`    | Yaml file path that will be used to create a new model card. |
| `--version` or `-v`       | `release` | The backend environment of ChainOpera AI Cloud.              |

#### Examples {#example-1}

##### Create a model card using a pre-built model.

```
fedml model create -n my_model -m hf:EleutherAI/pythia-70m
```

##### Create a model card using a model config yaml file.

```
fedml model create -n my_model -cf my_model_config.yaml
```

### `fedml model deploy [OPTIONS]`

Deploy model to the Local | On-premise | GPU Cloud.

#### Options {#options-1}

| Name                   | Default   | Description                                                                                                                     |
| ---------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `--name` or `-n`       |           | Model Card name. [required]                                                                                                     |
| `--local` or `-l`      |           | Deploy model locally. [is-flag]                                                                                                 |
| `--master_ids` or `-m` | `None`    | Device Id(s) for on-premise master node(s).                                                                                     |
| `--worker_ids` or `-w` | `None`    | Device Id(s) for on-premise worker node(s).                                                                                     |
| `--version` or `-v`    | `release` | The backend environment of ChainOpera AI Cloud.                                                                                 |
| `--use_remote` or `-r` | `False`   | Use a remote model card. [is-flag] <br/> If not specify, fedml will first push your local model card to remote, then deploy it. |
| `--delete` or `-d`     | `""`      | Indicate an Endpoint ID to be deleted.                                                                                          |

#### Examples {#example-1}

##### Deploy a model in local environment.

```
fedml model deploy -n my_model --local
```

##### Deploy a model card to GPU Cloud.

```
fedml model deploy -n my_model
```

##### Deploy a model card to on-premise device.

login your device to ChainOpera AI Platform.

```
fedml login $api_key
```

Check your device id for master role and worker role.

```
Welcome to FedML.ai!
Start to login the current device to the ChainOpera AI Platform

Congratulations, your device is connected to the ChainOpera AI platform successfully!
Your FedML Edge ID is xxx, unique device ID is xxx, master deploy ID is 31240, worker deploy ID is 31239
```

From above, we can know that the master ID is 31240, worker deploy ID is 31239

For single machine deploy, mention 31240 for master and 31239 for worker.

```
fedml model deploy -n my_model -m 31240 -w 31239
```

##### Delete an endpoint using endpoint id

To Delete an endpoint, you can use `fedml model deploy -d $endpoint_id`.

```
fedml model deploy -d 1215
```

```
Are you sure to delete the model endpoint: 1215 [y/N]: y

Model endpoint 1215 deleted successfully.
```

### `fedml model run [OPTIONS] JSON_STRING`

Request the endpoint using a JSON string.

#### Options {#options-1}

| Name                 | Default   | Description                                                |
| -------------------- | --------- | ---------------------------------------------------------- |
| `--endpoint` or `-e` |           | Endpoint ID. [required]                                    |
| `JSON_STRING`        |           | Json string used to request the model endpoint. [required] |
| `--version` or `-v`  | `release` | The backend environment of ChainOpera AI Cloud.            |

#### Examples {#example-1}

##### Query a LLM Model from ChainOpera AI Platform.

```
fedml model run -e 1215 '{"text": "What is a good cure for hiccups?"}'
```

Response:

```
Result: {"generated_text": {"generated_text": "Solved by add ..."}}
```

### `fedml model push [OPTIONS]`

Push a model card (local or S3) to remote.

#### Options {#options-1}

| Name                          | Default   | Description                                     |
| ----------------------------- | --------- | ----------------------------------------------- |
| `--name` or `-n`              |           | Model Card name. [required]                     |
| `--model_storage_url` or `-s` | `None`    | A S3 address to the model card zip file.        |
| `--version` or `-v`           | `release` | The backend environment of ChainOpera AI Cloud. |

#### Examples {#example-1}

##### Push a local model card to ChainOpera AI Platform.

```
fedml model push -n my_model
```

### `fedml model pull [OPTIONS]`

Pull a model card from ChainOpera AI Platform to local.

#### Options {#options-1}

| Name                | Default   | Description                                     |
| ------------------- | --------- | ----------------------------------------------- |
| `--name` or `-n`    |           | Model Card name. [required]                     |
| `--version` or `-v` | `release` | The backend environment of ChainOpera AI Cloud. |

#### Examples {#example-1}

##### Pull a local model card from ChainOpera AI Platform.

```
fedml model pull -n my_model
```

### `fedml model list [OPTIONS]`

List model card(s) at local environment or ChainOpera AI Platform.

#### Options {#options-1}

| Name                | Default   | Description                                     |
| ------------------- | --------- | ----------------------------------------------- |
| `--name` or `-n`    | `"*"`     | Model Card name(s).                             |
| `--local` or `-l`   |           | List Local Model. [isflag]                      |
| `--version` or `-v` | `release` | The backend environment of ChainOpera AI Cloud. |

#### Examples {#example-1}

##### List all model cards from ChainOpera AI Platform.

```
fedml model list
```

##### List all local model cards.

```
fedml model list -l
```

##### List two model cards at ChainOpera AI Platform.

```
fedml model list -n my_model, my_model2
```

### `fedml model delete [OPTIONS]`

Delete a local or remote model card.

#### Options {#options-1}

| Name                | Default   | Description                                     |
| ------------------- | --------- | ----------------------------------------------- |
| `--name` or `-n`    |           | Model Card name. [required]                     |
| `--local` or `-l`   |           | Delete a Local Model. [isflag]                  |
| `--version` or `-v` | `release` | The backend environment of ChainOpera AI Cloud. |

#### Examples {#example-1}

##### Delete a model card from ChainOpera AI Platform.

```
fedml model delete -n my_model
```

##### Delete a local model card.

```
fedml model delete -n my_model -l
```
