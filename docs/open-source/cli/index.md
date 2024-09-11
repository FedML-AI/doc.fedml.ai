---
sidebar_position: 1
description: ChainOpera provides a set of CLIs to help you develop, launch, train, and deploy your model.
---

# CLI Overview

ChainOpera provides a set of CLIs to help you develop, launch, train, and deploy your model. To get the latest version of the CLI, run `fedml -h` or `fedml --help`:

```
Usage: fedml [OPTIONS] COMMAND [ARGS]...

Options:
  -h, --help  Show this message and exit.

Commands:
  login     Login the ChainOpera AI Platform.
  logout    Logout from the ChainOpera AI Platform.
  launch    Launch job at the ChainOpera AI platform.
  cluster   Manage clusters on ChainOpera AI Platform.
  run       Manage runs on the ChainOpera AI Platform.
  device    Bind/unbind devices to the ChainOpera AI Platform.
  model     Deploy and infer models.
  build     Build packages for the ChainOpera AI Platform.
  logs      Display logs for ongoing runs.
  train     Manage training resources on ChainOpera AI Platform.
  federate  Manage federated learning resources on ChainOpera AI Platform.
  env       Get environment info such as versions, hardware, and networking.
  network   Check the ChainOpera AI backend network connectivity.
  version   Display ChainOpera library version.
```

:::tip
Before you run any CLI command, it's better to do a sanity check of your environment setup by running `fedml env`. You will get versions of the library, OS, CPU/GPU hardwares and network connectivity.
:::

All CLI commands and their usages are as follows:
