#!/bin/bash

# Initialize miniconda shell
source "$HOME/miniconda3/etc/profile.d/conda.sh"

# Set flag to indicate whether all verifications passed
verification_passed=true

# Check if Miniconda is installed
if ! command conda &> /dev/null; then
    echo -e "\e[31m✘ Miniconda is not installed.\e[0m"
    verification_passed=false
else
    echo -e "\e[32m✔ Miniconda is installed.\e[0m"
fi

# Check if fedml is installed in the conda environment
if conda activate fedml && pip show fedml &> /dev/null; then
    echo -e "\e[32m✔ fedml is installed in the fedml conda environment.\e[0m"
else
    echo -e "\e[31m✘ fedml is not installed in the fedml conda environment.\e[0m"
    verification_passed=false
fi

# Check if Docker is installed
if ! command docker &> /dev/null; then
    echo -e "\e[31m✘ Docker is not installed.\e[0m"
    verification_passed=false
else
    echo -e "\e[32m✔ Docker is installed.\e[0m"
fi

# Check if Redis is installed
if ! command redis-server -v &> /dev/null; then
    echo -e "\e[31m✘ Redis is not installed.\e[0m"
    verification_passed=false
else
    echo -e "\e[32m✔ Redis is installed.\e[0m"
fi

# Check if NVIDIA Container Toolkit is installed
if ! command nvidia-smi &> /dev/null; then
    echo -e "\e[31m✘ NVIDIA Container Toolkit is not installed.\e[0m"
    verification_passed=false
else
    echo -e "\e[32m✔ NVIDIA Container Toolkit is installed.\e[0m"
fi

# Output final message based on verification status
if [ "$verification_passed" = true ]; then
    echo -e "\e[32m✔ All components installed successfully.\e[0m"
else
    echo -e "\e[31m✘ One or more components failed to install. Please retry the installation process.\e[0m"
    exit 1
fi