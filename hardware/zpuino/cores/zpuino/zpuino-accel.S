#include "register.h"

.globl pinMode
.globl pinModePPS
.globl digitalWrite

pinMode:
	loadsp 0
        im GPIOBASE + 16
        storesp 8
        im .setUnsetBit
        poppc

pinModePPS:
	loadsp 0
        im GPIOBASE + 32
        storesp 8
        im .setUnsetBit
        poppc

digitalWrite:
	loadsp 0
        im GPIOBASE
        storesp 8
        im .setUnsetBit
        poppc

.setUnsetBit:
	/* SP0: PC */
        /* SP4: IObase */
	/* SP8: pin */
	/* SP12: value */

	/* Compute pin index first */
	loadsp 8
        flip
	im 3
	ashiftleft
        flip
	im ~3
	and
        loadsp 8
	add
        /* Keep address, we'll need it */
        loadsp 0
        load
	/* And pin offset, and shift it */
        im 1
	loadsp 20
	im 31
	and
        ashiftleft
        
        /* Ok, now... we have mask */
        loadsp 24
        impcrel .isreset
        neqbranch
        /* it's a reset */
        not
        and
        loadsp 4
        store
        storesp 0
        storesp 4
        poppc
.isreset:
        or
        loadsp 4
        store
        storesp 0
        storesp 4
        poppc 


	.section	.text.strlen,"ax",@progbits
        .globl strlen
	.type	strlen, @function
strlen:
	/* SP0: PC */
        /* SP4: pointer */
        loadsp 4
.strlen_load:	
        loadsp 0
        loadb
        /* loadb will return all zeros for byte 0 */
        impcrel .strlen_keep_going
        neqbranch
        /* All done */
        loadsp 8
        sub
        im _memreg
        store
        poppc
.strlen_keep_going:
        im 1
        add
        im .strlen_load
        poppc
        .size strlen,.-strlen

	.section	.text.strcpy,"ax",@progbits
        .globl strcpy
	.type	strcpy, @function
strcpy:
	/* SP0: PC */
        /* SP4: source pointer */
        /* SP8: destination pointer */

        /* Save destination pointer */
        loadsp 8
.strcpy_load:
	loadsp 8   /* Source */
        loadb
        loadsp 0
        loadsp 8   /* Destination */
        store
        impcrel .strcpy_keep_going
        neqbranch
        loadsp 12
        im _memreg
        store
        storesp 0
        poppc
.strcpy_keep_going:
	im 1
        /* loadsp 4 */
        add
        /* storesp 4 */
        loadsp 8
        im 1
        add
        storesp 12
        im .strcpy_load
        poppc
        .size strcpy,.-strcpy
