#!/bin/bash
set -e

cleanup() {
    # Returning to the original directory
    cd ..

    # Removing the tmp folder and its contents
    rm -rf "$tmp_folder"

    # Cleanup function to execute before exiting
    fedml logout; sudo pkill -9 python; sudo rm -rf ~/.fedml; redis-cli flushall; pidof python | xargs kill -9
}

trap 'cleanup; echo -e "\e[31m✘ Failed to link render token to the node. Please retry the binding process again from the beginning.\e[0m"' ERR


# Creating the tmp folder or removing it if it already exists
tmp_folder=".render-fedml-bind"

# Creating the tmp folder or removing it if it already exists
if [ -d "$tmp_folder" ]; then
    rm -rf "$tmp_folder"
fi
mkdir "$tmp_folder"

# Moving into the tmp folder
cd "$tmp_folder"

echo -e "\e[33m\U1F517 Linking render token to your node...\e[0m"
sudo wget -q https://doc.tensoropera.ai/python/render.py && sudo chmod +x render.py
python3 render.py

# Returning to the original directory
cd ..

# Removing the tmp folder and its contents
rm -rf "$tmp_folder"

echo -e "\033[1;35m🚀 Your token was successfully linked to this node and binded to TensorOpera Platform! Render to the moon 🌙\033[0m"
