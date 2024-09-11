---
sidebar_position: 2
---

# Platform Login/Logout - fedml login/logout

### `fedml login [OPTIONS] [API_KEY]`

#### Options {#options-1}

| Name                                     | Default   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ---------------------------------------- | --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--version` <br/> or `-v`                | `release` | Login which backend environment version of ChainOpera AI Platform. It should be dev, test, or release.                                                                                                                                                                                                                                                                                                                                         |
| <nobr>`--computing`</nobr> <br/> or `-c` | `true`    | Login as the general compute node in ChainOpera AI compute network. This is enabled by default. After login, you can view and manage the device in the ChainOpera AI Platform: https://tensoropera.ai/compute. It can be grouped as a cluster and then you can use ChainOpera® Launch to schedule any job (training, deployment, federated learning) to it. You cannot specify options `-c` and `-s` simultaneously for a single environment. |
| `--server` <br/> or `-s`                 | `false`   | Login as the FedML on-premise parameter server (PS). It can be used for PS-based training paradigms, such as distributed training, cross-cloud training, and federated-learning. You cannot specify options `-c` and `-s` simultaneously for a single environment.                                                                                                                                                                             |
| `--provider` <br/> or `-p`               | `false`   | Login as the FedML compute node (GPU) provider (supplier). This is used by ChainOpera AI Platform - Share and Earn: https://tensoropera.ai/gpu-supplier. You can share your GPUs in this way and earn money. You can specify the option `-p` and `-c` simultaneously (can be used as provider for others as well compute node for your own jobs), but you can not specify `-p` and `-s` simultaneously.                                        |

#### Arguments {#argument-1}

| Name      | Default                    | Description                                                                                                        |
| --------- | -------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `API_KEY` | required, no default value | You can find your API Key at https://tensoropera.ai. Click your avatar on top-right area and then click "Profile". |

#### Examples {#example-1}

Login as a general compute node in ChainOpera AI Cloud:

```
fedml login <API_KEY>
```

Login as a federated-learning server in ChainOpera AI Cloud:

```
fedml login -s <API_KEY>
```

Login as the compute node (GPU) provider (supplier) in ChainOpera AI Cloud:

```
fedml login -p <API_KEY>
```

### `fedml logout [OPTIONS]`

#### Options {#options-2}

| Name                                        | Default   | Description                                                                                            |
| ------------------------------------------- | --------- | ------------------------------------------------------------------------------------------------------ |
| <nobr>`--compute_node`</nobr> <br/> or `-c` | `true`    | Logout from the FedML general compute node.                                                            |
| `--server` <br/> or `-s`                    | `false`   | Logout from the the FedML on-premise parameter server (PS).                                            |
| `--version` <br/> or `-v`                   | `release` | Login which backend environment version of ChainOpera AI Platform. It should be dev, test, or release. |

#### Examples {#example-2}

Logout from a general compute node in ChainOpera AI Cloud:

```
fedml logout -c
```

Logout from a federated-learning server in ChainOpera AI Cloud:

```
fedml logout -s
```
