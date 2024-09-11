---
sidebar_position: 5
---

# Cluster Management - fedml cluster

## FedML Cluster CLI Overview

Manage clusters on ChainOpera AI Platform

```
Usage: fedml cluster [OPTIONS] COMMAND [ARGS]...

  Manage clusters on ChainOpera AI Platform

Options:
  -h, --help          Show this message and exit.
  -k, --api_key TEXT  The user API key.
  -v, --version TEXT  Version of ChainOpera AI Platform. It should
                      be dev, test or release.

Commands:
  kill      Kill (tear down) clusters from ChainOpera AI Platform.
  killall   Kill (tear down) ALL clusters from ChainOpera AI Platform.
  list      List clusters from ChainOpera AI Platform.
  start     Start clusters from ChainOpera AI Platform.
  startall  Start ALL clusters from ChainOpera AI Platform.
  status    Status of clusters from ChainOpera AI Platform.
  stop      Stop clusters from ChainOpera AI Platform.
  stopall   Stop ALL clusters from ChainOpera AI Platform.
```

### `fedml cluster kill [OPTIONS] [CLUSTER_NAMES]...`

Kill (tear down) clusters from ChainOpera AI Platform.

#### Options

| Option              | Description                                                               |
| ------------------- | ------------------------------------------------------------------------- |
| `--help` or `-h`    | Show this message and exit.                                               |
| `--api_key` or `-k` | The user API key.                                                         |
| `--version` or `-v` | Version of the ChainOpera AI Platform. It should be dev, test or release. |

:::info
Note that kill is different from stop. Clusters once killed cannot be restarted.
:::

#### Example

###### Kill selected clusters on the ChainOpera AI Platform

```
fedml cluster kill demo_cluster
Clusters have been killed.
```

### `fedml cluster killall [OPTIONS]`

Kill (tear down) ALL clusters from ChainOpera AI Platform.

#### Options

| Option              | Description                                                               |
| ------------------- | ------------------------------------------------------------------------- |
| `--help` or `-h`    | Show this message and exit.                                               |
| `--api_key` or `-k` | The user API key.                                                         |
| `--version` or `-v` | Version of the ChainOpera AI Platform. It should be dev, test or release. |

> **_NOTE:_** Note that kill is different from stop. Clusters once killed cannot be restarted.

#### Example

###### Kill ALL clusters on the ChainOpera AI Platform

```
fedml cluster killall

Found the following matching clusters.
+-----------------------+---------------------+------------+
|      Cluster Name     |      Cluster ID     |   Status   |
+-----------------------+---------------------+------------+
|        cluster        | 1706329273733877760 |    IDLE    |
|      test_cluster     | 1709098658206715904 |    IDLE    |
|      demo_cluster     | 1716580036024340480 |    IDLE    |
+-----------------------+---------------------+------------+

Are you sure you want to kill these clusters? [y/N]: y
Clusters have been killed.
```

### `fedml cluster list [OPTIONS] [CLUSTER_NAMES]...`

List clusters from ChainOpera AI Platform.

#### Options

| Option              | Description                                                               |
| ------------------- | ------------------------------------------------------------------------- |
| `--help` or `-h`    | Show this message and exit.                                               |
| `--api_key` or `-k` | The user API key.                                                         |
| `--version` or `-v` | Version of the ChainOpera AI Platform. It should be dev, test or release. |

#### Example

###### List selected clusters from ChainOpera AI Platform

```
fedml cluster list test_cluster demo_cluster


Found the following matching clusters.
+--------------+---------------------+------------+
| Cluster Name |      Cluster ID     |   Status   |
+--------------+---------------------+------------+
| test_cluster | 1709098658206715904 |    IDLE    |
| demo_cluster | 1716580036024340480 | TERMINATED |
+--------------+---------------------+------------+
```

###### List ALL clusters from ChainOpera AI Platform

