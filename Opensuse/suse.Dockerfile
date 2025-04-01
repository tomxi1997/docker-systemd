# Use the official OpenSUSE image as the base
FROM opensuse/leap:15.6

# Install systemd and other necessary packages
RUN zypper refresh && \
    zypper install -y systemd systemd-sysvinit && \
    zypper clean

# Create a directory for the systemd service
RUN mkdir -p /etc/systemd/system

# Set the default command to run systemd
CMD ["/usr/lib/systemd/systemd"]

# Set the environment variable to allow systemd to run
ENV container docker

# Create a volume for the systemd runtime
VOLUME ["/sys/fs/cgroup"]

# Ensure that the container runs in privileged mode
# This is necessary for systemd to function properly
# You will need to run the container with --privileged flag
