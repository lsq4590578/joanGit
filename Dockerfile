#Base images
FROM centos

#MAINTAINER 维护人
MAINTAINER test

#ADD 添加本地文件到镜像
ADD nginx-1.9.3.tar.gz /usr/local/src

#RUN 在镜像中执行命令
RUN yum install -y wget gcc_c++ make openssl-devel
RUN useradd -s /sbin/nologin -M www

#WORKDIR 镜像中切换到目录
WORKDIR /usr/local/src/nginx-1.9.3

RUN yum install -y gcc gcc-c++
RUN ./configure --prefix=/usr/local/nginx --user=www --group=www --with-http_ssl_module --with-http_stub_status_module --with-pcre=/usr/local/src/pcre-8.37 && make && make install
RUN echo "daemon off;">>/usr/local/nginx/conf/nginx.conf

#配置环境变量
ENV PATH /usr/local/nginx/sbin:$PATH

EXPOSE 80

CMD  ["nginx"]
