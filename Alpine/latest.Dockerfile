FROM alpine:latest

LABEL maintainer='Anton Melekhin'

ENV container=docker \
    DEBIAN_FRONTEND=noninteractive

#换源安装systemd，openssh,创建ssh公钥私钥，给root用户修改密码为root，UseDNS no表示去掉远程ssh连接时的DNS域名解析
RUN INSTALL_PKGS='openrc openssh-server' \
    && apk update && apk add --no-cache $INSTALL_PKGS  \
    && mkdir -p /var/run/sshd \
    && mkdir -p /run/openrc \
    && echo 'root:root' | chpasswd \
    && sed -i '/UseDNS/cUseDNS no' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && rm -rf /tmp/* /var/tmp/*

#暴露22号端口
EXPOSE 22


# Set the entrypoint to OpenRC
ENTRYPOINT ["/sbin/openrc"]

