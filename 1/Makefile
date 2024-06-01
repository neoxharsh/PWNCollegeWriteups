all:
	gcc -nostdlib -fPIE -o shellcode-elf shellcode-elf.s 
	objcopy --dump-section .text=shellcode-raw shellcode-elf
	hd shellcode-raw
	cat shellcode-raw | /challenge/babyshell_level1