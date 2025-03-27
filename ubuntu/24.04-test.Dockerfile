# Use the official Ubuntu Jammy base image
FROM ubuntu:22.04

# Set environment variables
ENV container docker

# Install necessary packages
RUN apt-get update && apt-get install -y \
    systemd \
    openssh-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create SSH directory and set up SSH
RUN mkdir /var/run/sshd \
    && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Enable systemd
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/lib/systemd/systemd"]
