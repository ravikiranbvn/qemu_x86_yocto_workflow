#!/bin/bash

qemu-system-x86_64 \
    -m 256 \
    -cpu IvyBridge \
    -machine q35 \
    -device AC97 \
    -kernel bzImage-qemux86-64.bin \
    -drive if=virtio,format=raw,file=core-image-minimal-qemux86-64.rootfs.ext4 \
    -append "root=/dev/hda rw console=ttyS0,115200" \
    -nographic