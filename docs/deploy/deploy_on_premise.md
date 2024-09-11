---
sidebar_position: 6
---

# Deploy to On-premise

This tutorial will guide you through the process when you have your own on-premise servers, and want to deploy the model cards to those servers.

## Bind your devices to ChainOpera AI Platform

Bind your device to ChainOpera AI Platform.

```
fedml device bind $api_key

## Example output
Congratulations, your device is connected to the ChainOpera MLOps platform successfully!
Your ChainOpera Edge ID is 32314, unique device ID is 0xxxxxxxx@MacOS.Edge.Device,
master deploy ID is 31240, worker deploy ID is 31239
```

Check your device id from the output of the command line. Here, for example the `31240` is the master device id,
`31239` is the worker device id.

You can also see your device id on ChainOpera AI Platform.
![onPremiseDevice.png](pics%2FonPremiseDevice.png)

## Deploy the model card to the on-premise device

:::note
Suppose you have pushed and checked the Model Card's existence on ChainOpera AI Platform
Otherwise follow the previous chapter to use `fedml model create` and `fedml model push` command to create and push a local model card to ChainOpera AI Platform.
:::

Check if the model card is uploaded to ChainOpera AI Platform by clicking the "Deploy" -> "My Models" tab on the ChainOpera AI Platform dashboard, then click the "Deploy" button on the UI.
![CheckModelCard.png](pics%2FCheckModelCard.png)

In the deployment page, select one master device and some worker (>=1) devices to deploy the model card.
you can also configure the deployment settings, like the resource allocation, the number of replicas, etc.

![selectOnpremDev.png](pics%2FselectOnpremDev.png)

Click the deploy button after you select the corresponding options. After few minutes, the model will be deployed to the decentralized serverless GPU cloud. You can find the deployment details in the `Deploy` -> `Endpoints` tab in the ChainOpera AI Cloud dashboard.
![DeployFinished.png](pics%2Fpage1%2FDeployFinished.png)
