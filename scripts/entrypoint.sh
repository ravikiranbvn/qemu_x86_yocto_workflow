//
// <author> ravi.has.kiran@gmail.com
// Copyright (c) 2023. All rights reserved!
//

#!/bin/bash

# start QEMU 
qemu-system-x86_64 \
    -cpu qemu64 \
    -m 256M \
    -drive if=virtio,format=raw,file=core-image-minimal-qemux86-64.wic \
    -nographic