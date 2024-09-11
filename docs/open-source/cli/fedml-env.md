---
sidebar_position: 10
---

# Environment Checking - fedml env

### `fedml env`

Do a sanity check of the ChainOpera library's current running environment information, including versions of the library, OS, CPU/GPU hardwares and network connectivity (HTTPS, S3, MQTT).

#### Options {#options}

| Name                                   | Default   | Description                                                                                                                                                               |
| -------------------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <nobr>`--version`</nobr> <br/> or `-v` | `release` | The backend environment of ChainOpera AI Cloud. It supports values: `local`, `dev`, `test`, `release`. This is normally used by ChainOpera team for internal development. |

:::info

If the environment setup is correct, `fedml env` will print a message similar as follows:

```

======== FedML (https://tensoropera.ai) ========
FedML version: 0.8.8a153
FedML ENV version: release
Execution path:/Users/chaoyanghe/sourcecode/FedML-inc/FedML-all-in-one-dev/FedML/python/fedml/__init__.py

======== Running Environment ========
OS: macOS-13.4-arm64-arm-64bit
Hardware: arm64
Python version: 3.9.15 | packaged by conda-forge | (main, Nov 22 2022, 08:48:25)
[Clang 14.0.6 ]
PyTorch version: 2.0.1
MPI4py is installed

======== CPU Configuration ========
The CPU usage is : 35%
Available CPU Memory: 24.8 G / 64.0G

======== GPU Configuration ========
No GPU devices

======== Network Connection Checking ========
The connection to https://tensoropera.ai is OK.

The connection to S3 Object Storage is OK.

The connection to mqtt.fedml.ai (port:1883) is OK.
```

:::
