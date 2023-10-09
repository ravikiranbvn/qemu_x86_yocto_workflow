FROM ubuntu:lunar

#set workdir
WORKDIR /src

# copy bin qemu-system-x86_64
COPY ../bin/qemu-system-x86_64 /usr/bin/qemu-system-x86_64
RUN chmod +x /usr/bin/qemu-system-x86_64

# Basic apt update
RUN apt-get update && apt-get install -y \
    cmake \
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

# Copy and compile CPP and check the binary extension
COPY src/helloworld.cpp /home/
RUN g++ /home/helloworld.cpp -o /home/ex_hw
CMD ["/home/ex_hw"]