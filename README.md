
如何构建属于自己的docker systemd arm64镜像
fork本仓库
修改env.conf并提交，到action，点击启动工作流，等待完成，下载


如何使用呢
下载后解压artifact.zip
docker load -i *.tar

docker images
然后查看镜像id

然后运行
docker run -d --name systemd-ubuntu --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro $id





# Docker images with systemd support

Docker containers that uses for Ansible role and playbook testing.

## Supported tags and platforms

Alma Linux:

- `almalinux-8` (`linux/amd64`,`linux/arm64`)
- `almalinux-9` (`linux/amd64`,`linux/arm64`)

Amazon Linux:

- `amazonlinux-2` (`linux/amd64`)
- `amazonlinux-2023` (`linux/amd64`,`linux/arm64`)

CentOS:

- `centos-7` (`linux/amd64`)

Debian:

- `debian-10` (`linux/amd64`,`linux/arm64`)
- `debian-11` (`linux/amd64`,`linux/arm64`)
- `debian-12` (`linux/amd64`,`linux/arm64`)

Fedora:

- `fedora-39` (`linux/amd64`,`linux/arm64`)
- `fedora-40` (`linux/amd64`,`linux/arm64`)

Rocky Linux:

- `rockylinux-8` (`linux/amd64`,`linux/arm64`)
- `rockylinux-9` (`linux/amd64`,`linux/arm64`)

Ubuntu:

- `ubuntu-18.04` (`linux/amd64`,`linux/arm64`)
- `ubuntu-20.04` (`linux/amd64`,`linux/arm64`)
- `ubuntu-22.04` (`linux/amd64`,`linux/arm64`)
- `ubuntu-24.04` (`linux/amd64`,`linux/arm64`)

## Usage

### With Molecule

```yaml
---
dependency:
  name: 'galaxy'
  enabled: true
driver:
  name: 'docker'
platforms:
  - name: 'instance-ubuntu'
    image: 'antmelekhin/docker-systemd:ubuntu-22.04'
    volumes:
      - '/sys/fs/cgroup:/sys/fs/cgroup:rw'
      - '/var/lib/containerd'
    cgroupns_mode: 'host'
    privileged: true
    pre_build_image: true
    groups:
      - 'debian_family'
  - name: 'instance-rocky'
    image: 'antmelekhin/docker-systemd:rockylinux-9'
    volumes:
      - '/sys/fs/cgroup:/sys/fs/cgroup:rw'
      - '/var/lib/containerd'
    cgroupns_mode: 'host'
    privileged: true
    pre_build_image: true
    groups:
      - 'rhel_family'
provisioner:
  name: 'ansible'
verifier:
  name: 'ansible'
```

### Build and run

- Build the image with `Ubuntu 22.04`

  ```bash
  export DISTR='ubuntu'
  export VERSION='22.04'
  docker build -t docker-systemd:${DISTR}-${VERSION} -f ${DISTR}/${VERSION}.Dockerfile .
  ```

- Run the container

  ```bash
  docker run -d --name systemd-${DISTR}-${VERSION} --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:rw --cgroupns=host docker-systemd:${DISTR}-${VERSION}
  ```

- Enter to the container

  ```bash
  docker exec -it systemd-${DISTR}-${VERSION} /bin/bash
  ```

- Remove the container

  ```bash
  docker rm -f systemd-${DISTR}-${VERSION}
  ```

## License

MIT

## Author

Melekhin Anton.
