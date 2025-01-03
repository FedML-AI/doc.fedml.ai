---
sidebar_position: 10
---

# TensorOpera Model CLI Overview

```
Usage: fedml model [OPTIONS] COMMAND [ARGS]...

  FedML Model CLI will help you manage the model cards, whether it is in local
  environment or at TensorOpera® AI platform. It also helps you to deploy the
  model cards to different devices, and manage the endpoints that created from
  model cards.

Options:
  -h, --help  Show this message and exit.

Commands:
  create   Create a model card in local environment.
  push     Push a model card (local or S3) to remote.
  deploy   Deploy model to the local | on-premise | GPU Cloud.
  run      Request a model inference endpoint.
  pull     Pull a model card from TensorOpera® AI Platform to local.
  list     List model card(s) at local environment or TensorOpera® AI Platform.
  delete   Delete a local or remote model card.
  package  Pakcage a local or remote model card.
```

A specific cli list and explanation can be found at [TensorOpera model cli](../open-source/cli/fedml-model.md).
