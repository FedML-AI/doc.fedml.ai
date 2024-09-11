---
sidebar_position: 5
---

# Deploy to Cloud

This tutorial will guide you through the process of deploying a model card to a decentralized serverless GPU cloud.

## Select the model card

:::note
Suppose you have pushed and checked the Model Card's existence on ChainOpera AI Platform
Otherwise follow the previous chapter to use `fedml model create` and `fedml model push` command to create and push a local model card to ChainOpera AI Platform.
:::

Check if the model card is uploaded to ChainOpera AI Platform by clicking the "Deploy" -> "My Models" tab on the ChainOpera AI Platform dashboard, then click the "Deploy" button on the UI.
![CheckModelCard.png](pics%2FCheckModelCard.png)

## Config the endpoint

In the endpoint configuration page, you can configure the deployment settings, like the resource allocation, the number of replicas, etc.  
![OverviewDeployPage.png](pics%2Fpage1%2FOverviewDeployPage.png)

### What is a Dedicated Endpoint?

Here the Dedicated Endpoint means you are using the following two type of devices, includes:

1. On-premise device
2. Cloud device that ChainOpera allocated to you.  
   The charges are based on the usage of the device.

:::note
For more endpoint price details, please contact us https://tensoropera.ai/contact for more information.
:::

### What is a Serverless Endpoint?

There are two difference from Dedicated Endpoint.

1. This endpoint can be published on Model Marketplace which can be used / paid by other users.
2. The charges are based on the usage of the endpoints, say tokens usage in LLM model.

![ServerlessPage.png](pics%2FServerlessPage.png)
:::note
For more endpoint price details, please contact us https://tensoropera.ai/contact for more information.
:::

## Deploy to the Cloud Devices

Click the deploy button after you select the corresponding options. After few minutes, the model will be deployed to the decentralized serverless GPU cloud. You can find the deployment details in the `Deploy` -> `Endpoints` tab in the ChainOpera AI Cloud dashboard.
![DeployFinished.png](pics%2Fpage1%2FDeployFinished.png)
