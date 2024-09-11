---
sidebar_position: 6
---

# Experimental Tracking APIs

### `fedml.log()`

**Usage**

```py
fedml.log(
    metrics: dict,
    step: int = None,
    customized_step_key: str = None,
    commit: bool = True) -> None
```

**Arguments**

- `metrics (dict)`: A dictionary object for metrics, e.g., {"accuracy": 0.3, "loss": 2.0}.
- `step (int=None)`: Set the index for current metric. If this value is `None`, then step will be the current global step counter.
- `customized_step_key (str=None)`: Specify the customized step key, which must be one of the keys in the metrics dictionary.
- `commit (bool=True)`: If commit is `False`, the metrics dictionary will be saved to memory and won't be committed until commit is `True`.

**Returns**  
`None`

log dictionary of metric data to the ChainOpera AI Platform.

**Examples**

```py
fedml.log({"ACC": 0.1})
fedml.log({"acc": 0.11})
fedml.log({"acc": 0.2})
fedml.log({"acc": 0.3})

fedml.log({"acc": 0.31}, step=1)
fedml.log({"acc": 0.32, "x_index": 2}, step=2, customized_step_key="x_index")
fedml.log({"loss": 0.33}, customized_step_key="x_index", commit=False)
fedml.log({"acc": 0.34}, step=4, customized_step_key="x_index", commit=True)
```

### `fedml.log_artifact()`

**Usage**

```py
fedml.log_artifact(
    artifact: Artifact,
    version=None,
    run_id=None,
    edge_id=None) -> None
```

**Arguments**

- `artifact (Artifact)`: An artifact object, e.g., file, log, model, etc.
- `version (str=None)`: The version of ChainOpera AI Platform, options: dev, test, release. Default is release (fedml.ai).
- `run_id (str=None)`: Run id for the artifact object. Default is `None`, which will be filled automatically.
- `edge_id (str=None)`: Edge id for current device. Default is `None`, which will be filled automatically.

**Returns**  
`None`

log artifacts to the ChainOpera AI Platform (fedml.ai), such as file, log, model, etc.

**Examples**

```py
artifact = fedml.Artifact(name="general-file", type=fedml.ARTIFACT_TYPE_NAME_GENERAL)
artifact.add_file("./requirements.txt")
artifact.add_dir("./config")
fedml.log_artifact(artifact)

artifact = fedml.Artifact(name="log-file", type=fedml.ARTIFACT_TYPE_NAME_LOG)
artifact.add_file("./log_file")
artifact.add_dir("./log_dir")
fedml.log_artifact(artifact)

artifact = fedml.Artifact(name="source-file", type=fedml.ARTIFACT_TYPE_NAME_SOURCE)
artifact.add_file("./run.py")
artifact.add_dir("./src")
fedml.log_artifact(artifact)

artifact = fedml.Artifact(name="dataset-file", type=fedml.ARTIFACT_TYPE_NAME_DATASET)
artifact.add_file("./mnist.dataset")
artifact.add_dir("./dataset")
fedml.log_artifact(artifact)

artifact = fedml.Artifact(name="model-file", type=fedml.ARTIFACT_TYPE_NAME_MODEL)
artifact.add_file("./cv-model")
artifact.add_dir("./model_dir")
fedml.log_artifact(artifact)
```

### `fedml.log_model()`

**Usage**

```py
fedml.log_model(
    model_name,
    model_file_path,
    version=None) -> None
```

**Arguments**

- `model_name (str)`: model name.
- `model_file_path (str)`: The file path of model name.
- `version (str=None)`: The version of ChainOpera AI Platform, options: dev, test, release. Default is release (fedml.ai).

**Returns**  
`None`

log model to the ChainOpera AI Platform (fedml.ai).

**Examples**

```py
fedml.log_model("cv-model", "./cv-model.bin")
```
