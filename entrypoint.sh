#!/bin/sh

# yapi初始化后会有一个init.lock文件
lockPath="/yapi/init.lock"



# 进入yapi项目
cd /yapi/vendors


# 如果初始化文件文件存在,则直接运行,否则初始化
if [ ! -f "$lockPath" ]; then
  # 启动Yapi初始化
  r = node server/install.js
	if [ r != 0 ]; then
		# 不能初始化完成，已初始化|初始化完成但是init.lock不存在，则开始运行服务
		node server/app.js
	fi
else
  # 运行yapi管理系统
  node server/app.js
fi
