#!/bin/bash

_INSTALL(){
	if [ -f /etc/centos-release ]; then
		yum install -y wget curl zip
	else
		apt install -y wget curl zip
	fi
	mkdir /etc/trojan-go
	mkdir /usr/share/trojan-go
	wget -N --no-check-certificate https://github.com/p4gefau1t/trojan-go/releases/download/$(curl -fsSL https://api.github.com/repos/p4gefau1t/trojan-go/releases | grep '"tag_name":' | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/')/trojan-go-linux-amd64.zip && unzip -d /usr/share/trojan-go/ ./trojan-go-linux-amd64.zip && mv /usr/share/trojan-go/trojan-go /usr/bin/ && chmod +x /usr/bin/trojan-go && rm -rf ./trojan-go-linux-amd64.zip
	cp /usr/share/trojan-go/example/server.json /etc/trojan-go/config.json
	cp /usr/share/trojan-go/example/trojan-go.service /etc/systemd/system/trojan-go.service
	systemctl daemon-reload
	systemctl enable trojan-go
	echo Done!
}

_INSTALL
