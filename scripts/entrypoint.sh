#!/bin/bash

qemu-system-x86_64 \
  -cpu qemu64,+ssse3 \
  -m 256M \
  -kernel bzImage-qemux86-64.bin \
  -drive if=virtio,format=raw,file=core-image-minimal-qemux86-64.ext4 \
  -append "root=/dev/hda rw console=ttyS0,115200 acpi=off nokaslr" \
  -nographic