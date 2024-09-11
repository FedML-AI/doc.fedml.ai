# Docker

All FedML Docker images are hosted at the [FedML Docker Hub](https://hub.docker.com/repository/docker/fedml/fedml).

We recommend using FedML in a Docker environment as it circumvents complex and tedious installation debugging. Currently, we maintain docker images for x86_64 architectures. However, you can also build a Docker image with support for the following architectures as well: `arm, raspberrypi, nvidia jetson`, using the corresponding Dockerfile located in the installation directory of the [GitHub repository](https://github.com/FedML-AI/FedML/tree/master/installation/build_fedml_docker).

:::info
Remember to change the `FEDML_DOCKER_IMAGE`, `LOCAL_WORKSPACE`, and `DOCKER_WORKSPACE` environmental variables in the commands below to your own settings.
:::

## Standard Docker Image

The FedML standard Docker image supports running on both CPU an GPU devices. The standard image size is about 9.5GB. If you want to run on the MacOS platform, it is recommended to run the Light Docker image which supports multiple architectures.

**(1) Pull image and prepare the environment**

```
FEDML_DOCKER_IMAGE=fedml/fedml:latest-torch1.13.1-cuda11.6-cudnn8-devel
docker pull $FEDML_DOCKER_IMAGE

# if you want to use GPUs in your host OS, please follow this link: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
sudo chmod 777 /var/run/docker.sock
```

**(2) Run with interactive mode**

**_On GPUs_**

```
FEDML_DOCKER_IMAGE=fedml/fedml:latest-torch1.13.1-cuda11.6-cudnn8-devel
LOCAL_WORKSPACE=$PleaseUseYourLocalDirectory
DOCKER_WORKSPACE=/home/fedml/fedml_source

docker run -v $LOCAL_WORKSPACE:$DOCKER_WORKSPACE --shm-size=64g --ulimit nofile=65535 --ulimit memlock=-1 --privileged --gpus all --network=host --env WORKSPACE=$DOCKER_WORKSPACE -ti $FEDML_DOCKER_IMAGE /bin/bash
```

**_On CPUs_**

```
FEDML_DOCKER_IMAGE=fedml/fedml:latest-torch1.13.1-cuda11.6-cudnn8-devel
LOCAL_WORKSPACE=$PleaseUseYourLocalDirectory
DOCKER_WORKSPACE=/home/fedml/fedml_source

ddocker run -v $LOCAL_WORKSPACE:$DOCKER_WORKSPACE --shm-size=64g --ulimit nofile=65535 --ulimit memlock=-1 --privileged --network=host --env WORKSPACE=$DOCKER_WORKSPACE -ti $FEDML_DOCKER_IMAGE /bin/bash
```

**(3) Run examples**

Now, you should now be inside the container. First, you need to log into the MLOps platform. The `USERID` placeholder used below refers to your user id in the ChainOpera AI platform:

```
root@142ffce4cdf8:/#
root@142ffce4cdf8:/# fedml login <USERID>
```

Afterwards, enter the `$WORKSPACE` directory which is the `$DOCKER_WORKSPACE` defined earlier when initializing the container and run your own examples:

```
root@142ffce4cdf8:/#
root@142ffce4cdf8:/# cd $WORKSPACE
root@142ffce4cdf8:/home/fedml/fedml_source#
```

## Light Docker Image

**(1) Run light Docker with interactive mode**

The light docker is a smaller image about 5GB size. So it can pull and run more smoothly. The light docker provides only CPU support. To use the GPUs, you should use the standard Docker with GPU options. Each docker image needs more than 5GB memory size to run the fedml learning task (estimated when using the MNIST dataset; for other datasets the memory requirements may vary).

:::tip
On MacOS, you can set the memory size from: DockerDesktop -> Settings (gear icon) -> Resources -> Memory limit.

:::

```
FEDML_DOCKER_IMAGE=fedml/fedml:light
LOCAL_WORKSPACE=$PleaseUseYourLocalDirectory
DOCKER_WORKSPACE=/home/fedml/fedml_source

docker run -v $LOCAL_WORKSPACE:$DOCKER_WORKSPACE --shm-size=64g --ulimit nofile=65535 --ulimit memlock=-1 --privileged --network=host --env WORKSPACE=$DOCKER_WORKSPACE -ti $FEDML_DOCKER_IMAGE /bin/bash
```

You should now see a prompt in your terminal, from where you may run the `fedml login $USERID` command to log into the MLOps platform. For instance:

```
root@142ffce4cdf8:/#
root@142ffce4cdf8:/# fedml login 1606
```

And also, you may enter into the `$WORKSPACE` host directory, set through the command above `--env WORKSPACE=$DOCKER_WORKSPACE`), to run your own examples:

```
root@142ffce4cdf8:/#
root@142ffce4cdf8:/# cd $WORKSPACE
root@142ffce4cdf8:/home/fedml/fedml_source#
```

**(2) Run light Docker with daemon mode and automatically log into the MLOps platform**

You may run the light docker as the daemon mode and automatically log into the MLOps platform as the client.
To achieve this, you can use the following commands:

```
FEDML_DOCKER_IMAGE=fedml/fedml:light
LOCAL_WORKSPACE=$PleaseUseYourLocalDirectory
DOCKER_WORKSPACE=/home/fedml/fedml_source
YOUR_FEDML_USER_ID=1606

docker run -v $LOCAL_WORKSPACE:$DOCKER_WORKSPACE --shm-size=64g --ulimit nofile=65535 --ulimit memlock=-1 --privileged --network=host --env WORKSPACE=$DOCKER_WORKSPACE -d $FEDML_DOCKER_IMAGE bash -c 'fedml login '$YOUR_FEDML_USER_ID';sleep 100000'
```

You may run the light docker as the daemon mode and automatically log into the MLOps platform as the server with the option '-s', as follows:

```
FEDML_DOCKER_IMAGE=fedml/fedml:light
LOCAL_WORKSPACE=$PleaseUseYourLocalDirectory
DOCKER_WORKSPACE=/home/fedml/fedml_source
YOUR_FEDML_USER_ID=1606

docker run -v $LOCAL_WORKSPACE:$DOCKER_WORKSPACE --shm-size=64g --ulimit nofile=65535 --ulimit memlock=-1 --privileged --network=host --env WORKSPACE=$DOCKER_WORKSPACE -d $FEDML_DOCKER_IMAGE bash -c 'fedml login -s '$YOUR_FEDML_USER_ID'; sleep 100000'
```

After you run the above command, the terminal will print the container id which looks something like:
`b0769135f8e65c5b0b7b7cb9666f3f910a4e431c25084ed72ae059ea1a6376af`

To inspect the logs of the fedml light container, you can run the following command using the above container id:

```
docker logs b0769135f8e65c5b0b7b7cb9666f3f910a4e431c25084ed72ae059ea1a6376af
```

If you want to list the fedml light containers, you may run the command:

```
docker ps | grep fedml:light
```

If you want to kill all fedml light containers, execute the following:

```
docker stop `docker ps | grep fedml:light | awk -F' ' '{print $1}'`
```

**(4) Run the interpreter in PyCharm or Visual Studio using Docker environment**

- PyCharm

[https://www.jetbrains.com/help/pycharm/using-docker-as-a-remote-interpreter.html#summary](https://www.jetbrains.com/help/pycharm/using-docker-as-a-remote-interpreter.html#summary)

- Visual Studio

[https://code.visualstudio.com/docs/remote/containers](https://www.jetbrains.com/help/pycharm/using-docker-as-a-remote-interpreter.html#summary)

**(5) Other useful commands**

```
# docker rm $(docker ps -aq)
docker container kill $(docker ps -q)
```
