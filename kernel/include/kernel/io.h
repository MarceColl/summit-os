#ifndef __SUMMIT_IO__
#define __SUMMIT_IO__

static inline char inb(short port)
{
    char ret;
    asm volatile ( "inb %1, %0"
                   : "=a"(ret)
                   : "Nd"(port) );
    return ret;
}

#endif
