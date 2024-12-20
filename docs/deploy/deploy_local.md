---
sidebar_position: 4
---

# Deploy to Local

This tutorial will guide you through the process to deploy the model to local machine without sign in to TensorOpera AI Platform.

Suppose you have a model card at local
called `my_model`, you can deploy it to local machine by:

```
fedml model deploy -n my_model --local
```

:::tip
The local model deploy command can only deploy the model card that is located at local.
if you want to deploy the model card that is located at TensorOpera AI Platform, please `fedml login` command
to TensorOpera AI Platform first, then use `fedml model pull` command to pull the model card to the local environment first.
:::

:::note
Above command will:

1. Automatically download and install the dependencies for inference.
2. Download the model weights from Hugging Face.
3. Start the model inference server and listen to localhost:2345/predict for requests.

```
Executing bootstrap script ...
Bootstrap start...
+ pip install langchain
...

Bootstrap finished
Bootstrap script is executed successfully!

INFO:     Started server process [29013]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://0.0.0.0:2345 (Press CTRL+C to quit)
```

:::

Use a `curl` command to test the inference server.

```bash
curl -XPOST localhost:2345/predict -d '{"text": "Hello"}'
```

:::info
You should see the output from the terminal with the response of that model.

```
"{'generated_text': '...'}"
```

:::
