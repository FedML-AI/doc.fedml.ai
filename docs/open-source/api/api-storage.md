---
sidebar_position: 7
---

# FEDML Storage APIs

## Storage APIs

Storage APIs help in managing all the data needs that is typically associated with AI workloads.

:::tip
Before using some of the apis that require remote operation (e.g. `fedml.api.launch_job()`), please use one of the following methods to login
to ChainOpera AI platform first:

1. CLI: `fedml login $api_key`

2. API: `fedml.api.fedml_login(api_key=$api_key)`
   :::

### `fedml.api.upload()`

Upload data on FEDML® Nexus AI Platform

```py
def upload(data_path, api_key=None, service="R2", name=None, description=None, metadata=None, show_progress=False,
           out_progress_to_err=True, progress_desc=None)-> FedMLResponse
```

**Arguments**

- `data_path (str)`: path to the data.
- `api_key (str=None)`: Your API key from FedML AI Nexus platform (if not configured already).
- `service (str)`: The backend cloud storage service for storing the data. Currently, only Cloudfare R2 service is available.
- `name (str)`: The name of the data stored on the cloud. If not specified, it'll take the name of the data file or directory.
- `description (str)`: A description in string for the data being stored. If not provided, the description will be empty.
- `metadata (dict)`: Metadata for the data that can be specified by the user in the form of a dictionary. Both the key and values have to be strings.
- `show_progress (bool)`: Boolean flag to show a progress bar when the upload happens.
- `out_progress_to_err (bool)`: Boolean flag to output the tqdm progress to stderr instead of stdout.
- `progress_desc(str)`: String message that is displayed next to the progress bar when the data is uploaded. If not specified, the text : "Uploading Package to Remote Storage" will be used.

**Returns**

`FedMLResponse` object with the following attributes:

- `code (Enum Class)`: API result code. The FedML response codes can be seen at the end of this page.
- `message (str)`: API status message.
- `data(obj)`: If the upload is successful, the url of the uploaded file is sent via this attribute.

**Example**

```py
import fedml
API_KEY = "api_key"

DATA_PATH = "path/to/data"
DATA_NAME = "new_name_for_data_directory or file"
STORAGE_SERVICE = "R2"
DATA_DESCRIPTION = "description of data uploaded"
metadata = {'key': 'value'}

response = fedml.api.upload(
    data_path=DATA_PATH,
    api_key=API_KEY,
    service=STORAGE_SERVICE,
    name=DATA_NAME,
    description=DATA_DESCRIPTION,
    metadata=metadata,
    show_progress=True
)
```

---

### `fedml.api.download()`

Download data stored on FEDML® Nexus AI Platform

```py
def download(data_name, api_key=None, service="R2", dest_path=None, show_progress=True) -> FedMLResponse
```

**Arguments**

- `data_name (str)`: The name of the data that was uploaded to FedML cloud storage.
- `api_key (str=None)`: Your API key from FedML AI Nexus platform (if not configured already).
- `service (str)`: The backend cloud storage service for storing the data. Currently, only Cloudfare R2 service is available.
- `dest_path (str)`: The name of the directory where the downloaded data needs to be stored.
- `show_progress (bool)`: Boolean flag to show a progress bar when the upload happens.

**Returns**

`FedMLResponse` object with the following attributes:

- `code (Enum Class)`: API result code. The FedML response codes can be seen at the end of this page.
- `message (str)`: API status message.
- `data(obj)`: If the download is successful, the filepath to where it is downloaded is returned.

**Example**

```py
import fedml
API_KEY = "api_key"

DESTINATION_DIRECTORY = "dataset"
DATA_NAME = "name_of_data_directory" #The name that was provided to platform during upload.
STORAGE_SERVICE = "R2"


response = fedml.api.download(
    data_name=DATA_NAME,
    api_key=API_KEY,
    service=STORAGE_SERVICE,
    dest_path=DESTINATION_DIRECTORY,
    show_progress=True
)
```

---

### `fedml.api.delete()`

Delete data stored on FEDML® Nexus AI Platform

```py
def delete(data_name, service, api_key=None)-> FedMLResponse
```

**Arguments**

- `data_name (str)`: The name of the data that was uploaded to FedML cloud storage.
- `api_key (str=None)`: Your API key from FedML AI Nexus platform (if not configured already).
- `service (str)`: The backend cloud storage service for storing the data. Currently, only Cloudfare R2 service is available.

**Returns**

`FedMLResponse` object with the following attributes:

- `code (Enum Class)`: API result code. The FedML response codes can be seen at the end of this page.
- `message (str)`: API status message.
- `data(obj)`: A `boolean` flag to show if the delete was successful.

