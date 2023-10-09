# FROM ubuntu:lunar AS base

# #set workdir
# WORKDIR /root

# # install tools for yocto
# RUN apt-get update && apt-get install -y \
#   apt-utils \
#   software-properties-common \
#   default-jre \
#   build-essential device-tree-compiler \
#   expect hashdeep \
#   git \
#   locales time \
#   net-tools \
#   unzip \
#   wget \
#   cmake ninja-build make-guile \
#   rsync \
#   sudo \
#   nano \
#   vim \
#   qemu-system-x86 \
#   qemu-user \
#   qemu-user-static

# RUN apt-get update && apt-get install -y \
#   python3 \
#   python3-pip \
#   python3-pexpect \
#   tofrodos \
#   iproute2 \
#   gawk \
#   xvfb \
#   gcc \
#   git \
#   git-core \
#   make \
#   net-tools \
#   libncurses5-dev \
#   zlib1g-dev \
#   libssl-dev \
#   flex \
#   bison \
#   gettext \
#   libselinux1 \
#   gnupg \
#   wget \
#   diffstat \
#   chrpath \
#   socat \
#   xterm \
#   autoconf \
#   libtool \
#   tar \
#   unzip \
#   texinfo \
#   gcc-multilib \
#   build-essential \
#   libsdl1.2-dev \
#   libglib2.0-dev \
#   libidn2-0 \
#   screen \
#   pax \
#   gzip \
#   curl \
#   libtinfo5 \
#   libconfuse-dev \
#   genext2fs \
#   mtd-utils \
#   dosfstools \
#   mtools ncdu \
#   xz-utils \
#   debianutils \
#   iputils-ping \
#   python3-git \
#   python3-jinja2 \
#   libegl1-mesa \
#   pylint \
#   python3-subunit \
#   mesa-common-dev \
#   lz4 \
#   genimage \
#   zstd \
#   fdisk \
#   tig

# # Set the locale to en_US.UTF-8, because the Yocto build fails without any locale set.
# RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
# ENV LANG en_US.UTF-8
# ENV LC_ALL en_US.UTF-8

# # add a user
# RUN useradd -m -d /home/builduser -s /bin/bash builduser &&\
#     echo "builduser:builduser" | chpasswd
# RUN usermod -aG sudo builduser
# USER builduser


# # copy qemu bin
# RUN  mkdir -p workspace
# COPY image/core-image-minimal-qemux86-64.ext4 /home/builduser/workspace/core-image-minimal-qemux86-64.ext4
# RUN chmod +r workspace/core-image-minimal-qemux86-64.ext4

# FROM base AS final

# WORKDIR /home/builduser
# # Set the entry point to runqemu qemux86-64 nographic
# ENTRYPOINT ["qemu-system-x86_64", "-nographic", "-boot", "c", "-hda", "core-image-minimal-qemux86-64.ext4"]

FROM ubuntu:lunar AS base

#set workdir
WORKDIR /root

# install tools for yocto
RUN apt-get update && apt-get install -y \
  build-essential \
  locales time \
  cmake \
  rsync \
  sudo \
  nano \
  vim \
  qemu-system-x86 \
  qemu-user \
  qemu-user-static \
  make \
  g++ \
  build-essential \
  ca-certificates \
  locales \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Set the locale to en_US.UTF-8, because the Yocto build fails without any locale set.
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# add a user
# Create a new user named "builduser" with home directory and bash shell
RUN useradd -m -d /home/builduser -s /bin/bash builduser && \
    echo "builduser:builduser" | chpasswd

# Add the "builduser" to the "sudo" group
RUN usermod -aG sudo builduser
USER builduser

# copy qemu bin
RUN  mkdir -p workspace
COPY image/core-image-minimal-qemux86-64.ext4 /home/builduser/workspace/core-image-minimal-qemux86-64.ext4
RUN chmod +r workspace/core-image-minimal-qemux86-64.ext4

FROM base AS final

WORKDIR /home/builduser
# Set the entry point to runqemu qemux86-64 nographic
ENTRYPOINT ["qemu-system-x86_64", "-nographic", "-boot", "c", "-hda", "core-image-minimal-qemux86-64.ext4"]

