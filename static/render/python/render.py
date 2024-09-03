import os
import sys
import yaml
import requests
import time

BACKEND_URL = "https://tensorOpera.ai/cheetah/cli/web3/token-node-rel"

TOKEN_MISSING_ERROR_MESSAGE = ("\033[1;31m\u2717 Error: Render Auth Token is missing. Kindly execute the last command again, "
                               "and enter Render Auth Token when prompted\033[0m")

FEDML_CONFIG_MISSING_ERROR_MESSAGE = ("\033[1;31m\u2717 Error: Your node failed to bind to the FEDML platform. "
                                      "Please try the binding process from start again.\033[0m")

NODE_BIND_SUCCESS_MESSAGE = ("\033[1;32m🏆 Congratulations! "
                             "Your node is successfully binded to the FEDML platform!\033[0m")

def read_edge_id():
    home_dir = os.path.expanduser("~")
    edge_id_file = os.path.join(home_dir, ".fedml/fedml-client/fedml/data/runner_infos/runner_infos.yaml")
    start_time = time.time()
    while time.time() - start_time < 180:  # 3-minute timeout
        try:
            with open(edge_id_file, "r") as f:
                runner_infos = yaml.safe_load(f)
                edge_id = runner_infos.get("edge_id")
                if edge_id:
                    return edge_id
        except Exception as e:
            time.sleep(1)  # Sleep for 1 second before retrying
    sys.exit(1)


def read_api_key():
    home_dir = os.path.expanduser("~")
    api_key_file = os.path.join(home_dir, ".fedml/fedml-client/fedml/data/secret/launch_secret")
    try:
        with open(api_key_file, "r") as f:
            api_key = f.read().strip()
    except Exception as e:
        print(FEDML_CONFIG_MISSING_ERROR_MESSAGE)
        sys.exit(1)
    return api_key


def send_request(render_token, edge_id, api_key, public_ip=None):
    headers = {"Authorization": f"Bearer {api_key}"}
    payload = {"nodeId": edge_id, "token": render_token, "ip": public_ip}
    response = requests.post(BACKEND_URL, headers=headers, json=payload)
    return response

def get_public_ip():
    try:
        response = requests.get('https://api.ipify.org')
        if response.status_code == 200:
            return response.text
        else:
            return None
    except requests.RequestException as e:
        return None

def validate_input(render_token, edge_id, api_key):
    if render_token.strip() == "":
        print(TOKEN_MISSING_ERROR_MESSAGE)
        sys.exit(1)

    if edge_id.strip() == "" or api_key.strip() == "":
        print(FEDML_CONFIG_MISSING_ERROR_MESSAGE)
        sys.exit(1)

def is_request_successful(response):
    if response.status_code != 200:
        return False
    resp_data = response.json()
    code = resp_data.get("code", None)
    if code and code.lower() == "success":
        return True
    return False


def main(render_token):
    edge_id = read_edge_id()
    api_key = read_api_key()
    public_ip = get_public_ip()
    validate_input(render_token=render_token, edge_id=edge_id, api_key=api_key)
    response = send_request(render_token=render_token, edge_id=edge_id, api_key=api_key, public_ip=public_ip)

    if is_request_successful(response):
        print(NODE_BIND_SUCCESS_MESSAGE)
    else:
        print("\033[1;31m\u2717 The attempt to bind the node to the TensorOpera platform has encountered a failure. "
              "Please retry the binding process from the start, and if the problem persists, reach out to the TensorOpera Team for further assistance.",
              response.status_code,
              "\033[0m")
        print("Error message:", response.text)
        sys.exit(1)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python render.py <render_token>")
        sys.exit(1)
    main(sys.argv[1])
