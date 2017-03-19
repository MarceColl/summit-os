# Summit OS

Little stupid project to try to make an operating system

You need a cross-compiler toolchain targeting i686-elf in order to build.
I recommend to use bochs for x86 emulation, as it is what I use and so I'm sure that it works.

For now virtual memory and interrupts are setup

```shell
$ ./build.sh
$ bochs -q
```

The idea is to make a x86-64 POSIX OS for learning and, eventually, for some light personal use.
I also want to centralize configuration so that cloning a system is easy and quick. All of this is probably
2-3 years into development, but it is one of the targets that I have.
