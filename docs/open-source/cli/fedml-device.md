---
sidebar_position: 3
---

# Device Management - fedml device

### `fedml device bind [OPTIONS] [API_KEY]`

#### Options {#options-1}

| Name                                     | Default   | Description                                                                                                                                                                                                                                                                                                                                                                                                              |
| ---------------------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `--version` <br/> or `-v`                | `release` | Bind to which backend environment version of ChainOpera AI Platform. It should be dev, test, or release.                                                                                                                                                                                                                                                                                                                 |
| <nobr>`--computing`</nobr> <br/> or `-c` | `true`    | Bind as the general compute node in ChainOpera AI compute network. This is enabled by default. After binding, you can view and manage the device in the ChainOpera AI Platform: https://tensoropera.ai/compute. It can be grouped as a cluster and then you can use ChainOpera®Launch to schedule any job (training, deployment,federated learning) to it. You can not specify the option `-c` and `-s` simultaneously. |
| `--server` <br/> or `-s`                 | `false`   | Bind as the FedML on-premise parameter server (PS). It can be used for PS-based training paradigms, such as distributed training, cross-cloud training, and federated-learning. You can not specify the option `-c` and `-s` simultaneously for a single environment.                                                                                                                                                    |
| `--provider` <br/> or `-p`               | `false`   | Bind as the FedML compute node (GPU) provider (supplier). This is used by ChainOpera AI Platform - Share and Earn: https://tensoropera.ai/gpu-supplier. You can share your GPUs in this way and earn money. You can specify the option `-p` and `-c` simultaneously (can be used as provider for others as well compute node for your own jobs), but you can not specify `-p` and `-s` simultaneously.                   |

#### Arguments {#argument-1}

| Name      | Default                    | Description                                                                                                        |
| --------- | -------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `API_KEY` | required, no default value | You can find your API Key at https://tensoropera.ai. Click your avatar on top-right area and then click "Profile". |

#### Examples {#example-1}

Bind as a general compute node in ChainOpera AI Cloud:

```
fedml device bind <API_KEY>
```

Bind as a federated-learning server in ChainOpera AI Cloud:

```
fedml device bind -s <API_KEY>
```

Bind as the compute node (GPU) provider (supplier) in ChainOpera AI Cloud:

```
fedml device bind -p <API_KEY>
```

### `Usage: fedml device unbind [OPTIONS]`

#### Options {#options-2}

| Name                                        | Default   | Description                                                                                             |
| ------------------------------------------- | --------- | ------------------------------------------------------------------------------------------------------- |
| <nobr>`--compute_node`</nobr> <br/> or `-c` | `true`    | Unbind from the FedML general compute node.                                                             |
| `--server` <br/> or `-s`                    | `false`   | Unbind from the the FedML on-premise parameter server (PS).                                             |
| `--version` <br/> or `-v`                   | `release` | Unbind which backend environment version of ChainOpera AI Platform. It should be dev, test, or release. |

#### Examples {#example-2}

Unbind from a general compute node in ChainOpera AI Cloud:

```
fedml device unbind -c
```

Unbind from a federated learning server in ChainOpera AI Cloud:

```
fedml device unbind -s
```
