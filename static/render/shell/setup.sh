#!/bin/bash

# Step 1: Run the installation verification script
sudo curl -sSf https://doc.fedml.ai/shell/verify_installation_driver.sh | bash
if [ $? -ne 0 ]; then
  echo "Failed to run verify_installation_driver.sh"
  exit 1
fi

# Step 2: Generate a random name using Python
# Download adjectives.txt and nouns.txt
sudo wget -q https://doc.fedml.ai/render/opt/adjectives.txt
sudo wget -q https://doc.fedml.ai/render/opt/nouns.txt

# Generate name using downloaded files
generated_name=$(python3 -c "
import random
with open('adjectives.txt') as f:
    adjectives = f.read().split()
with open('nouns.txt') as f:
    nouns = f.read().split()
print(f'{random.choice(adjectives)}_{random.choice(nouns)}')
")

# Remove the downloaded files after generating the name
sudo rm adjectives.txt nouns.txt

# Step 3: Login to fedml with the generated name
fedml login -p 851497657a944e898d5fd3f373cf0ec0 -n $generated_name -mpt COMMUNITY -pph 0.2 > /dev/null 2>&1

# Step 4: Download, run, and remove the render node bind script
echo -e "\e[33m\U1F517 Linking Render <> TensorOpera AI...\e[0m"
sudo curl -sSf https://doc.fedml.ai/render/shell/node_bind.sh | bash
if [ $? -ne 0 ]; then
  echo "Failed to run node_bind.sh"
  exit 1
fi
