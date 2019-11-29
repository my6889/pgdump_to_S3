FROM postgres:12.1-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk update && \
    apk add py-pip && \
    pip install awscli --upgrade -i https://pypi.douban.com/simple/  && \
    mkdir /pgdump && \
    chmod -R 777 /pgdump

ENV PGDUMP_OPTIONS -Fc --no-acl --no-owner
ENV PGDUMP_DATABASE **None**

ENV AWS_ACCESS_KEY_ID **None**
ENV AWS_SECRET_ACCESS_KEY **None**
ENV AWS_BUCKET **None**

ENV PREFIX **None**

ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
