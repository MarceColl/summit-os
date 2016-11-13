#!/bin/sh
set -e
. ./build.sh

mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub

cp sysroot/boot/summit.kernel isodir/boot/summit.kernel
cat > isodir/boot/grub/grub.cfg << EOF
menuentry "summit" {
	multiboot /boot/summit.kernel
}
EOF
grub-mkrescue -o summit.iso isodir