```
fedml cluster list

Found the following matching clusters.
+-----------------------+---------------------+------------+
|      Cluster Name     |      Cluster ID     |   Status   |
+-----------------------+---------------------+------------+
|        cluster        | 1706329273733877760 |    IDLE    |
|      test_cluster     | 1709098658206715904 |    IDLE    |
|      demo_cluster     | 1716580036024340480 | TERMINATED |
+-----------------------+---------------------+------------+
```

### `fedml cluster start [OPTIONS] [CLUSTER_NAMES]...`

Start clusters from ChainOpera AI Platform.

#### Options

| Option              | Description                                                               |
| ------------------- | ------------------------------------------------------------------------- |
| `--help` or `-h`    | Show this message and exit.                                               |
| `--api_key` or `-k` | The user API key.                                                         |
| `--version` or `-v` | Version of the ChainOpera AI Platform. It should be dev, test or release. |

#### Example

```
fedml cluster start my_cluster

Cluster my_cluster have been started.
```

### `fedml cluster startall [OPTIONS]`

Start ALL clusters from ChainOpera AI Platform.

#### Options

| Option              | Description                                                               |
| ------------------- | ------------------------------------------------------------------------- |
| `--help` or `-h`    | Show this message and exit.                                               |
| `--api_key` or `-k` | The user API key.                                                         |
| `--version` or `-v` | Version of the ChainOpera AI Platform. It should be dev, test or release. |

#### Example

```
fedml cluster startall

Found the following matching clusters.
+----------------------------+---------------------+------------+
|      Cluster Name          |      Cluster ID     |   Status   |
+----------------------------+---------------------+------------+
|      stopped_cluster_1     | 1716572336024340480 |   STOPPED  |
|      stopped_cluster_1     | 1716589476024340480 |   STOPPED  |
+----------------------------+---------------------+------------+
Are you sure you want to start these clusters? [y/N]: y

Clusters have been started.
```

### `fedml cluster status [OPTIONS] CLUSTER_NAME`

Status of clusters from ChainOpera AI Platform.

#### Options

| Option              | Description                                                               |
| ------------------- | ------------------------------------------------------------------------- |
| `--help` or `-h`    | Show this message and exit.                                               |
| `--api_key` or `-k` | The user API key.                                                         |
| `--version` or `-v` | Version of the ChainOpera AI Platform. It should be dev, test or release. |

#### Example

```
fedml cluster status demo_cluster

Found the following matching clusters.
+--------------+---------------------+------------+
| Cluster Name |      Cluster ID     |   Status   |
+--------------+---------------------+------------+
| demo_cluster | 1716580036024340480 | TERMINATED |
+--------------+---------------------+------------+
```

### `fedml cluster stop [OPTIONS] [CLUSTER_NAMES]...`

Stop clusters from ChainOpera AI Platform.

#### Options

| Option              | Description                                                               |
| ------------------- | ------------------------------------------------------------------------- |
| `--help` or `-h`    | Show this message and exit.                                               |
| `--api_key` or `-k` | The user API key.                                                         |
| `--version` or `-v` | Version of the ChainOpera AI Platform. It should be dev, test or release. |

```
fedml cluster stop test_cluster

Cluster test_cluster have been stopped.
```

### `fedml cluster stopall [OPTIONS]`

Stop ALL clusters from ChainOpera AI Platform.

#### Options

| Option              | Description                                                               |
| ------------------- | ------------------------------------------------------------------------- |
| `--help` or `-h`    | Show this message and exit.                                               |
| `--api_key` or `-k` | The user API key.                                                         |
| `--version` or `-v` | Version of the ChainOpera AI Platform. It should be dev, test or release. |

#### Example

```
fedml cluster stopall

Found the following matching clusters.
+-----------------------+---------------------+------------+
|      Cluster Name     |      Cluster ID     |   Status   |
+-----------------------+---------------------+------------+
|       cluster_1       | 1710441695482613760 |    IDLE    |
|       cluster_2       | 1710531574782627840 |    IDLE    |
|       cluster_3       | 1710540968601718784 |    IDLE    |
+-----------------------+---------------------+------------+
Are you sure you want to stop these clusters? [y/N]: y

Clusters have been stopped.
```
