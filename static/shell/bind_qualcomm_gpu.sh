#!/bin/bash

# Function to detect the default shell
detect_default_shell() {
    # Extract the basename of the default shell from the SHELL environment variable
    default_shell=$(basename "$SHELL")
    
    # Check if the default shell is one of bash or zsh
    if [ "$default_shell" = "bash" ] || [ "$default_shell" = "zsh" ]; then
        echo "Detected shell: $default_shell"
    else
        echo "This script only works with bash or zsh shells." >&2
        exit 1
    fi
}

# Function to install wget
install_wget() {
  sudo apt-get update
  sudo apt-get install -y wget  
}

# Function to download and install Miniconda
install_miniconda() {
    mkdir -p "$HOME/miniconda3"
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    chmod +x "$HOME/miniconda3/miniconda.sh"
    $1 "$HOME/miniconda3/miniconda.sh" -b -u -p "$HOME/miniconda3"
    rm -rf "$HOME/miniconda3/miniconda.sh"
}

# Function to initialize Miniconda shell
init_miniconda_shell() {
    if [ "$1" = "bash" ]; then
        "$HOME/miniconda3/bin/conda" init bash
        source ~/.bashrc        
    elif [ "$1" = "zsh" ]; then
        "$HOME/miniconda3/bin/conda" init zsh
        source ~/.zshrc
    fi
    source "$HOME/miniconda3/bin/activate"
}

# Function to install fedml in a new conda environment
install_fedml() {
  conda create -y -n fedml python=3.8
  conda activate fedml
  pip install "git+https://github.com/FedML-AI/FedML.git@215efb0ac6b0dd3a1d38568fc612814aece4b953#egg=fedml&subdirectory=python"
}

# Function to install Redis
install_redis() {
    sudo apt install -y lsb-release curl gnupg
    curl -fsSL https://packages.redis.io/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
    sudo apt-get update
    yes | sudo apt-get install -y redis
}

# Function to enable access to Docker APIs without requiring sudo permissions
enable_docker_api_access() {
    sudo systemctl start docker
    username=$(whoami)
    if grep -q docker /etc/group; then
        echo "Docker group already exists."
    else
        sudo groupadd docker
        echo "Docker group created."
    fi
    sudo usermod -aG docker $username
    echo "User $username added to the Docker group."
    sudo chmod 777 /var/run/docker.sock
}

# Function to set fedml as default conda env
set_default_conda_env() {
    echo "conda" activate fedml >> "$HOME/.$1rc"
}


# Stop unattended upgrades which result in /var/lib/dpkg/lock acquire race condition
sudo systemctl stop unattended-upgrades
sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf


# Call the functions
detect_default_shell
install_wget
install_miniconda "$default_shell"
init_miniconda_shell "$default_shell"
install_fedml
enable_docker_api_access
install_redis
set_default_conda_env "$default_shell"
source ~/."${default_shell}rc"

# Restore unattended-upgrades
sudo systemctl start unattended-upgrades
