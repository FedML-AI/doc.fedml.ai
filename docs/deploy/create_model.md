---
sidebar_position: 3
---

# Create a Model Card

This tutorial will guide you through how to create a model card in a local environment and upload it to the TensorOpera AI Platform, so that you can deploy it anywhere.

There are three ways to create a model card: 
   1. Create from a model config file.
   2. Create from Hugging Face.
   3. (Web-UI) Create from TensorOpera model marketplace.


## Pre-requisites
Before you start to craft the model card, install `fedml` to your machine, `fedml` is TensorOpera's serving library.

```bash
pip install fedml
```
## Create a model card from a model config file

The most straightforward way to create a model card is to use a model config YAML file. The following steps is also written
in the GitHub repository, you can find the full example [here](https://github.com/FedML-AI/FedML/tree/master/python/examples/deploy/dummy_job).

To craft a model card, an example workplace folder structure is like this:
```
├──  config.yaml     # Contains the model card configuration.
└──  main_entry.py   # Entry point of the model.
```

### How to write a config file?

Inside `config.yaml`, you can define the model card configuration. The configuration file can be more complex, see  [Model Configuration YAML](yaml_ref.md) Chapter for full reference. 
But a minimum example is like:

```yaml
workspace: "."                # The path to the folder that you want to create the model card.
entry_point: "main_entry.py"  # The path to the entry point file of the model.
```

### How to write an entry file?

Inside the main entry file `main_entry.py`. There are two essential components that you need to implement:
`FedMLPredictor` and `FedMLInferenceRunner`. 

First, you need to Inherit `FedMLPredictor` as the base class as your model serving object.  
Inside this class, you need to implement two methods: ` __init__` and `predict`.  
   - In the `__init__` method, you need to initialize the model. E.g. load the model checkpoint.
   - In the `predict` method, you need to define how your model will respond to the requests.

    ```python
    from fedml.serving import FedMLPredictor
    
    class MyChatbot(FedMLPredictor):               
        def __init__(self):
            super().__init__()
            
        def predict(self, request: dict) -> dict:
            response_text = "Hello, I am a chatbot."
            return {"generated_text": response_text}
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

### Create a model card by indicating the configuration file

Use `fedml model create` command to create a local model card. Using `-n` to specify the model name, 
`-cf` to specify the model card configuration file.
```bash
fedml model create -n my_model -cf config.yaml
```

After you have created a model card, you can push it to the TensorOpera AI Platform by using:
```
fedml model push -n my_model -k $API_KEY
```

## Create a model card from Hugging Face

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
After you have created a model card, you can push it to the TensorOpera AI Platform by using:

```
fedml model push -n my_model -k $API_KEY
```

## Create a model from TensorOpera AI Model Marketplace

TensorOpera AI Cloud provides a wide range of pre-trained models for various tasks. You can choose a model under the
`Models` tab in the TensorOpera AI Cloud dashboard. Click the model card to view the details.

![ModelHub.png](pics%2Fpage1%2FModelHub.png)

After you have chosen a model, say `Meta-Llama-3-70B-Instruct` . You can click the `Import` button to deploy the model.

![ImportButton.png](pics%2FImportButton.png)


## What's next?
You can deploy the model card to different environments, like local, on-premise, or GPU Cloud. Follow the one of the following tutorials to learn how to deploy the model card.

- [Deploy to Local](deploy_local.md)
- [Deploy to On-premise](deploy_on_premise.md)
- [Deploy to GPU Cloud](deploy_cloud.md)
