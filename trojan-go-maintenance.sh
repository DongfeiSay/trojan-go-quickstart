#!/bin/bash

if [[ $(id -u) != 0 ]]; then
    echo "请以超级用户身份运行此脚本。"
    exit 1
fi

if [[ $(uname -m 2> /dev/null) != x86_64 ]]; then
    echo "请在x86_64机器上运行此脚本。"
    exit 1
fi

_INSTALL(){
	if [ -f /etc/centos-release ]; then
		yum install -y wget curl zip
	else
		apt install -y wget curl zip
	fi
	mkdir /etc/trojan-go
	mkdir /usr/lib/trojan-go
	wget -N --no-check-certificate https://github.com/p4gefau1t/trojan-go/releases/download/$(curl -fsSL https://api.github.com/repos/p4gefau1t/trojan-go/releases | grep '"tag_name":' | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/')/trojan-go-linux-amd64.zip && unzip -d /usr/lib/trojan-go/ ./trojan-go-linux-amd64.zip && mv /usr/lib/trojan-go/trojan-go /usr/bin/ && chmod +x /usr/bin/trojan-go && rm -rf ./trojan-go-linux-amd64.zip
	cp /usr/lib/trojan-go/example/server.json /etc/trojan-go/config.json
	cp /usr/lib/trojan-go/example/trojan-go.service /etc/systemd/system/trojan-go.service
	systemctl daemon-reload
	systemctl enable trojan-go
	echo "安装完成！"
}

_UPDATE(){
	systemctl stop trojan-go
	rm -rf /usr/bin/trojan-go
	rm -rf /usr/lib/trojan-go/*
	wget -N --no-check-certificate https://github.com/p4gefau1t/trojan-go/releases/download/$(curl -fsSL https://api.github.com/repos/p4gefau1t/trojan-go/releases | grep '"tag_name":' | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/')/trojan-go-linux-amd64.zip && unzip -d /usr/lib/trojan-go/ ./trojan-go-linux-amd64.zip && mv /usr/lib/trojan-go/trojan-go /usr/bin/ && chmod +x /usr/bin/trojan-go && rm -rf ./trojan-go-linux-amd64.zip
	systemctl restart trojan-go
	echo "升级完成！"
}

_UNINSTALL(){
	systemctl stop trojan-go
	systemctl disable trojan-go
	rm -rf /usr/bin/trojan-go /usr/lib/trojan-go /etc/trojan-go
	rm -rf /etc/systemd/system/trojan-go.service
	systemctl daemon-reload
	echo "卸载完成！"
}

echo "1.安装trojan-go"
echo "2.升级trojan-go"
echo "3.卸载trojan-go"
echo
read -e -p "请输入数字：" num
case "$num" in
	1)
	_INSTALL
	;;
	2)
	_UPDATE
	;;
	3)
	_UNINSTALL
	;;
	*)
	echo "请输入正确的数字"
	;;
esac
