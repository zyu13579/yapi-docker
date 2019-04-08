#!/bin/sh
current_path=$(cd "$(dirname "$0")"; pwd)
cd $current_path
pwd
#下载yapi 默认1.5.10
wget -O yapi.tgz http://registry.npm.taobao.org/yapi-vendor/download/yapi-vendor-${1:-1.5.10}.tgz
#创建网络
docker network create --subnet=172.18.0.0/16 yapi-net
#编译
docker build -t yapi-svr .
#推送私有库
#docker push 127.0.0.1/devops/yapi-svr

#启动mongodb
/usr/local/bin/docker-compose -f docker-compose-mongodb.yml up -d
sleep 5
#启动yapi----2
/usr/local/bin/docker-compose up -d

echo "end"