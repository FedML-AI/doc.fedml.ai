#!/bin/bash
# Check NVIDIA GPU status
echo "Checking NVIDIA GPU status..."
if ! nvidia-smi &> /dev/null; then
    if nvidia-smi 2>&1 | grep -q "Failed to initialize NVML"; then
        echo -e "\e[31mError: NVIDIA driver mismatch detected.\e[0m"
        echo "The NVIDIA driver version does not match the NVIDIA Management Library (NVML) version."
        echo "Please update your NVIDIA drivers and reboot your system before proceeding."
        echo "You can download the latest drivers from: https://www.nvidia.com/Download/index.aspx"
        exit 1
    else
        echo -e "\e[31mError: NVIDIA GPU not detected or drivers not properly installed.\e[0m"
        echo "Please ensure that you have an NVIDIA GPU and that the drivers are correctly installed."
        exit 1
    fi
else
    echo -e "\e[32mNVIDIA GPU detected and functioning properly.\e[0m"
fi

# Create a hidden temporary folder
tmp_folder=".fedml_render_tmp"
mkdir -p "$tmp_folder"
cd "$tmp_folder"

# Step 1: Run the installation verification script
sudo curl -sSf https://doc.fedml.ai/shell/verify_installation_driver.sh | bash
if [ $? -ne 0 ]; then
  echo "Failed to run verify_installation_driver.sh"
  cd ..
  rm -rf "$tmp_folder"
  exit 1
fi

##### CLEAN THIS UP ONCE WE HAVE NAME GENERATION LOGIC WORKING ON THE BACKEND
# Step 2: Generate a random name using Python
# Download adjectives.txt and nouns.txt
# sudo wget -q https://doc.fedml.ai/render/opt/adjectives.txt
# sudo wget -q https://doc.fedml.ai/render/opt/nouns.txt

# Generate name using downloaded files
# generated_name=$(python3 -c "
# import random
# with open('adjectives.txt') as f:
#     adjectives = f.read().split()
# with open('nouns.txt') as f:
#     nouns = f.read().split()
# print(f'{random.choice(adjectives)}_{random.choice(nouns)}')
# ")
# Check if generated_name is empty
# if [ -z "$generated_name" ]; then
#     echo "Warning: Failed to generate a random name. Using default name."
#     generated_name="default_fedml_node"
# fi
# echo "Generated name: $generated_name"

# Remove the downloaded files after generating the name
# rm adjectives.txt nouns.txt

# Step 3: Login to fedml with the generated name
# fedml login -p fffc0cc4e2fe411da2d78031f575b928 -n $generated_name -mpt COMMUNITY -pph 0.2 > /dev/null 2>&1
##########################################################################################

# Login to fedml
fedml login -p fffc0cc4e2fe411da2d78031f575b928 -mpt COMMUNITY -pph 0.2 > /dev/null 2>&1

# Step 4: Download, run, and remove the render node bind script
wget -q https://doc.fedml.ai/render/shell/node_bind.sh
if [ $? -ne 0 ]; then
  echo "Failed to download node_bind.sh"
  cd ..
  rm -rf "$tmp_folder"
  exit 1
fi

chmod +x node_bind.sh
echo -e "\e[33m\U1F517 Linking Render <> TensorOpera AI...\e[0m"
echo -e "\033[1;35m🔑 Enter your render token:\033[0m"
read -r render_auth_token < /dev/tty

# Ensure we have input
while [ -z "$render_auth_token" ]; do
    echo -e "\033[1;31m\u2717 Error: Render Token cannot be empty.\033[0m"
    echo -e "\033[1;35m🔑 Please enter your render token:\033[0m"
    read -r render_auth_token < /dev/tty
done

if [ -z "$render_auth_token" ]; then
    echo -e "\033[1;31m\u2717 Error: Render Token is missing. Kindly execute the last command again, and enter Render Auth Token when prompted\033[0m"
    cd ..
    rm -rf "$tmp_folder"
    exit 1
fi

bash node_bind.sh $render_auth_token

if [ $? -ne 0 ]; then
  echo "Failed to run node_bind.sh"
  cd ..
  rm -rf "$tmp_folder"
  exit 1
fi

# Clean up
cd ..
rm -rf "$tmp_folder"
