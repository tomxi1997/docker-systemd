# Use the official Ubuntu Jammy base image
FROM jrei/systemd-ubuntu:25.04

# Set environment variables
ENV container docker

# Install necessary packages
RUN sed -i 's@//ports.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list.d/ubuntu.sources && apt-get update && apt-get install -y \
    openssh-server linux-tools-generic hwdata usbutils \
    && apt-get clean \
    && update-alternatives --install /usr/local/bin/usbip usbip /usr/lib/linux-tools/*-generic/usbip 20 \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Create SSH directory and set up SSH
RUN mkdir -p /var/run/sshd /mnt/a /mnt/b /mnt/c /mnt/d /mnt/sdcard /mnt/data \
    && echo 'root:root' | chpasswd \
    && sed -i 's/#Port 22/Port 2504/' /etc/ssh/sshd_config \
    && sed -i '/UseDNS/cUseDNS no' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config


#
EXPOSE 2504

