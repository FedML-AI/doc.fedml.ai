---
sidebar_position: 7
---
#  Log Management - fedml run logs

### `fedml run logs [OPTIONS]`

Get logs of run from the FedML® Nexus AI Platform.

#### Options

| Option              | Description                                                                                                                       |
|---------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| -h, --help          | Show this message and exit                                                                                                        |
| -rid, --run_id      | Run id at the FedML® Nexus AI Platform.                                                                                           |
| -a, --need_all_logs | boolean value representing if all logs are needed. Default to True                                                                |
| -pn, --page_num     | request page num for logs. --need_all_logs should be set to False if you want to use this option.                                 |
| -ps, --page_size    | request page size for logs, --need_all_logs should be set to False if you want to use this option.                                |
| -k, --api_key       | user api key.                                                                                                                     |
| -v, --version       | version of FedML® Nexus AI Platform. It should be dev, test or release                                                            |
| -pf, --platform     | The platform name at the FedML® Nexus AI Platform (options: octopus, parrot, spider, beehive, falcon, launch, default is falcon). |


#### Example

```
fedml run logs -rid 1716563514434392064

Logs summary info is as follows.
+---------------------+-----------------+---------------------------------------------------------------------------------------+
|        Run ID       | Total Log Lines |                                        Log URL                                        |
+---------------------+-----------------+---------------------------------------------------------------------------------------+
| 1716563514434392064 |        11       | https://s3.us-west-1.amazonaws.com/fedml/fedml-logs/fedml-run-1716563514434392064.log |
+---------------------+-----------------+---------------------------------------------------------------------------------------+

Logs URL for each device is as follows.
+---------------------+-------------------------+---------------------------------------------------------------------------------------------------------------------------+
|      Device ID      |     Device Name         |                                                       Device Log URL                                                      |
+---------------------+-------------------------+---------------------------------------------------------------------------------------------------------------------------+
| 1684824138201567232 | NVIDIA A100-SXM4-80GB:8 | https://s3.us-west-1.amazonaws.com/fedml/fedml-logs/fedml-run-1714535384211394560-edge-1684824138201567232%40user-214.log |
+---------------------+-------------------------+---------------------------------------------------------------------------------------------------------------------------+

All logs is as follows.
[FedML-Client @device-id-1684824138201567232] [Mon, 23 Oct 2023 14:13:30 -0700] [INFO]-----GPU Machine scheduling successful-----
[FedML-Server @device-id-201649] [Mon, 23 Oct 2023 14:13:54 -0700] [INFO] [mlops_metrics.py:287:report_server_id_status] report_server_id_status. message_json = {"run_id": 1716563514434392064, "edge_id": 201649, "status": "STARTING"}
[FedML-Server @device-id-201649] [Mon, 23 Oct 2023 14:13:54 -0700] [INFO] [mlops_metrics.py:229:report_server_device_status_to_web_ui] report_server_device_status. msg = {'run_id': 1716563514434392064, 'edge_id': 201649, 'status': 'STARTING', 'role': 'normal', 'version': 'v1.0'}
[FedML-Server @device-id-201649] [Mon, 23 Oct 2023 14:13:54 -0700] [INFO] [mlops_metrics.py:229:report_server_device_status_to_web_ui] report_server_device_status. msg = {'run_id': 1716563514434392064, 'edge_id': 201649, 'status': 'STARTING', 'role': 'normal', 'version': 'v1.0'}
[FedML-Server @device-id-201649] [Mon, 23 Oct 2023 14:13:54 -0700] [INFO] [server_runner.py:502:run_impl] Detect all status of Edge ids: [1684824138201567232]
[FedML-Server @device-id-201649] [Mon, 23 Oct 2023 14:38:59 -0700] [ERROR] [server_runner.py:934:detect_edges_status] There are inactive edge devices. Inactivate edge id list is as follows. [1684824138201567232]
[FedML-Server @device-id-201649] [Mon, 23 Oct 2023 14:38:59 -0700] [INFO] [mlops_metrics.py:287:report_server_id_status] report_server_id_status. message_json = {"run_id": 1716563514434392064, "edge_id": 201649, "status": "FAILED", "server_id": 201649}
[FedML-Server @device-id-201649] [Mon, 23 Oct 2023 14:38:59 -0700] [INFO] [mlops_metrics.py:229:report_server_device_status_to_web_ui] report_server_device_status. msg = {'run_id': 1716563514434392064, 'edge_id': 201649, 'status': 'FAILED', 'role': 'normal', 'version': 'v1.0'}
[FedML-Server @device-id-201649] [Mon, 23 Oct 2023 14:38:59 -0700] [ERROR] [server_runner.py:1441:send_exit_train_with_exception_request_to_edges] exit_train_with_exception: send topic flserver_agent/1684824138201567232/exit_train_with_exception
[FedML-Server @device-id-201649] [Mon, 23 Oct 2023 14:38:59 -0700] [INFO] [mlops_metrics.py:158:common_broadcast_client_training_status] report_client_training_status. message_json = {"edge_id": 1684824138201567232, "run_id": 1716563514434392064, "status": "FAILED"}
[FedML-Server @device-id-201649] [Mon, 23 Oct 2023 14:38:59 -0700] [INFO] [server_runner.py:438:run] Release resources.
```