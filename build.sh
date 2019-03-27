#!/bin/sh
#下载yapi
wget -O yapi.tgz http://registry.npm.taobao.org/yapi-vendor/download/yapi-vendor-1.5.7.tgz
#创建网络
docker network create --subnet=172.18.0.0/16 yapi-net
#编译
docker build -t 172.25.2.140/anjubao-devops/yapi-svr .
#推送私有库
docker push 172.25.2.140/anjubao-devops/yapi-svr
#启动mongodb
docker-compose -f docker-compose-mongodb.yml up -d
sleep 5000
#启动yapi
docker-compose up -d

echo "end"