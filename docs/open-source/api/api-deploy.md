---
sidebar_position: 3
---

# ChainOpera Deploy APIs

## API Workflow

![API Workflow](pics%2FAPIsWorkflow.png)

:::tip
Before using some of the apis that require remote operation (e.g. `fedml.api.model_push()`),
please use one of the following methods to login
to ChainOpera AI platform first:

1. CLI: `fedml login $api_key`

2. API: `fedml.api.fedml_login(api_key=$api_key)`
   :::

### `fedml.api.model_create()`

Create a model card in local environment.

**Example**

```py
fedml.api.model_create(name: str, model: str = None, model_config: str = None) -> bool
```

**Arguments**

- `name (str)`: Model card name.
- `model (Optional[str])`: Indicate a pre-built model from Hugging Face or GitHub.
- `model_config (Optional[str])`: Yaml file path that will be used to create a new model card.

**Returns**  
`True` if the model card is created successfully, otherwise `False`.

**Returns Type**  
`bool`

### `fedml.api.model_deploy()`

Deploy a model card to one of the following environments:

1. Current machine.
2. GPU cloud node(s) / cluster.
3. On-premise node(s) / cluster.

**Example**

```py
fedml.api.model_deploy(name: str, local: bool = False,
master_ids: str = None, worker_ids: str = None, use_remote: bool = False) -> bool
```

**Arguments**

- `name (str)`: Model card name.
- `local (Optional[bool])`: If `True`, will deploy model card to this current machine. Note that this will only use local
  model card.
- `master_ids (Optional[str])`: This is for on-premise deploy mode. If `local` is `False`, indicate the master node(s)
  id(s) to deploy the model card. If you want to deploy to multiple master nodes, use `","` to separate them.
  e.g. `"master_id1,master_id2"`.
- `worker_ids (Optional[str])`: This is for on-premise deploy mode. If `local` is `False`, indicate the worker node(s)
  id(s) to deploy the model card. If you want to deploy to multiple worker nodes, use `","` to separate them.
  e.g. `"worker_id1,worker_id2"`.
- `use_remote (Optional[bool])`: If `True`, then use a remote model card on the ChainOpera AI Platform. Default is `False`,
  which means use a local model card, and FedML will push the model card to ChainOpera AI Platform first,
  then deploy it.

:::tip
If you do not indicate `master_ids` and `worker_ids`, and `local` is `False`,
it will automatically deploy the model card to GPU cloud node(s) / cluster using ChainOpera® Launch.
:::

**Returns**  
`True` if the model card is deployed successfully, otherwise `False`.

**Returns Type**  
`bool`

### `fedml.api.model_run()`

Request a model inference endpoint.

**Example**

```py
fedml.api.model_run(endpoint_id: str, json_string: str) -> bool:
```

**Returns**  
Return the response string (After `json.dumps()`).

**Returns Type**  
`str`

### `fedml.api.model_delete()`

Delete a model card at local environment or a model card at ChainOpera AI Platform.

**Example**

```py
fedml.api.model_delete(name: str, local: bool = True) -> bool
```

**Arguments**

- `name (str)`: Model card name.
- `local (Optional[bool])`: If `True`, will delete the model card in local environment, If `False`, will
  delete the model card at ChainOpera AI Platform.

**Returns**  
`True` if the model card is deleted successfully, otherwise `False`.

**Returns Type**  
`bool`

### `fedml.api.model_list()`

List model card(s) at local environment or ChainOpera AI Platform.

**Example**

```py
fedml.api.model_list(name: str = "*", local: bool = True) -> any
```

**Arguments**

- `name (Optional[str])`: Model card(s) name. `"*"` means all model cards. To select multiple model cards,
  use `","` to separate them. e.g. `"model1,model2"`.
- `local (Optional[bool])`: If `True`, will show the model card(s) in local environment, If `False`,
  will show the model card(s) at ChainOpera AI Platform.

**Returns**  
Return a list of found model card(s) name (return an `[]` if no model card is found).  
Return a `None` if api_key is not indicated or incompatible.

**Returns Type**  
`any`

### `fedml.api.model_package()`

Pacakge a model card at local environment to a .zip file format, so that one can use UI
to upload to ChainOpera AI Platform.

:::tip
If you do not plan to use UI to upload the model card, you do not need to use this api.
`fedml.api.model_push()` will package and upload the model card directly.
:::

**Example**

```py
fedml.api.model_package(name: str) -> str
```

**Arguments**

- `name (str)`: Model card name.

**Returns**  
Return the absolute path string of the zip file if the model card is packaged successfully, otherwise `""`.

**Returns Type**  
`str`

### `fedml.api.model_push()`

Push a local model card or a remote stored model card to ChainOpera AI Platform.

**Example**

```py
fedml.api.model_push(name: str, model_storage_url: str = None) -> bool
```

**Arguments**

- `name (str)`: Model card name.
- `model_storage_url (Optional[str])`:A S3 address to the model card zip file.

**Returns**  
`True` if the model card is pushed successfully, otherwise `False`.

**Returns Type**  
`bool`

### `fedml.api.model_pull()`

Pull a model card from ChainOpera AI Platform to local.

**Example**

```py
fedml.api.model_pull(name: str) -> any
```

**Arguments**

- `name (str)`: Model card name.

**Returns**  
Return an absolute path string of the model card zip file
(return a `""` if the model card if the model card is not found at remote).  
Return a `None` if api_key is not indicated or incompatible.

**Returns Type**  
`any`

### `fedml.api.delete_endpoint()`

Delete an inference endpoint on ChainOpera® AI platform.

**Example**

```py
fedml.api.delete_endpoint(endpoint_id: str) -> bool:
```

**Arguments**

- `endpoint_id (str)`: Endpoint ID.

**Returns**  
`True` if the model endpoint is deleted successfully, otherwise `False`.

**Returns Type**  
`bool`
