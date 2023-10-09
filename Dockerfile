FROM ubuntu:latest AS base

# variables
ENV USER=builduser
ENV USER_ID=1000
ENV PASSWORD=docker
ENV WORKSPACE=/home/$USER/workspace

# install general tools
RUN apt-get update && apt-get install \
    --no-install-recommends -y \
    apt-utils sudo curl git-core gnupg locales \
    nodejs zsh wget nano npm fonts-powerline tmux vim \
    cmake \
    g++ \
    build-essential \
    ca-certificates \
    qemu-system-x86_64 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
# install yocto tools
RUN DEBIAN_FRONTEND="noninteractive" apt-get install \
    --no-install-recommends -y \
    gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 \
    libegl1-mesa libsdl1.2-dev pylint3 iproute2 file iptables zstd liblz4-tool 

RUN pip install kas

# Set the locale to en_US.UTF-8, because the Yocto build fails without any locale set.
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# add a user
RUN useradd -u $USER_ID -ms /bin/zsh $USER && \
    echo "$USER:$PASSWORD" | chpasswd && adduser $USER sudo
USER $USER

# copy qemu bin
COPY image/* /home/$USER/workspace/

FROM base AS final

# set workdir
WORKDIR $WORKSPACE

# Set the entry point to runqemu qemux86-64 nographic
ENTRYPOINT ["runqemu", "qemux86-64", "nographic"]
