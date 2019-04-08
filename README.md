#yapi安装

直接执行 "build.sh"   默认1.5.10;
选择版本 "build.sh 1.5.10"


===================================步骤=====================

##下载yapi
wget -O yapi.tgz http://registry.npm.taobao.org/yapi-vendor/download/yapi-vendor-1.5.7.tgz

##编译
docker build -t 172.25.2.140/anjubao-devops/yapi-svr .

###推送私有库
docker push 172.25.2.140/anjubao-devops/yapi-svr

##启动
###创建网络
docker network create --subnet=172.18.0.0/16 yapi-net

###启动mongodb
- docker-compose -f docker-compose-mongodb.yml up -d
- 等待启动完毕
- curl http://localhost:27017


###启动yapi
docker-compose up -d

#访问
http://172.25.2.136:8000

#问题
初始化锁不成功，缺少init.lock
docker exec yapi-srv touch /yapi/init.lock

#帮助
看日志
docker logs -f yapi-srv
重启
docker restart yapi-srv