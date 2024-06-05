---
sidebar_position: 2
---

# Quickstart

This tutorial will guide you through the process of deploying a state-of-the-art model from TensorOpera AI Platform 
to a decentralized serverless GPU cloud.

### Choose a model from TensorOpera AI Model Marketplace

TensorOpera AI Cloud provides a wide range of pre-trained models for various tasks. You can choose a model under the
`Models` tab in the TensorOpera AI Cloud dashboard. Click the model card to view the details.

![ModelHub.png](pics%2Fpage1%2FModelHub.png)

In the model details page, you can find the model's details, source code. 

![ModelDetails.png](pics%2Fpage1%2FModelDetails.png)

You may also interact with the model by clicking
the `Playground` tab (This requires you to log in to the TensorOpera AI Platform).

![ModelPlayground.png](pics%2Fpage1%2FModelPlayground.png)


### Deploy the model to a decentralized serverless GPU cloud

After you have chosen a model, say `Meta-Llama-3-70B-Instruct` . You can click the `Deploy` button to deploy the model.

![DeployButton.png](pics%2Fpage1%2FDeployButton.png)

In the deployment page, you can configure the deployment settings, like the resource allocation, the number of replicas, etc.
When you are ready, click the `Deploy` button to deploy the model to the decentralized serverless GPU cloud.

![OverviewDeployPage.png](pics%2Fpage1%2FOverviewDeployPage.png)

After few minutes, the model will be deployed to the decentralized serverless GPU cloud. You can find the deployment details in the `Deploy` -> `Endpoints` tab in the TensorOpera AI Cloud dashboard.
![DeployFinished.png](pics%2Fpage1%2FDeployFinished.png)

You may interact with the deployed model by clicking the `Playground` tab in the deployment details page, or using the curl / Python / NodeJS command under the `API` tab.
![CallEnpdoint.png](pics%2Fpage1%2FCallEnpdoint.png)


### What's next?

To create and serve your own model card which is not listed on our Model Marketplace, follow the next tutorial [Create a Model Card](create_model.md) .