# yapi自用脚本安装

- 必须有docker环境，dockerhub
- 直接执行 "build.sh"   默认1.5.10;
- 选择版本 "build.sh 1.5.10"


# =========== 自用手动步骤  ===========

## 下载yapi
wget -O yapi.tgz http://registry.npm.taobao.org/yapi-vendor/download/yapi-vendor-1.5.7.tgz

## 本地编译
docker build -t yapi-svr .

### 私有库编译和推送
- docker build -t 127.0.0.1/devops/yapi-svr .
- 修改docker-compose.xml中, image: 127.0.0.1/devops/yapi-svr
- docker push 127.0.0.1/devops/yapi-svr

## 启动
### 创建网络
docker network create --subnet=172.18.0.0/16 yapi-net

### 启动mongodb
- docker-compose -f docker-compose-mongodb.yml up -d
- 等待启动完毕,然后测试是否启动成功
- curl http://localhost:27017


### 启动yapi
docker-compose up -d

# 访问
http://172.25.2.136:8000

# 问题
- 初始化锁不成功，缺少init.lock ;
- docker exec yapi-srv touch /yapi/init.lock

# 帮助
## 看日志
docker logs -f yapi-srv
## 重启
docker restart yapi-srv