---
sidebar_position: 3
---

# Create a Model Card

This tutorial will guide you through how to create a model card in a local environment, then upload it to the TensorOpera AI Platform, so that you can deploy it anywhere.

There are two ways to create a model card: 
   1. Create from a pre-built model.
   2. Create a model config YAML file.

### Pre-requisites
Before you start to craft the model card, install `fedml` to your machine, `fedml` is TensorOpera's serving library.

```bash
pip install fedml
```

### Create a Model Card From a Pre-built Model

Currently, we support creating model card directly from Hugging Face.

To use a pre-built model from Hugging Face, you can use the following command:
```bash
fedml model create --name $model_name --model $model_name
```

`$model_name` is a arbitrary name for your model card.  
`$model_name` is the name of the pre-built model from Hugging Face. Start with `hf:`.
For example, to use the `EleutherAI/pythia-70m` model from Hugging Face, you can use the following command:
```bash
fedml model create --name hf_model --model hf:EleutherAI/pythia-70m
```

### Create a Model Card From a Model Config YAML File

The second way to create a model card is to use a model config YAML file. A complete code following section's can be found at 
https://github.com/FedML-AI/FedML/tree/master/python/examples/deploy/quick_start

To craft a model card, an example folder architecture is like:
```
├── config.yaml
└── src
    ├── main_entry.py
    └──  ...
        └── ...
    
```
- `config.yaml` contains the model card configuration.
- `src/main_entry.py` is the entry point of the model.
- `...` means other source code files which, your main entry file may import or read.

`config.yaml` is the file for creating model cards. See [Model Configuration YAML](yaml_ref.md) Chapter for full reference. 
A minimum example is like:

```yaml
workspace: "./src"
entry_point: "main_entry.py"
```

`workspace` is the path to the folder containing all the source code for model inference.  
`entry_point` is the path to the entry point file of the model.

After we finalized the config yaml file, we can dive into `main_entry.py`. A [sample python script](https://github.com/FedML-AI/FedML/blob/master/python/examples/deploy/quick_start/src/main_entry.py) will contain two essential parts:
`FedMLPredictor` and `FedMLInferenceRunner`.

Inside `main_entry.py`, you need to Inherit `FedMLPredictor` as the base class as your model serving object. 
Inside this class, you need to implement two methods: ` __init__` and `predict`.  
   - In the `__init__` method, you need to initialize the model. E.g. load the model checkpoint, init the transformer
   pipeline, etc.
   - In the `predict` method, you need to define how your model will respond to the requests.

    ```python
    from fedml.serving import FedMLPredictor
    
    class MyChatbot(FedMLPredictor):               
        def __init__(self):
            super().__init__()
            from langchain import LLMChain 
            self.chatbot = LLMChain()
            
        def predict(self, request: dict) -> dict:
            response_text = self.chatbot.predict(request)
            return {"generated_text": str(response_text)}
    ```

In the `__main__` function, initialize a `FedMLPredictor`'s child obj that has class you define in the previous step, 
then pass it to `FedMLInferenceRunner` class, finally call its `run` method.
```python
from fedml.serving import FedMLInferenceRunner

if __name__ == "__main__":
    chatbot = MyChatbot()
    fedml_inference_runner = FedMLInferenceRunner(chatbot)
    fedml_inference_runner.run()
```

:::tip
For input type, we currently only support JSON.
For return type, aside from JSON like obj. 
FedML predictor also support returning stream, file response. See more at [Advanced_Features](advanced_features.md)
:::

:::tip
You may indicate the inference image name in the `config.yaml` file.
In your `config.yaml` file, you can specify the `inference_image_name` field.
```yaml
inference_image_name: $your_image_name
job: |
  python3 main_entry.py
```
:::

Use `fedml model create` command to create a local model card. Using `-n` to specify the model name, 
`-cf` to specify the model card configuration file.
```bash
fedml model create -n my_model -cf config.yaml
```


### What's next?
After you have created a model card, you can push it to the TensorOpera AI Platform by using

```
fedml model push -n my_model -k $API_KEY
```

Then you can deploy the model card to different environments, like local, on-premise, or GPU Cloud. Follow the one of the following tutorials to learn how to deploy the model card.

- [Deploy to Local](deploy_local.md)
- [Deploy to On-premise](deploy_on_premise.md)
- [Deploy to GPU Cloud](deploy_cloud.md)
