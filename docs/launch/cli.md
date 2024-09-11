---
sidebar_position: 7
---

# Command Line Interfaces (CLIs)

## FedML Launch CLI Overview

Launch jobs on the ChainOpera® Launch platform (fedml.ai).

```bash
❯ fedml launch -h
fedml launch [OPTIONS] YAML_FILE
  Launch job at the ChainOpera AI platform

Options:
  -h, --help          Show this message and exit.
  -c, --cluster TEXT  If a cluster name is specified, you labelled the
                      searched resource by launch with the cluster name. So
                      later you can reuse the same cluster resource without
                      warmup after the first launch. The cluster can be
                      stopped by CLI: fedml cluster stop, or it would be
                      automatically stopped after 15-minute idle time.
  -k, --api_key TEXT  user api key.
  -v, --version TEXT  version of ChainOpera AI Platform. It should be dev,
                      test or release. Default is release.
```

More about the `launch` CLI can be found [here](../open-source/cli/fedml-launch)

## FedML Cluster CLI Overview

Manage clusters on ChainOpera AI Platform

```
Usage: fedml cluster [OPTIONS] COMMAND [ARGS]...

  Manage clusters on ChainOpera AI Platform

Options:
  -h, --help          Show this message and exit.
  -k, --api_key TEXT  user api key.
  -v, --version TEXT  specify version of ChainOpera AI Platform. It should
                      be dev, test or release

Commands:
  kill      Kill (tear down) clusters from ChainOpera AI Platform
  killall   Kill (tear down) ALL clusters from ChainOpera AI Platform
  list      List clusters from ChainOpera AI Platform
  start     Start clusters from ChainOpera AI Platform
  startall  Start ALL clusters from ChainOpera AI Platform
  status    Status of clusters from ChainOpera AI Platform
  stop      Stop clusters from ChainOpera AI Platform
  stopall   Stop ALL clusters from ChainOpera AI Platform
```

More about the `cluster` CLI can be found [here](../open-source/cli/fedml-cluster)

## FedML Run CLI Overview

Manage runs on the ChainOpera AI Platform

```
Usage: fedml run [OPTIONS] COMMAND [ARGS]...

  Manage runs on the ChainOpera AI Platform.

Options:
  -h, --help            Show this message and exit.
  -k, --api_key TEXT    user api key.
  -v, --version TEXT    version of ChainOpera AI Platform. It should be dev,
                        test or release
  -pf, --platform TEXT  The platform name at the ChainOpera AI Platform
                        (options: octopus, parrot, spider, beehive, falcon,
                        launch, default is falcon).

Commands:
  list    List runs from the ChainOpera AI Platform.
  logs    Get logs of run from the ChainOpera AI Platform.
  status  Get status of run from the ChainOpera AI Platform.
  stop    Stop a run from the ChainOpera AI Platform.
```

More about the `run` CLI can be found [here](../open-source/cli/fedml-run)
