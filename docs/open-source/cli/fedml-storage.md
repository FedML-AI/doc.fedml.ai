---
sidebar_position: 11
---

# Data Storage - fedml storage

## FedML Storage CLI Overview

Store and manage data on the TensorOpera® AI Platform.

```bash
❯ fedml storage
Usage: fedml storage [OPTIONS] COMMAND [ARGS]...

  Manage storage on TensorOpera® AI Platform

Options:
  -h, --help          Show this message and exit.
  -k, --api_key TEXT  user api key.
  -v, --version TEXT  specify version of TensorOpera® AI Platform. It should
                      be dev, test or release

Commands:
  delete             Delete data stored on TensorOpera® AI Platform
  download           Download data stored on TensorOpera® AI Platform
  get-metadata       Get metadata of data object stored on TensorOpera® AI Platform
  get-user-metadata  Get user-defined metadata of data object stored on TensorOpera® AI Platform
  list               List data stored on TensorOpera® AI Platform
  upload             Upload data on TensorOpera® AI Platform
```

## Commands

### `fedml storage upload [OPTIONS] DATA_PATH`

Upload data on TensorOpera® AI Platform

#### Options {#options-1}

| Name                       | Default           | Description                                                                                |
| -------------------------- | ----------------- | ------------------------------------------------------------------------------------------ |
| `--help` or `-h`           |                   | Show this message and exit.                                                                |
| `--name` or `-n`           | Current Data name | Name your data to store.                                                                   |
| `--description` or `-d`    | Empty description | Add description to your data to store.                                                     |
| `--user_metadata` or `-um` | `None`            | User-defined metadata in the form of dictionary like {'name':'value'} within double quotes |
| `--service` or `-s`        | `R2`              | Storage service for object storage. Only R2 available as of now.                           |
| `--api_key` or `-k`        |                   | User API key                                                                               |
| `--version` or `-v`        | `release`         | The backend environment of TensorOpera® AI AI Cloud.                                       |

#### Example

```bash
fedml storage upload -d "This is visual common sense reasoning dataset annotations" path/to/dataset/vcr_annotations
```

#### CLI Response

```bash
Uploading Package to Remote Storage: 100%|█████████████████████████████████████████████████████████████████████████████| 97.0M/97.0M [00:03<00:00, 24.6MB/s]
Data uploaded successfully. | url: <Remote Storage URL>
```

---

### `fedml storage download [OPTIONS] DATA_NAME`

Download data stored on TensorOpera® AI Platform

#### Options {#options-1}

| Name                  | Default                   | Description                                                      |
| --------------------- | ------------------------- | ---------------------------------------------------------------- |
| `--help` or `-h`      |                           | Show this message and exit.                                      |
| `--dest_path` or `-d` | Current working directory | Destination path to download data.                               |
| `--service` or `-s`   | `R2`                      | Storage service for object storage. Only R2 available as of now. |
| `--api_key` or `-k`   |                           | User API key                                                     |
| `--version` or `-v`   | `release`                 | The backend environment of TensorOpera® AI Cloud.                |

#### Example

```bash
fedml storage download -d path/to/destination vcr_annotations
```

#### CLI Response

```bash
Downloading Package from Remote Storage: 100%|█████████████████████████████████████████████████████████████████████████| 97.0M/97.0M [00:04<00:00, 21.6MB/s]
Data downloaded successfully at: path/to/destination
```

---

### `fedml storage get-metadata [OPTIONS] DATA_NAME`

Get metadata of data object stored on TensorOpera® AI Platform

#### Options

| Name                | Default   | Description                                       |
| ------------------- | --------- | ------------------------------------------------- |
| `--help` or `-h`    |           | Show this message and exit.                       |
| `--api_key` or `-k` |           | User API key                                      |
| `--version` or `-v` | `release` | The backend environment of TensorOpera® AI Cloud. |

#### Example

```bash
fedml storage get-metadata vcr_annotations
```

#### CLI Response

```bash
Successfully fetched metadata for object vcr_annotations:
+-----------------+-----------------------------------------------------------+---------------------+---------------------+
|    Data Name    |                        Description                        |      Created At     |      Updated At     |
+-----------------+-----------------------------------------------------------+---------------------+---------------------+
| vcr_annotations | This is visual common sense reasoning dataset annotations | 2024-04-12T00:05:46 | 2024-04-12T00:05:46 |
+-----------------+-----------------------------------------------------------+---------------------+---------------------+
```

---

### `fedml storage get-user-metadata [OPTIONS] DATA_NAME`

Get user-defined metadata of data object stored on TensorOpera® AI Platform

#### Options

| Name                | Default   | Description                                       |
| ------------------- | --------- | ------------------------------------------------- |
| `--help` or `-h`    |           | Show this message and exit.                       |
| `--api_key` or `-k` |           | User API key                                      |
| `--version` or `-v` | `release` | The backend environment of TensorOpera® AI Cloud. |

#### Example

```bash
fedml storage get-user-metadata vcr_annotations
```

#### CLI Response

```bash
Successfully fetched user-metadata for vcr_annotations:
{'key1': 'value'}
```

---

### `fedml storage list [OPTIONS]`

List data stored on TensorOpera® AI Platform

#### Options

| Name                | Default   | Description                                       |
| ------------------- | --------- | ------------------------------------------------- |
| `--help` or `-h`    |           | Show this message and exit.                       |
| `--api_key` or `-k` |           | User API key                                      |
| `--version` or `-v` | `release` | The backend environment of TensorOpera® AI Cloud. |

#### Example

```bash
fedml storage list
```

#### CLI Response

```bash
Successfully fetched list of stored objects:
+-----------------+-----------------------------------------------------------+---------------------+---------------------+
|    Data Name    |                        Description                        |      Created At     |      Updated At     |
+-----------------+-----------------------------------------------------------+---------------------+---------------------+
|  sample_dataset |                  This is a sample dataset                 | 2024-04-12T00:50:23 | 2024-04-12T00:50:23 |
| vcr_annotations | This is visual common sense reasoning dataset annotations | 2024-04-12T00:05:46 | 2024-04-12T00:05:46 |
+-----------------+-----------------------------------------------------------+---------------------+---------------------+
```

---

### `fedml storage delete [OPTIONS] DATA_NAME`

Delete data stored on TensorOpera® AI Platform

#### Options {#options-1}

| Name                | Default   | Description                                                      |
| ------------------- | --------- | ---------------------------------------------------------------- |
| `--help` or `-h`    |           | Show this message and exit.                                      |
| `--service` or `-s` | `R2`      | Storage service for object storage. Only R2 available as of now. |
| `--api_key` or `-k` |           | User API key                                                     |
| `--version` or `-v` | `release` | The backend environment of TensorOpera® AI Cloud.                |

#### Example

```bash
fedml storage delete sample_dataset
```

#### CLI Response

```bash
Data 'sample_dataset' deleted successfully.
```
