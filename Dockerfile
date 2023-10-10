FROM ubuntu:lunar AS base

# config
ARG USERNAME="builduser"
ARG USERPASSWORD="go"

#set workdir
WORKDIR /root

# variables
ENV WORKSPACE=/home/builduser/workspace
ENV USERNAME $USERNAME
ENV USERPASSWORD $USERPASSWORD

# add a user
# Create a new user named "builduser" with home directory and bash shell
RUN adduser --quiet --disabled-password --shell /bin/zsh --home /home/$USERNAME --gecos "User" $USERNAME
RUN echo "${USERNAME}:${USERPASSWORD}" | chpasswd && usermod -aG sudo $USERNAME
RUN adduser $USERNAME sudo

# install tools for yocto
RUN apt-get update &&  apt-get install --no-install-recommends -y \
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
  ca-certificates \
  locales \
  zsh \
  ssh \
  python3 \
  python3-dev \
  binutils \
  binutils-common \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# set the locale to en_US.UTF-8
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# copy qemu bin
COPY image/core-image-minimal-qemux86-64.ext4 /home/$USERNAME/workspace/core-image-minimal-qemux86-64.ext4
RUN chmod +r /home/$USERNAME/workspace/core-image-minimal-qemux86-64.ext4

FROM base AS final

WORKDIR $workspace

# set the entry point to runqemu qemux86-64 nographic
ENTRYPOINT ["qemu-system-x86_64", "-nographic", "-boot", "c", "-hda", "core-image-minimal-qemux86-64.ext4"]

