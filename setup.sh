sudo apt-get install xorriso
sudo apt-get install grub
sudo apt-get install gcc
sudo apt-get install nasm 
sudo apt-get install virtualbox
sudo apt-get install qemu
sudo apt-get install gedit
make clean
make
qemu-system-i386 -cdrom calculator.iso
