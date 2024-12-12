; Multiboot header for GRUB compatibility
section .multiboot
global _start

MAGIC_NUMBER    equ 0x1BADB002
FLAGS           equ 0x00  
CHECKSUM        equ 0-(MAGIC_NUMBER + FLAGS)

; Multiboot header
align 4
    dd MAGIC_NUMBER
    dd FLAGS
    dd CHECKSUM

section .text
global _start

extern main

_start:
    cli             ; Disable interrupts
    mov esp, stack_top  ; Set up stack
    call main       ; Call main kernel function
    jmp $           ; Halt the CPU

section .bss
stack_bottom:
    resb 16384      ; 16 KB stack
stack_top:
