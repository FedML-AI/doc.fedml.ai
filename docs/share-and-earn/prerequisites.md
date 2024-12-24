# Node prerequisites for binding to TensorOpera® AI platform

In order to bind node to TensorOpera® AI platform, you need to have **NVIDIA GPU(s) with CUDA drivers** installed.

To check if Nvidia drivers are installed, run the following command:

```bash
nvidia-smi
```

If you see similar output as below with GPU details, you are good to go:

![nvidia-smi-output](./static/image/nvidia-smi-output.png)

:::tip
The precise results you see on your terminal may vary based on the number of GPU cards and the type of GPU cards available on your node. So consider the screenshots above as mere examples to ensure it appears somewhat similar.
:::

If you don't have Nvidia drivers installed, you can first try to install them using the following command:

```bash
sudo ubuntu-drivers autoinstall
sudo apt install nvidia-cuda-toolkit
sudo reboot
nvidia-smi
```

If the above commands don't work, you can follow the instructions on [NVIDIA's official website](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html).
