---
sidebar_position: 2
---

# Quickstart

This tutorial will guide you through the process of creating a local model card from Hugging Face and deploying the model card to the local server or a serverless GPU cloud.

## Prerequisites
Install `fedml`, the serving library provided by TensorOpera AI, on your machine.
```bash
pip install fedml
```

## Create a model from Hugging Face
Use `fedml model create` command to create a model card on your local machine. In this quick start tutorial, we will try
to deploy an `EleutherAI/pythia-70m` model from Hugging Face. 

To give the model card a name, use `-n` option. To use a hugging face model, you will need to indicate the model source with `-m` option, and 
use `hf:` as the prefix of the organization name and model name. 

```bash
fedml model create -n hf_model -m hf:EleutherAI/pythia-70m
```

## Deploy the model to the local machine
Use `fedml model deploy` command to deploy the model. Use `-n` to indicate the model card name.
Use `--local` option to deploy to the current machine.
```bash
fedml model deploy -n hf_model --local
```

The prerequisite dependencies will be automatically installed. After the local endpoint is started, use a `curl` command to test the inference server.
```bash
curl -XPOST localhost:2345/predict -d '{"text": "Hello"}'
```

:::info
You will see the output from the terminal with the response of that model.
```
"{'generated_text': '...'}"
```
:::

## Deploy the model to a Serverless GPU Cloud
:::tip
Before you start, you will need to create an account on [TensorOpera AI](https://TensorOpera.ai/home).
:::

Use `fedml model push` to push the model card to TensorOpera AI Cloud. Replace `$api_key` with your own API key. The API Key can be found from the profile page.
```bash
fedml model push -n hf_model -k $api_key
```

After you push the model card to TensorOpera AI Cloud, you can deploy the model by going to the
`Deploy` -> `My Models` tab on the TensorOpera AI Platform dashboard.
Click the `Deploy` button to deploy the model.

![DeployHFmodel.png](pics%2FDeployHFmodel.png)

For this quick start tutorial, we can select the `Serverless` `RTX-4090` option and click the `Deploy` button.

![CreateServelessEndpoint.png](pics%2FCreateServelessEndpoint.png)

After few minutes, the model will be deployed to the serverless GPU cloud. You can find the deployment details in the `Deploy` -> `Endpoints` tab in the TensorOpera AI Cloud dashboard.

![EndpointList.png](pics%2FEndpointList.png)

You may interact with the deployed model by clicking the `Playground` tab in the deployment details page, or using the curl / Python / NodeJS command under the `API` tab.
![EndpointDetail.png](pics%2FEndpointDetail.png)

## What's next?

To create and serve your own model card, follow the next tutorial [Create a Model Card](create_model.md).