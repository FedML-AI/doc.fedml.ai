---
sidebar_position: 2
---

# Command Line Interfaces (CLIs)

## FEDML Storage CLI Overview

Store and manage data on the TensorOpera® AI Platform. This documentation covers details and examples of how to use these storage commands from a command line interface.

```bash
❯ fedml storage -h
fedml storage [OPTIONS] COMMAND [ARGS]...
  Manage storage on TensorOpera® AI Platform

Options:
  -h, --help          Show this message and exit.
  -k, --api_key TEXT  user api key.
  -v, --version TEXT  specify version of TensorOpera® AI Platform. It should
                      be dev, test or release

Commands:
  delete             Delete data stored on TensorOpera® AI Platform
  download           Download data stored on TensorOpera® AI Platform
  get-metadata       Get metadata of data object stored on TensorOpera® AI Platform...
  get-user-metadata  Get user-defined metadata of data object stored on...
  list               List data stored on TensorOpera® AI Platform
  upload             Upload data on TensorOpera® AI Platform

```

More about the `storage` CLI can be found [here](../open-source/cli/fedml-storage)
