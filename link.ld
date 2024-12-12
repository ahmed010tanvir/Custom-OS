ENTRY(_start)

SECTIONS
{
    /*  Multiboot header  */
    . = 0x00100000; /* Start of the kernel */
    .multiboot :
    {
        *(.multiboot)
    }

 
    .text :
    {
        *(.text)
    }

    /*  read-only data */
    .rodata :
    {
        *(.rodata)
    }

    /* initialized data */
    .data :
    {
        *(.data)
    }

    /*uninitialized data */
    .bss :
    {
        *(.bss)
        *(COMMON)
    }
}