**Example**

```py
import fedml
API_KEY = "api_key"
DATA_NAME = "name_of_data_directory"
STORAGE_SERVICE = "R2"

response = fedml.api.delete(
    data_name=DATA_NAME,
    api_key=API_KEY,
    service=STORAGE_SERVICE
)
if response.code == ResponseCode.SUCCESS:
    print(f"Data '{DATA_NAME}' deleted successfully.")
else:
    print(f"Failed to delete data {DATA_NAME}. Error message: {response.message}")
```

---

### `fedml.api.get_storage_metadata()`

Get metadata of a data object stored on FEDML® Nexus AI Platform

```py
def get_storage_metadata(data_name, api_key=None) -> FedMLResponse
```

**Arguments**

- `data_name (str)`: The name of the data that was uploaded to FedML cloud storage.
- `api_key (str=None)`: Your API key from FedML AI Nexus platform (if not configured already).

**Returns**

`FedMLResponse` object with the following attributes:

- `code (Enum Class)`: API result code. The FedML response codes can be seen at the end of this page.
- `message (str)`: API status message.
- `data(obj)`: If the get_storage_metadata call is successful, then this object contains the `meta data information`.

**Example**

```py
import fedml
API_KEY = "api_key"
DATA_NAME = "name_of_data_directory" #The name that was provided to platform during upload.

response = fedml.api.get_storage_metadata(
    data_name=DATA_NAME,
    api_key=API_KEY
)
```

**Parsing the output**

The following code shows how the response.data can be parsed to a pretty table.

```py
from prettytable import PrettyTable
from fedml.api.fedml_response import ResponseCode

if response.code == ResponseCode.SUCCESS:
    metadata = response.data
    if metadata:
        metadata_table = PrettyTable(["Data Name", "Description", "Created At", "Updated At"])
    metadata_table.add_row([metadata.dataName, metadata.description, metadata.createdAt, metadata.updatedAt])

print(metadata_table)
```

---

### `fedml.api.get_storage_user_defined_metadata()`

Get user-defined metadata of a data object stored on FEDML® Nexus AI Platform

```py
def get_storage_user_defined_metadata(data_name, api_key=None) -> FedMLResponse
```

**Arguments**

- `data_name (str)`: The name of the data that was uploaded to FedML cloud storage.
- `api_key (str=None)`: Your API key from FedML AI Nexus platform (if not configured already).

**Returns**

`FedMLResponse` object with the following attributes:

- `code (Enum Class)`: API result code. The FedML response codes can be seen at the end of this page.
- `message (str)`: API status message.
- `data(obj)`: If the get call is successful, the dictionary that was uploaded by the user is present in this object.

**Example**

```py
import fedml

API_KEY = "api_key"
DATA_NAME = "name_of_data_directory" #The name that was provided to platform during upload.

response = fedml.api.get_storage_user_defined_metadata(
    data_name=DATA_NAME,
    api_key=API_KEY
)

```

**Parsing the output**

The following code shows how the dictionary can be retrieved from the response object.

```py
from fedml.api.fedml_response import ResponseCode

if response.code == ResponseCode.SUCCESS:
    metadata = response.data
        if metadata:
            print("User defined metadata ",response.data)
```

---

### `fedml.api.list_storage_objects()`

List data stored on FEDML® Nexus AI Platform

```py
def list_storage_objects(api_key=None) -> FedMLResponse
```

**Arguments**

- `api_key (str=None)`: Your API key from FedML AI Nexus platform (if not configured already).

**Returns**

`FedMLResponse` object with the following attributes:

- `code (Enum Class)`: API result code. The FedML response codes can be seen at the end of this page.
- `message (str)`: API status message.
- `data(obj)`: If the list command is successful, a list of data objects stored on the Nexus backend with its metadata is available.

**Example**

```py
import fedml
API_KEY = "api_key"

response = fedml.api.list_storage_objects(api_key=API_KEY)

```

**Parsing the output**

The following code shows how a pretty table can be built from the response object.

```py
from prettytable import PrettyTable
from fedml.api.fedml_response import ResponseCode

if response.code == ResponseCode.SUCCESS:
    metadata = response.data
    if metadata:
        object_list_table = PrettyTable(["Data Name", "Description", "Created At", "Updated At"])
        for stored_object in response.data:
            object_list_table.add_row(
                [stored_object.dataName, stored_object.description, stored_object.createdAt, stored_object.updatedAt])
        print(object_list_table)
```

### `FedML ResponseCode Enum class`

```py
class ResponseCode(Enum):
    SUCCESS = "SUCCESS"
    FAILURE = "FAILURE"
    ERROR = "ERROR"
```
