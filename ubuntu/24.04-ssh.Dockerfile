FROM ubuntu:24.04

LABEL maintainer='Anton Melekhin'

ENV container=docker \
    DEBIAN_FRONTEND=noninteractive

#换源安装systemd，openssh,创建ssh公钥私钥，给root用户修改密码为root，UseDNS no表示去掉远程ssh连接时的DNS域名解析
RUN sed -i 's@//ports.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list.d/ubuntu.sources && INSTALL_PKGS='findutils iproute2 python3 python3-apt sudo systemd openssh-server' \
    && apt-get update && apt-get install $INSTALL_PKGS -y --no-install-recommends \
    && mkdir /var/run/sshd \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key \
    && ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key \
    && echo 'root:root' | chpasswd \
    && sed -i '/UseDNS/cUseDNS no' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN find /etc/systemd/system \
    /lib/systemd/system \
    -path '*.wants/*' \
    -not -name '*journald*' \
    -not -name '*systemd-tmpfiles*' \
    -not -name '*systemd-user-sessions*' \
    -print0 | xargs -0 rm -vf

VOLUME [ "/sys/fs/cgroup" ]

ENTRYPOINT [ "/lib/systemd/systemd" ]

#暴露22号端口    
EXPOSE 22

