#ifndef HAVE_ZRT

.section ".boots", "a"
	.globl __executable_start
        .globl _start
        .globl _premain
        .globl main
        .globl _end
        
/* ATTENTION - this requires a very strict memory map. Do not change before
   thinking */
.balign 4,0
	.globl ivector
        .globl bootloaderdata
ivector:
	.long 0x310AFADE /* Will be set by bootloader later. This is a sig. */
bootloaderdata:
	.long BOARD_ID
.balign 4,0	
__executable_start:
	im _premain
	poppc      
        
.balign 4,0
       .globl _Z14_zpu_interruptj

.type ___zpu_interrupt_vector,@function
.globl ___zpu_interrupt_vector
___zpu_interrupt_vector:
	loadsp 4
	im _Z14_zpu_interruptj
        call
        storesp 0
        poppc
.size ___zpu_interrupt_vector, . - ___zpu_interrupt_vector
        

/* Other needed stuff */
	.globl _cpu_config

_cpu_config:
	.long 0
        .globl _init
        .weak _init
        .globl ___do_global_ctors
.text
        .globl _initIO
        .weak _initIO
_initIO:
	poppc
/*
	.globl _Z14_zpu_interruptv
        .weak  _Z14_zpu_interruptv
_Z14_zpu_interruptv:
	poppc
        */
        .weak _initIO
.section ".vectors"

	.org 0x0008
        .globl _memreg
_memreg:

#else


#include "register.h"

.section ".boots", "a"
	.globl __executable_start
        .globl _start
        .globl _premain
        .globl main
        .globl _end
        
/* ATTENTION - this requires a very strict memory map. Do not change before
   thinking */
.balign 4,0
	.globl ivector
        .globl bootloaderdata
ivector:
	.long 0x310AFADE /* Will be set by bootloader later. This is a sig. */
bootloaderdata:
	.long BOARD_ID
.balign 4,0	
__executable_start:
	im __executable_start2
        poppc

.balign 4,0	
.globl _Z14_zpu_interruptj
.type ___zpu_interrupt_vector,@function
.globl ___zpu_interrupt_vector
___zpu_interrupt_vector:
	loadsp	4
        im	3
        eq
        impcrel	__zrt_tick
        neqbranch
        storesp 0
	loadsp 4
	im _Z14_zpu_interruptj
        call
        storesp 0
        poppc
.size ___zpu_interrupt_vector, . - ___zpu_interrupt_vector
/* Other needed stuff */
	.globl _cpu_config

_cpu_config:
	.long 0
        .globl _init
        .weak _init
        .globl ___do_global_ctors
.text

__executable_start2:
	pushsp
        loadsp 0
        im 0x80000000
        sub
        loadsp 4
        // Clear bss, perform static initialization
        im ___clear_bss
        call
        im ___do_global_ctors
        call
        // Ready to go.
        
        im zrt_init
        call

        im 0x400
        nop
        im 20
        nop
        im _premain
        nop
        im zrt_createTask
        call
        im 12
        pushspadd
        popsp
        
        im zrt_main
        call
	poppc      

.globl ___switch_to_and_enable_interrupts
___switch_to_and_enable_interrupts:
        im 1
        nop
        im SYSCTLBASE
        store

.globl ___switch_to
.globl ___zrt_bootstrap
___switch_to:
	pushsp
        loadsp 	8
        store
        im	.switch_return
        nop
        im	4
        addsp	12
        store
        
        
	loadsp 	8   // New task control block
        
        // Save it immediatly
        loadsp	0
        im	zrt_currentTask
        store
        //	Restore memreg
        im	8
        addsp	4
        im	_memreg
        store
        
        load	    // New SP
        im	-4
        add         // SP now points to return address
        im	4
        addsp 	16	
        load		// new PC
        loadsp  4	// Temporary PC location
        store		// store to new SP
        popsp
        poppc

___zrt_bootstrap:       
	loadsp 4   // task control block
        load	    // New SP
        im	-4
        add
        im	4
        addsp 	12	
        load		// new PC
        loadsp  4	// Temporary PC location
        store		// store to new SP
        popsp
        poppc

.switch_return:
	poppc
.size ___switch_to, . - ___switch_to
        
__zrt_tick:
	/* Get user SP */
        pushsp
        im	12
        add
	im	4
        addsp	4
        /* We have SP */
        im	zrt_currentTask
        load
        store
        /* We now have PC address (sprel) on top of stack */
        load 	/* Load PC */
        im	zrt_currentTask
        load	
        im	4
        add
        store
        
        /* We need to save memreg aswell */
        im	_memreg	
        load
        im	zrt_currentTask
        load	
        im	8
        add
        store
        
        im	zrt_now
        load
        im	1
        add
        im zrt_now
        store
        
        im	zrt_timerRun
        call
        
	im 	TIMERSBASE
        load
        im	~(1<<7)
        and
        im	TIMERSBASE
        store
        im	zrt_sched_tail
        call
        im	_memreg
        load

	/* We now have the new task. */
        
        im	8
        addsp	4
        /* Memreg */
        load
        im _memreg
        store
        loadsp   0
        // Save as current task
        loadsp   0
        im	zrt_currentTask
        store
        im	8
        addsp	4
        // This is memreg
        im	_memreg
        store
        
        load	    // New SP
        im	-4
        add
        im	4
        addsp 	8	

        load		// new PC
        loadsp  4	// Temporary PC location
        store		// store to new SP

__ret_from_interrupt:
        /* Re-enable interrupts */
        im 1
        nop
        im SYSCTLBASE
        store
        
        popsp
        poppc
.size	zrt_init, . - zrt_init

.globl __enable_interrupts
__enable_interrupts:
        im 1
        nop
        im SYSCTLBASE
        store
	poppc

.globl __disable_interrupts
__disable_interrupts:
        im 0
        nop
        im SYSCTLBASE
        store
	poppc
        
        .globl _initIO
        .weak _initIO
_initIO:
	poppc

        .weak _initIO

.data	
.globl	zrt_now
zrt_now:
	.word 0

.section ".vectors"

	.org 0x0008
        .globl _memreg
_memreg:


#endif