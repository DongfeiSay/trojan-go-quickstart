# trojan-go-quickstart

A simple installation script for trojan-go server.

This script will help you install the trojan-go binary to `/usr/bin/trojan-go`, a template for server configuration to `/etc/trojan-go`, and (if applicable) a systemd service to `/etc/systemd/system`. It only works on `linux-amd64` machines.

## Usage

- via `curl`
    ```
    sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/DongfeiSay/trojan-go-quickstart/master/trojan-go-quickstart.sh)"
    ```
- via `wget`
    ```
    sudo bash -c "$(wget -O- https://raw.githubusercontent.com/DongfeiSay/trojan-go-quickstart/master/trojan-go-quickstart.sh)"
    ```
