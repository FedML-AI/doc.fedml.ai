---
sidebar_position: 5
---

# ChainOpera Federate APIs

### `fedml.init()`

Initialize the fedml library.

**Usage**

```py
fedml.init(args=None, check_env=True, should_init_logs=True) -> None
```

**Arguments**

- `args (str=None)`: Arguments.
- `check_env (bool=True)`: Do we need to check the environment? such as gpu info, network connection, etc.
- `should_init_logs (bool=True)`: Do we need to init logs related environment.

**Returns**  
`None`

**Examples**

```py
import fedml
from fedml.cross_silo import Client

if __name__ == "__main__":
    args = fedml.init()
```

### `fedml.device.get_device()`

Apply the compute device (GPUs) for federated learning.

**Usage**

```py
fedml.device.get_device(args) -> torch.device
```

**Arguments**

- `args (str=None)`: Arguments.

**Returns**  
torch.device.

**Examples**

```py
import fedml

if __name__ == "__main__":
    # init FedML framework
    args = fedml.init()

    # init device
    device = fedml.device.get_device(args)
```

### `fedml.data.load()`

Load datasets for federated learning.

**Usage**

```py
fedml.data.load(args) -> (dataset, output_dim)
```

**Arguments**

- `args (str=None)`: Arguments.

**Returns**  
`(dataset, output_dim)`

**Examples**

```py
import fedml

if __name__ == "__main__":
    # init FedML framework
    args = fedml.init()

    # init device
    device = fedml.device.get_device(args)

    # load data
    dataset, output_dim = fedml.data.load(args)
```

### `fedml.model.create()`

Load the model for federated learning.

**Usage**

```py
fedml.model.create(args, output_dim) -> model
```

**Arguments**

- `args (str=None)`: Arguments.
- `output_dim (int)`: Output dimension for model.

**Returns**  
`(dataset, output_dim)`

**Examples**

```py
import fedml

if __name__ == "__main__":
    # init FedML framework
    args = fedml.init()

    # init device
    device = fedml.device.get_device(args)

    # load data
    dataset, output_dim = fedml.data.load(args)

    # load model
    model = fedml.model.create(args, output_dim)
```

### `fedml.FedMLRunner.run()`

Run the federated learning instance (client or server).

**Usage**

```py
fedml.FedMLRunner.run() -> None
```

**Arguments**
`None`

**Returns**  
`None`

**Examples**

Example for the federated learning <ins>client</ins>:

```py
import fedml
from fedml.cross_silo import Client

if __name__ == "__main__":
    args = fedml.init()

    # init device
    device = fedml.device.get_device(args)

    # load data
    dataset, output_dim = fedml.data.load(args)

    # load model
    model = fedml.model.create(args, output_dim)

    # start training
    client = Client(args, device, dataset, model)
    client.run()

```

Example for the federated learning <ins>server</ins>:

```py
import fedml
from fedml.cross_silo import Server

if __name__ == "__main__":
    args = fedml.init()

    # init device
    device = fedml.device.get_device(args)

    # load data
    dataset, output_dim = fedml.data.load(args)

    # load model
    model = fedml.model.create(args, output_dim)

    # start training
    server = Server(args, device, dataset, model)
    server.run()
```
