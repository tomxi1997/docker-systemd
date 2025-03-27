# Use the official Ubuntu Jammy base image
FROM ubuntu:24.04

# Set environment variables
ENV container docker

# Install necessary packages
RUN sed -i 's@//ports.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list.d/ubuntu.sources && apt-get update && apt-get install -y \
    systemd \
    openssh-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create SSH directory and set up SSH
RUN mkdir /var/run/sshd \
    && echo 'root:root' | chpasswd \
    && sed -i '/UseDNS/cUseDNS no' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Enable systemd
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/lib/systemd/systemd"]
