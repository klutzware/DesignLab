
extern unsigned int ___ctors, ___ctors_end;
extern char __end__;
static char *start_brk = &__end__;

extern void _Z4loopv();
extern void _Z5setupv();

void ___do_global_ctors()
{
	unsigned int *ptr = &___ctors;
	while (ptr!=&___ctors_end) {
		((void(*)(void))(*ptr))();
		ptr++;
	}
}

void __cxa_pure_virtual()
{
	// Abort here.
}

void exit(){
}

#ifndef NOMAIN
int main(int argc, char **argv)
{
	_Z5setupv();
	while (1) {
		_Z4loopv();
	}
}
#endif

extern int __bss_start__, __bss_end__;

static void __clear_bss()
{
    register int *end = &__bss_end__;
    int *i  = &__bss_start__;
    while (i!=end) {
        *i++=0;
    }
}

void __attribute__((noreturn)) _premain(void)
{
        __clear_bss();
	___do_global_ctors();
	main(0,0);
	while(1);
}

void *sbrk(int inc)
{
	start_brk+=inc;
	return start_brk;
}
