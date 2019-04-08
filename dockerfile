FROM node:10.15.3-alpine as builder
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
 && apk add --no-cache git python make openssl tar gcc bash
ADD yapi.tgz /home/
RUN mkdir /yapi && mv /home/package /yapi/vendors
RUN cd /yapi/vendors && \
    npm install --production --registry https://registry.npm.taobao.org
FROM node:9.2-alpine
MAINTAINER 545544032@qq.com
ENV TZ="Asia/Shanghai" HOME="/yapi/vendors"
WORKDIR ${HOME}
COPY --from=builder /yapi/vendors /yapi/vendors
COPY config.json /yapi/
COPY entrypoint.sh /yapi/
RUN chmod 777 -R /yapi

EXPOSE 3000
ENTRYPOINT ["/yapi/entrypoint.sh"]