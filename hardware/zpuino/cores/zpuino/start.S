.section ".boots", "a"
	.globl __executable_start
        .globl _start
        .globl _premain
        .globl main

.balign 8,0	
__executable_start:
	im _premain
	poppc

.balign 8,0
        .globl _zpu_interrupt

___zpu_interrupt_vector:
	im _zpu_interrupt
        poppc

/* Other needed stuff */
	.globl _cpu_config

_cpu_config:
	.long 0
	.globl _memreg
_memreg:
	.long 0
        .long 0
        .long 0
        .long 0
        
        .globl _init
        .weak _init
        .globl ___do_global_ctors
.text
        .globl _initIO
        .weak _initIO
_initIO:
	poppc
