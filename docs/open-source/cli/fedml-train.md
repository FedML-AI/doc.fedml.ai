---
sidebar_position: 8
---
# Model Training - fedml train
### `fedml train build [OPTIONS]`

#### Options {#options-1}

| Name                          | Default | Description                                                                               |
|-------------------------------|---------|-------------------------------------------------------------------------------------------|
| `--source_folder` or `-sf`    | `false` | the source code folder path                                                               |
| `--entry_point` or `-ep`      | `false` | the entry point of the source code                                                        |
| `--entry_args` or `-ea`       | `false` | entry arguments of the entry point program                                                |
| `--config_folder` or `-cf`    | `false` | the config folder path                                                                    |
| `--dest_folder` or `-df`      | `false` | the destination package folder path                                                       |
| `--ignore` or `-ig`           | `false` | the ignore list for copying files, the format is as follows: *.model,__pycache__,*.data*, |
| `--model_name` or `-m`        | `false` | model name for training.                                                                  |
| `--model_cache_path` or `-mc` | `false` | model cache path for training.                                                            |
| `--input_dim` or `-mi`        | `false` | input dimensions for training.                                                            |
| `--output_dim` or `-mo`       | `false` | output dimensions for training.                                                           |
| `--dataset_name` or `-dn`     | `false` | dataset name for training.                                                                |
| `--dataset_type` or `-dt`     | `false` | dataset type for training.                                                                |
| `--dataset_path` or `-dp`     | `false` | dataset path for training.                                                                |

At first, you need to define your package properties as follows.
If you want to ignore some folders or files, you may specify the ignore argument
or add them to the .gitignore file in the source code folder.

#### Required arguments:
source code folder, entry file, entry arguments,
config folder, built destination folder

#### Optional arguments:
You may define the model and data arguments using the command arguments as follows.
```
model name, model cache path, model input dimension, model output dimension,
dataset name, dataset type, dataset path.
```

Also, you may define the model and data arguments using the file named fedml_config.yaml as follows.
```
fedml_data_args:
    dataset_name: mnist
    dataset_path: ./dataset
    dataset_type: csv
    
fedml_model_args:
    input_dim: '784'
    model_cache_path: /Users/alexliang/fedml_models
    model_name: lr
    output_dim: '10'
```

The above model and data arguments will be mapped to the equivalent environment variables as follows.
```
dataset_name = $FEDML_DATASET_NAME
dataset_path = $FEDML_DATASET_PATH
dataset_type = $FEDML_DATASET_TYPE
model_name = $FEDML_MODEL_NAME
model_cache_path = $FEDML_MODEL_CACHE_PATH
input_dim = $FEDML_MODEL_INPUT_DIM
output_dim = $FEDML_MODEL_OUTPUT_DIM
```

Your may pass these environment variables as your entry arguments. e.g.,
```
ENTRY_ARGS_MODEL_DATA='-m $FEDML_MODEL_NAME -mc $FEDML_MODEL_CACHE_PATH -mi $FEDML_MODEL_INPUT_DIM -mo $FEDML_MODEL_OUTPUT_DIM -dn $FEDML_DATASET_NAME -dt $FEDML_DATASET_TYPE -dp $FEDML_DATASET_PATH'
```

#### Examples {#example-1}
```
# Define the package properties
SOURCE_FOLDER=.
ENTRY_FILE=train.py
ENTRY_ARGS='--epochs 1'
ENTRY_ARGS_MODEL_DATA='-m $FEDML_MODEL_NAME -mc $FEDML_MODEL_CACHE_PATH -mi $FEDML_MODEL_INPUT_DIM -mo $FEDML_MODEL_OUTPUT_DIM -dn $FEDML_DATASET_NAME -dt $FEDML_DATASET_TYPE -dp $FEDML_DATASET_PATH'
CONFIG_FOLDER=config
DEST_FOLDER=./mlops
MODEL_NAME=lr
MODEL_CACHE=~/fedml_models
MODEL_INPUT_DIM=784
MODEL_OUTPUT_DIM=10
DATASET_NAME=mnist
DATASET_TYPE=csv
DATASET_PATH=./dataset

# Build the train package with the model and data arguments
fedml train build -sf $SOURCE_FOLDER -ep $ENTRY_FILE -ea "$ENTRY_ARGS" \
    -cf $CONFIG_FOLDER -df $DEST_FOLDER \
    -m $MODEL_NAME -mc $MODEL_CACHE -mi $MODEL_INPUT_DIM -mo $MODEL_OUTPUT_DIM \
    -dn $DATASET_NAME -dt $DATASET_TYPE -dp $DATASET_PATH

# Build the train package without the model and data arguments
fedml train build -sf $SOURCE_FOLDER -ep $ENTRY_FILE -ea "$ENTRY_ARGS" \
    -cf $CONFIG_FOLDER -df $DEST_FOLDER
```