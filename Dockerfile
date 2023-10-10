FROM ubuntu:lunar

# config
ARG USERNAME="builduser"
ARG USERPASSWORD="go"

#set workdir
WORKDIR /root

# variables
ENV USERNAME $USERNAME
ENV USERPASSWORD $USERPASSWORD

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

# add a user
# Create a new user named "builduser" with home directory and bash shell
RUN useradd -m -d /home/$USERNAME -s /bin/bash $USERNAME &&\
RUN echo "${USERNAME}:${USERPASSWORD}" | chpasswd && usermod -aG sudo $USERNAME
RUN adduser $USERNAME sudo

# copy qemu and kernel image
RUN mkdir -p /home/$USERNAME/qemu_sim
COPY image/core-image-minimal-qemux86-64.ext4 /home/$USERNAME/qemu_sim/core-image-minimal-qemux86-64.ext4
COPY image/bzImage-qemux86-64.bin /home/$USERNAME/qemu_sim/bzImage-qemux86-64.bin
RUN chown -R $USERNAME:$USERNAME /home/$USERNAME/qemu_sim
RUN chmod +r /home/$USERNAME/qemu_sim/core-image-minimal-qemux86-64.ext4
RUN chmod +r /home/$USERNAME/qemu_sim/bzImage-qemux86-64.bin
COPY scripts/entrypoint.sh /home/$USERNAME/qemu_sim/entrypoint.sh
RUN chmod +x /home/$USERNAME/qemu_sim/entrypoint.sh

USER $USERNAME
WORKDIR /home/$USERNAME/qemu_sim

# set the entry point to script
ENTRYPOINT ["./entrypoint.sh"]