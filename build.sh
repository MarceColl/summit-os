#!/bin/sh
set -e
. ./headers.sh

for PROJECT in $PROJECTS; do
  (cd $PROJECT && DESTDIR="$SYSROOT" $MAKE install)
done

mkdir -p isodir/boot

cp kernel/summit.kernel isodir/boot/
grub-mkrescue -d /usr/lib/grub/i386-pc -o summit.iso isodir
