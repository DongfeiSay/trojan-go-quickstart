#!/bin/bash

_INSTALL(){
	if [ -f /etc/centos-release ]; then
		yum install -y wget curl zip
	else
		apt install -y wget curl zip
	fi
	mkdir /etc/trojan-go
	mkdir /usr/bin/trojan-go
	wget -N --no-check-certificate https://github.com/p4gefau1t/trojan-go/releases/download/$(curl -fsSL https://api.github.com/repos/p4gefau1t/trojan-go/releases | grep '"tag_name":' | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/')/trojan-go-linux-amd64.zip && unzip -d /usr/bin/trojan-go/ ./trojan-go-linux-amd64.zip && chmod +x /usr/bin/trojan-go/trojan-go && rm -rf ./trojan-go-linux-amd64.zip
	cp /usr/bin/trojan-go/example/server.json /etc/trojan-go/config.json
	cp /usr/bin/trojan-go/example/trojan-go.service /etc/systemd/system/trojan-go.service
	systemctl daemon-reload
	systemctl restart trojan-go
	systemctl enable trojan-go
	echo "安装完成"
}


_UPDATE(){
	systemctl stop trojan-go
	rm -rf /usr/bin/trojan-go
	wget -N --no-check-certificate https://github.com/p4gefau1t/trojan-go/releases/download/$(curl -fsSL https://api.github.com/repos/p4gefau1t/trojan-go/releases | grep '"tag_name":' | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/')/trojan-go-linux-amd64.zip && unzip ./trojan-go-linux-amd64.zip && chmod +x ./trojan-go && mv ./trojan-go /usr/bin/trojan-go/ && rm -rf ./trojan-go-linux-amd64.zip ./example ./geoip.dat ./geosite.dat
	systemctl restart trojan-go
	echo "升级完成"
}


_UNINSTALL(){
	systemctl stop trojan-go
	systemctl disable trojan-go
	rm -rf /usr/bin/trojan-go /etc/trojan-go
	rm -rf /etc/systemd/system/trojan-go.service
	systemctl daemon-reload
	echo "卸载完成"
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
