#!/bin/bash

set -e
set -x

YOUR_USERNAME=
YOUR_PASSWORD=

# 检查是否已安装 Docker
if ! command -v docker &> /dev/null
then
    echo "请先安装 Docker"
    cp docker-ce.repo /etc/yum.repos.d/
    yum -y install docker-ce docker-ce-cli containerd.io
    systemctl start docker
fi

#创建docker registry工作目录
mkdir -p /data/docker.registry

# 创建证书存储目录
mkdir -p /data/docker.registry/etc/registry/auth

#安装htpasswd工具
yum -y install httpd-tools

#创建管理员
htpasswd -Bbn ${YOUR_USERNAME} ${YOUR_PASSWORD} > /data/docker.registry/etc/registry/auth/passwd

# 生成证书
#openssl req \
#    -newkey rsa:4096 -nodes -sha256 \
#    -keyout ~/certs/domain.key \
#    -x509 -days 365 -out ~/certs/domain.crt

#加载docker-registry镜像
docker load -i registry.tar

# 启动 Registry
docker run -d \
    --restart=always \
    --name registry \
    -v /data/docker.registry/etc/registry/auth:/etc/registry/auth \
    -v /data/docker.registry/var/lib/registry:/var/lib/registry \
    -e REGISTRY_AUTH=htpasswd \
    -e REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm" \
    -e REGISTRY_AUTH_HTPASSWD_PATH=/etc/registry/auth/passwd \
    -p 5000:5000 \
    registry:2
    #-e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
    #-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
    #-e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \