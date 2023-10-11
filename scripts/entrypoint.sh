#!/bin/bash

qemu-system-x86_64 \
    -cpu qemu64 \
    -m 256M \
    -drive if=virtio,format=raw,file=core-image-minimal-qemux86-64.wic \
    -chardev stdio,mux=on,id=char0,logfile=serial_console.log,signal=off \
    -mon chardev=char0 \
    -serial chardev:char0 \
    -monitor telnet:127.0.0.1:5555,server,nowait \
    -nographic 