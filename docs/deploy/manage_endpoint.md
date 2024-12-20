---
sidebar_position: 7
---

# Manage Your Endpoint

This tutorial will guide you through how to manage your endpoint on the TensorOpera AI Platform. Including:

- **Update** your model card running on the endpoint.
- **Scale** or Auto-scale your endpoint by adding more replicas.
- **Monitor** your endpoint's status and metrics.

## Update your model's version

Suppose you've made some changes to `main_entry.py` in your model card, for example from:

```python
def predict(self, request):
    return {f"AlohaV1From{self.worker_id}": request}
```

to:

```python
def predict(self, request):
    return {f"AlohaV2From{self.worker_id}": request}
```

After you finished the changes, you will need to recreate the model card.

```bash
fedml model create -n $model_card_name -cf $config_file
```

Then upload to the TensorOpera AI Platform. By using:

```bash
fedml model push -n $model_card_name -i $model_card_id
```

:::note
You can find the model card id from the TensorOpera AI Platform.
:::

After that, you can see the model card has been updated on the TensorOpera AI Platform.
![ChangeModelVersion.png](pics%2FChangeModelVersion.png)

Assume you have an existed endpoint under "Model Serving" -> "Endpoints" -> Your Endpoint.
To edit or configure the replicas, you can click the "Edit" button on the endpoint page.
![EditEndpointButton.png](pics%2FEditEndpointButton.png)

Select the new model card version, then Click "Update" button.
![UpdateModelVersion.png](pics%2FUpdateModelVersion.png)

:::note
By default, the update will use a scrolling update strategy. Which means, it only updates
a small portion of the devices at a time. This can ensure that this endpoint is always available when updating.
:::

## Scale or Auto-scale your endpoint

An endpoint can have multiple replicas. Each replica is a copy of the model running on a device.
You can scale your endpoint by adding or decreasing replica(s) before the endpoint is created or after it is created.
The following steps will guide you through how to scale your endpoint.

The following graph provide high-level overview of the replica's representation. Here the worker means physical device.
For serverless GPU users, you don't need to care about the worker, just focus on the replica's number.
For on-premise users, you can see the worker's id on the `GPU Cloud` -> `GPU Hub` -> `My servers` page.
![ReplicaRepr.png](pics%2FReplicaRepr.png)

To edit or configure the replicas, you can click the "Edit" button on the endpoint page.
![EditEndpointButton.png](pics%2FEditEndpointButton.png)

Then you can edit the replica number, and click the "Update" button.
![EditReplicaNum.png](pics%2FEditReplicaNum.png)

For auto-scaling, please refer to the [Advanced Features](advanced_features.md) page.

## Monitor your endpoint

After an endpoint is created, you can monitor the endpoint's status and metrics. First click the endpoint you want to monitor.
![EndpointClick.png](pics%2FEndpointClick.png)

In the Endpoint Detail Page, click the `System Monitoring` tab. Then you can see this endpoint's real-time request number,
number of replica (Dynamically if auto-scaling is enabled), and the response time (latency) and throughput.
![EndpointMonitor.png](pics%2FEndpointMonitor.png)

To check the logs inside the replica (Docker container), you can click the `Logs` tab.
By selecting different replica id, you can see the logs of different replicas.
![InferenceLogs.png](pics%2FInferenceLogs.png)
