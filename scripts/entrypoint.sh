#!/bin/bash

qemu-system-x86_64 \
    -m 256 \
    -cpu IvyBridge \
    -machine q35 \
    -kernel bzImage-qemux86-64.bin \
    -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE.fd \
    -drive if=pflash,format=raw,file=/usr/share/OVMF/OVMF_VARS.fd \
    -drive if=virtio,format=raw,file=core-image-minimal-qemux86-64.rootfs.ext4 \
    -append "rw console=ttyS0,115200" \
    -nographic