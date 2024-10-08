#!/bin/bash
set -e

# Check if an argument was provided
if [ $# -eq 0 ]; then
    echo -e "\033[1;35m🔑 Enter your render token:\033[0m"
    read render_auth_token
else
    render_auth_token="$1"
fi

# Function to validate the Render auth token
validate_render_token() {
    if [ -z "$render_auth_token" ]; then
        echo -e "\033[1;31m\u2717 Error: Render Auth Token is missing. Kindly execute the last command again, and enter Render Auth Token when prompted\033[0m"
        exit 1
    fi
}

# Call the validation function
validate_render_token


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
sudo wget -q https://doc.fedml.ai/python/render.py && sudo chmod +x render.py
python3 render.py "$render_auth_token"

# Returning to the original directory
cd ..

# Removing the tmp folder and its contents
rm -rf "$tmp_folder"

# echo -e "\033[1;35m🚀 Your node was successfully binded to TensorOpera Platform!\033[0m"
