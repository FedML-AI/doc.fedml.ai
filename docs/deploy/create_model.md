---
sidebar_position: 4
---

# Create Your Model

There are two ways to create a model card: 
1. Using a pre-built model.
2. Using a model config YAML file.

## Create a Model Card Using a Pre-built Model
Currently, we support the following pre-built models:
### Hugging Face models
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



## Create a Model Card Using a Model Config YAML File
The complete code following section's can be found at 
https://github.com/FedML-AI/FedML/tree/master/python/examples/deploy/quick_start

The folder architecture is:
```
├── config.yaml
└── src
    ├── app
    │   ├── __init__.py
    │   └── pipe
    │       ├── constants.py
    │       ├── __init__.py
    │       └── instruct_pipeline.py
    ├── config
    │   └── bootstrap.sh
    ├── __init__.py
    └── main_entry.py
```
- `config.yaml` contains the model card configuration.
- `src/config/bootstrap.sh` contains the dependencies installation script.
- `src/main_entry.py` is the entry point of the model.
- `src/app` contains the related transformer pipeline code. Used in `main_entry.py`.

### Create a Model Card Configuration
`config.yaml` is the file for creating model cards. See Model Configuration YAML Chapter for more. 
A minimum example is like:
```yaml
workspace: "./src"
entry_point: "main_entry.py"
bootstrap: config/bootstrap.sh
```
`workspace` is the path to the folder containing all the source code for model inference.  
`entry_point` is the path to the entry point file of the model.  
`bootstrap` is the path to the script for installing dependencies.  

More configurable options in the config yaml file can be found at [YAML Configuration](yaml_ref.md) .

### Create a Bootstrap Script
`bootstrap.sh` is the shell script for installing dependencies.
```bash
pip install langchain
pip install transformers
pip install accelerate
pip install "pydantic>=1.8.0,<2.0.0"
```

### Define the Model Entry Point
main_entry.py is the endpoint entry file.
#### Inherit the FedMLPredictor
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
#### Pass the predictor obj to FedMLInferenceRunner
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


### Create a Local Model Card
Create a local model card by indicating the model card configuration file, support you are in the same
folder as `config.yaml`. This level folder architecture is:
```
.
├── config.yaml
└── src
    ├── ...
```

Use `fedml model create` command to create a local model card. Using `-n` to specify the model name, 
`-cf` to specify the model card configuration file.
```bash
fedml model create -n my_model -cf config.yaml
```