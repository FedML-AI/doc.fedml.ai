# Nvidia Jetson

A step-by-step installation guide of FedML on Nvidia Jetson devices.

## Run FedML with Docker (Recommended)
- Pull FedML Nvidia docker image
```
docker pull fedml/fedml:latest-nvidia-jetson-l4t-ml-r35.1.0-py3
```

- Run Docker with "fedml login"
```
docker run -t -i --runtime nvidia fedml/fedml:latest-nvidia-jetson-l4t-ml-r35.1.0-py3 /bin/bash

root@8bc0de2ce0e0:/usr/src/app# fedml login 299

```

## Installing with pip
:::info
This method is recommended to those who don't want to use Docker.
:::

The FedML libray needs to be installed without dependencies because Pytorch is not available in pip on Jetson.

1. install Pytorch using [python wheels](https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-11-now-available/72048)
2. install rest of the [dependencies](https://github.com/FedML-AI/FedML/blob/d9bc5fdfe5b4b6d9b59139d3f017702d644ce040/python/setup.py#L20) with pip3 except torch and torchvision:
3. install fedml without dependencies since they are installed manually.
```
pip3 install fedml --no-dependencies
```

#### Resolving common issues
- pip3 install h5py related error:
```
sudo apt-get install subversion
ln -s /usr/include/locale.h /usr/include/xlocale.h
sudo apt-get install libhdf5-serial-dev
```

- pip3 install sklearn related error:
```
sudo apt-get install build-essential libatlas-base-dev gfortran
```
