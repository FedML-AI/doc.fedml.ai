---
sidebar_position: 6
---

# Deploy to Cloud

`fedml model deploy` is a high level CLI to deploy a model card to FedML GPU cloud marketplace.  

If you do not use `--local` option for local deploy, nor specify the `---master_ids`
and `--worker_ids` options for on-premise deploy, the model card will be deployed to the cloud. 

```
fedml model deploy -n my_model
```

:::tip
In this cloud deploy mode, what `fedml model deploy` cli do is just wrapping the fedml®launch related apis. 
So you can also use both `fedml model deploy` and `fedml launch` command to deploy a model card to the cloud.
:::

## GPU Resource Specification
When we create the model card, we can specify a model config YAML file. Inside the YAML file, 
we can specify the GPU resource requirement for the model card.
```sh
fedml model create -n my_model -cf model_config.yaml
```
And inside the model_config.yaml, we can specify the GPU resource requirement for the model card. Using the 
`resource_type`, as well as `minimum_num_gpus` and `maximum_cost_per_hour` to specify the GPU resource requirement.
```yaml
computing:
  minimum_num_gpus: 1           # minimum # of GPUs to provision
  maximum_cost_per_hour: $3000   # max cost per hour for your job per gpu card
  #allow_cross_cloud_resources: true # true, false
  #device_type: CPU              # options: GPU, CPU, hybrid
  resource_type: A100-80G       # e.g., A100-80G,
  # please check the resource type list by "fedml show-resource-type"
  # or visiting URL: https://nexus.fedml.ai/compute/distributed
```
