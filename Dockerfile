FROM ubuntu:lunar AS base

# variables
ENV USER=builduser
ENV USER_ID=1000
ENV PASSWORD=docker
ENV WORKSPACE=/home/$USER/workspace

# install tools for yocto
RUN apt-get update && apt-get install -y \
  apt-utils \
  software-properties-common \
  default-jre \
  build-essential device-tree-compiler \
  expect hashdeep \
  git \
  locales time \
  net-tools \
  unzip \
  wget \
  cmake ninja-build make-guile \
  rsync \
  sudo \
  nano \
  vim \
  qemu-system

RUN apt-get update && apt-get install -y \
  python3 \
  python3-pip \
  python3-pexpect \
  tofrodos \
  iproute2 \
  gawk \
  xvfb \
  gcc \
  git \
  git-core \
  make \
  net-tools \
  libncurses5-dev \
  zlib1g-dev \
  libssl-dev \
  flex \
  bison \
  gettext \
  libselinux1 \
  gnupg \
  wget \
  diffstat \
  chrpath \
  socat \
  xterm \
  autoconf \
  libtool \
  tar \
  unzip \
  texinfo \
  gcc-multilib \
  build-essential \
  libsdl1.2-dev \
  libglib2.0-dev \
  libidn2-0 \
  screen \
  pax \
  gzip \
  curl \
  libtinfo5 \
  libconfuse-dev \
  genext2fs \
  mtd-utils \
  dosfstools \
  mtools ncdu \
  xz-utils \
  debianutils \
  iputils-ping \
  python3-git \
  python3-jinja2 \
  libegl1-mesa \
  pylint \
  python3-subunit \
  mesa-common-dev \
  lz4 \
  genimage \
  zstd \
  fdisk \
  tig

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
