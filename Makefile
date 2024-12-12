CC = gcc
NASM = nasm
CFLAGS = -m32 -ffreestanding -nostdlib -fno-pie -g
LDFLAGS = -m elf_i386 -nostdlib -Tlink.ld

all: calculator.iso

calculator.iso: kernel.bin
	mkdir -p iso/boot/grub
	cp kernel.bin iso/boot/
	echo "menuentry 'OS Calculator' {" > iso/boot/grub/grub.cfg
	echo "    multiboot /boot/kernel.bin" >> iso/boot/grub/grub.cfg
	echo "}" >> iso/boot/grub/grub.cfg
	grub-mkrescue -o calculator.iso iso

kernel.bin: multiboot.o kernel.o
	ld $(LDFLAGS) -o kernel.bin multiboot.o kernel.o 

multiboot.o: multiboot.asm
	$(NASM) -f elf32 multiboot.asm -o multiboot.o

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c kernel.c -o kernel.o


clean:
	rm -rf *.o *.bin *.iso iso
