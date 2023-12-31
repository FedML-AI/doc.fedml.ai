---
sidebar_position: 1
---

# Introduction

FEDML Open Source library : https://github.com/FedML-AI/FedML/


**FEDML®Launch: a super launcher and scheduler for running any AI jobs in Any GPU Clouds or On-prem Cluster:**

- `fedml/computing/scheduler` -- FEDML®Launch: a unified launcher and scheduler for running any AI jobs across any GPU clouds and on-prem cluster.

**FEDML®Deploy: model deployment**:

- `fedml/serving` -- FEDML®Deploy: scalable model serving and deployment
- `fedml/serving/scalellm` - an efficient engine for scaling LLM in low-memory GPUs

**FEDML®Train: model training and observability**:

- `fedml/train` -- training framework, especially for LLM and generative AIs
  - `fedml/train/cross_cloud` -- cross-cloud distributed training, a spotlight project for it is "UnitedLLM"
  - `fedml/train/llm` -- LLM training and fine-tuning
- `fedml/core/mlops` -- training experimental tracking: logging and observability

**FEDML®Federate: federated learning and analytics framework**:

- `fedml/cross_device` -- cross-device federated learning (FL), tailored for the smartphone-based FL
- `fedml/cross_silo` -- cross-silo federated learning
- `fedml/simulation` -- simulator for federated learning
- `fedml/fa` -- federated analytics

`fedml/api` -- FEDML public Python APIs: fedml.api._, including APIs for launch, training, deployment, and federated learning. Note: at this stage, it doesn't cover all FEDML APIs; some others are in fedml.core._ and fedml.\*.

`fedml/cli` -- command line interface (CLIs) implementation for FEDML library

`fedml/core` -- core modules shared by all training, deployment, and federated learning frameworks, including features related to communication backend, security/privacy, design pattern, logging, etc.

`fedml/mlops` -- MLOps (Nexus AI) related features

`fedml/device` -- GPU placement and management

`fedml/data` -- prebuilt data loaders

`fedml/model` -- prebuilt models

`fedml/ml` -- integrating with many other general machine learning frameworks

`fedml/utils` -- common utilities

**FEDML Spotlight Projects:**

- `FedML/python/spotlight_prj/UnitedLLM` -- a cross-cloud distributed training framework for large-scale language models (LLMs)
- `FedML/python/spotlight_prj/FedLLM` -- a federated learning framework for LLMs

and more...

**FEDML Examples (Prebuilt Jobs in Jobs Store):**

- `FedML/python/examples` -- examples for training, deployment, and federated learning
  - `FedML/python/examples/launch` -- examples for FEDML®Launch
  - `FedML/python/examples/serving` -- examples for FEDML®Deploy
  - `FedML/python/examples/train` -- examples for FEDML®Train
  - `FedML/python/examples/cross_cloud` -- examples for FEDML®Train cross-cloud distributed training
  - `FedML/python/examples/federate/prebuilt_jobs` -- examples for federated learning prebuilt jobs (FedCV, FedNLP, FedGraphNN, Healthcare, etc.)
  - `FedML/python/examples/federate/cross_silo` -- examples for cross-silo federated learning
  - `FedML/python/examples/federate/cross_device` -- examples for cross-device federated learning
  - `FedML/python/examples/federate/simulation` -- examples for federated learning simulation
  - `FedML/python/examples/federate/security` -- examples for FEDML®Federate security related features
  - `FedML/python/examples/federate/privacy` -- examples for FEDML®Federate privacy related features
  - `FedML/python/examples/federate/federated_analytics` -- examples for FEDML®Federate federated analytics (FA)
