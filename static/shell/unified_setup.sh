#!/bin/bash

FEDML_API_KEY=""
FEDML_ENV=""
FEDML_PROVIDER=false
FEDML_DEVICE_ID=""
INFERENCE_GATEWAY_PORT=""
INFERENCE_PROXY_PORT=""
FEDML_CONNECTION_TYPE=""
RENTAL_PUBLIC_KEY=""

# This will clean up remnants from a failed bind attempt.
do_cleanup() {
  fedml logout; sudo pkill -9 python; sudo rm -rf ~/.fedml; redis-cli flushall; pidof python | xargs kill -9;
}


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
  conda create -y -n fedml python=3.10
  conda activate fedml
  pip install "git+https://github.com/FedML-AI/FedML.git@dev/v0.7.0#egg=fedml&subdirectory=python"
}

# Function to install Docker
install_docker() {
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    yes | sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# Function to install Redis
install_redis() {
    sudo apt install -y lsb-release curl gnupg
    curl -fsSL https://packages.redis.io/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
    sudo apt-get update
    yes | sudo apt-get install -y redis
}

# Function to install NVIDIA Container Toolkit
install_nvidia_container_toolkit() {
    curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
        && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
        sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
        sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
    sudo apt-get update
    yes | sudo apt-get install -y nvidia-container-toolkit
    sudo nvidia-ctk runtime configure --runtime=docker
    sudo systemctl restart docker
}

# Function to enable access to Docker APIs without requiring sudo permissions
enable_docker_api_access() {
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

# Login
fedml_login(){
    if $3; then
      provider_login $1 $2 $4 $5 $6
    else
      individual_login $1 $2 $4 $5 $6
    fi
}

provider_login(){
  if [ -z "$3" ] && [ -z "$4" ] && [ -z "$5" ]; then
    fedml login -p $1 -v $2
  else
    fedml login -p $1 -v $2 -mgp $3 -wpp $4 -wct $5
  fi
}

individual_login(){
  if [ -z "$3" ] && [ -z "$4" ] && [ -z "$5" ]; then
    fedml login $1 -v $2
  else
    fedml login $1 -v $2 -mgp $3 -wpp $4 -wct $5
  fi
}

#create the devices.id file with the cloud server id
create_tmp_file(){
    device_id=$1
    home_path=$HOME
    new_path="$home_path/.fedml/fedml-client/fedml/data/runner_infos"
    file_name="devices.id"
    if [ ! -e "$new_path" ]; then
        mkdir -p "$new_path"
        new_path+="/"
        entire_path=$new_path$file_name
        printf '%s' "$device_id" > "$entire_path"
    fi
}

#Function to verify the fedml installation
verify_installation(){
  # Creating the tmp folder or removing it if it already exists
  tmp_folder=".render-fedml-bind"
    # Creating the tmp folder or removing it if it already exists
    if [ -d "$tmp_folder" ]; then
        rm -rf "$tmp_folder"
    fi
    mkdir "$tmp_folder"

    # Moving into the tmp folder
    cd "$tmp_folder" || exit

    # Downloading and executing installation verification script
    echo -e "\e[33m\U0001F50E Verifying the FedML environment installation...\e[0m"
    sudo wget -q https://doc.fedml.ai/shell/verify_installation.sh && sudo chmod +x verify_installation.sh
    ./verify_installation.sh
    verification_status=$?

    # Returning to the original directory
    cd ..

    # Removing the tmp folder and its contents
    rm -rf "$tmp_folder"

    # Bind the node to the platform
    if [ "$verification_status" -eq 0 ]; then
      echo -e "\033[1;32m✔ FedML environment verification successful.\033[0m"
      create_tmp_file $4
      fedml_login $1 $2 $3 $5 $6 $7
    else
      echo -e "\e[31m✘ FedML environment installation verification failed. Please retry the binding process again.\e[0m"
      exit 1
    fi
}

# Function to install and set up a SSH reverse proxy
install_sshproxy() {
    # get script from repo and run
    curl https://raw.githubusercontent.com/TensorOpera-Inc/sshproxy/master/setup/install.sh -o /tmp/install_sshproxy.sh
    chmod +x /tmp/install_sshproxy.sh
    sudo /tmp/install_sshproxy.sh
    rm /tmp/install_sshproxy.sh

    # configure firewall & port
    # note that internally the port used is 2222
    if [ $# -lt 1 ]
        then
        echo "No proxy port/firewall specified, skipping configuration"
    elif [ "$SSHPROXY_FIREWALL" = "ufw" ]
        then
        sudo ufw allow 2222
    elif [ "$SSHPROXY_FIREWALL" = "iptables" ]
        then
        if [ $# -lt 2 ]
            then
            echo "No proxy port specified, skipping configuration"
        else
            if [ "$SSHPROXY_PORT" = 2222 ]
                then
                sudo iptables -A INPUT -p tcp --dport 2222 -j ACCEPT
            else
                sudo iptables -A INPUT -p tcp --dport $SSHPROXY_PORT -j ACCEPT
                sudo iptables -A PREROUTING -t nat -p tcp --dport $SSHPROXY_PORT -j REDIRECT --to-ports 2222
            fi
        fi
    else
        echo "Invalid firewall specified, skipping configuration"
    fi
}

add_public_key() {
  SSH_DIR="$HOME/.ssh"
  AUTH_KEYS_FILE="$SSH_DIR/authorized_keys"
  PUBLIC_KEY=$1

  mkdir -p "$SSH_DIR"
  echo "$PUBLIC_KEY" >> "$AUTH_KEYS_FILE"
  # Check if the authorized_keys file exists
  if [ ! -f "$AUTH_KEYS_FILE" ]; then
      # If it doesn't exist, create it and add the key
      echo "$PUBLIC_KEY" > "$AUTH_KEYS_FILE"
      echo "Created $AUTH_KEYS_FILE and added the public key"
  else
      # If it exists, check for the key before adding
      if ! grep -qF "$PUBLIC_KEY" "$AUTH_KEYS_FILE"; then
          echo "$PUBLIC_KEY" >> "$AUTH_KEYS_FILE"
          echo "Public key added to existing $AUTH_KEYS_FILE"
      else
          echo "Public key already exists in $AUTH_KEYS_FILE"
      fi
  fi
  chmod 700 "$SSH_DIR"
  chmod 600 "$AUTH_KEYS_FILE"

  if [ $? -eq 0 ]; then
      echo "Public key successfully added to $AUTH_KEYS_FILE"
  else
      echo "An error occurred while adding the public key"
      exit 1
  fi

}


# Stop unattended upgrades which result in /var/lib/dpkg/lock acquire race condition
sudo systemctl stop unattended-upgrades
sudo systemctl disable unattended-upgrades

while [[ $# -gt 0 ]]; do
  case $1 in
    -api_key)
      FEDML_API_KEY="$2"
      shift 2
      ;;
    -env)
      FEDML_ENV="$2"
      shift 2
      ;;
    -provider)
      FEDML_PROVIDER=true
      shift 1
      ;;
    -device_id)
      FEDML_DEVICE_ID="$2"
      shift 2
      ;;
    -mgp)
      INFERENCE_GATEWAY_PORT="$2"
      shift 2
      ;;
    -wpp)
      INFERENCE_PROXY_PORT="$2"
      shift 2
      ;;
    -wct)
      FEDML_CONNECTION_TYPE="$2"
      shift 2
      ;;
    -public_key)
      RENTAL_PUBLIC_KEY="$2"
      shift 2
      ;;
    *)
      echo "unknown option: $1"
      exit
      ;;
  esac
done




# Call the functions
detect_default_shell
do_cleanup
if [ -n "$RENTAL_PUBLIC_KEY" ]; then
    # Ensure the .ssh directory exists
    add_public_key $RENTAL_PUBLIC_KEY
fi
install_wget
install_miniconda "$default_shell"
init_miniconda_shell "$default_shell"
install_fedml
install_docker
enable_docker_api_access
install_redis
install_nvidia_container_toolkit
# install_sshproxy $SSHPROXY_FIREWALL $SSHPROXY_PORT
set_default_conda_env "$default_shell"
source ~/."${default_shell}rc"
verify_installation $FEDML_API_KEY $FEDML_ENV $FEDML_PROVIDER $FEDML_DEVICE_ID $INFERENCE_GATEWAY_PORT $INFERENCE_PROXY_PORT $FEDML_CONNECTION_TYPE

# Restore unattended-upgrades
sudo systemctl enable unattended-upgrades
sudo systemctl start unattended-upgrades