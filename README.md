```
All the resources in this repository are ONLY for learning purposes!
```

# qemu_x86_yocto_workflow

# Environment setup

## 1. Setup Docker Container (apt version)

The installation of docker is described in detail on the official Docker website: [Docker installation on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

### check if group exists
```bash
sudo getent group docker 
add username to docker group
sudo usermod -aG docker username
```

### brief commands
```bash
docker build --rm --tag <container:tag> -f Dockerfile .
docker run <container:tag>
docker push <container:tag>
docker pull <container:tag>
docker run --rm -it <container:tag>
```

## 2. QEMU installation on PC (optional)

The official documentaion: [QEMU](https://www.qemu.org/docs/master/) 

### brief commands
```bash
sudo apt-install qemu-system-x86 \
  qemu-user \
  qemu-user-static \
  qemu-utils 
```

## 3. Documentation

[Dockerfile]   (https://docs.docker.com/get-started/02_our_app/)
[Github]       (https://docs.github.com/en/actions/quickstart)
[YoctoProject] (https://docs.yoctoproject.org/4.0.12/singleindex.html) 
[YoctoProject] (https://docs.yoctoproject.org/brief-yoctoprojectqs/index.html)