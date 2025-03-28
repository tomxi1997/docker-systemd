# 直接使用jrei的docker systemd镜像https://hub.docker.com/r/jrei/systemd-debian/
FROM jrei/systemd-debian:9

# Set environment variables
ENV container docker

# Install necessary packages
RUN apt-get update && apt-get install -y \
    openssh-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create SSH directory and set up SSH，设置root用户密码为root，UseDNS no表示去掉远程ssh连接时的DNS域名解析
RUN mkdir /var/run/sshd \
    && echo 'root:root' | chpasswd \
    && sed -i '/UseDNS/cUseDNS no' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

#暴露22端口
EXPOSE 22


