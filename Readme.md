## Intro on Shellcode Injection

[Shellcodes](https://en.wikipedia.org/wiki/Shellcode) are special pice of code (mostly hand assembled) that allows a user/hacker to execute their own code by exploiting some weakness in the target application. 

Based on the target application, shellcode needs to be carefully crafted as there is no universal shellcode that one can use in every application.

The target application needs to have some vulnerability that can be exploited. 

Syscall are special calls that user land program uses to access functions exposed by the Kernel. Syscalls and their calling convention differ based on OS and Architecture. 

Refer following for additional details regarding syscalls

- [Linux Syscall Reference (64 Bit)](https://syscalls64.paolostivanin.com/)


```asm
.intel_syntax noprefix
.global _start
```
When creating assembly code, there is an [AT&T syntax and Intel one](https://en.wikipedia.org/wiki/X86_assembly_language). Intel one is the most easy to read at least for me. GCC defaults to the former syntax. In order to change to Intel, we have to write **".intel_syntax noprefix"**.

**.global _start** is used to define the entrypoint for the executable. It helps the loader identify which memory location is the entry point for the executable.


----
## Compiling the code
In order to compile the code we will be using gcc, as that is what was suggested in the course. 

```bash
    gcc -nostdlib -fPIE -o shellcode-elf shellcode-elf.s 
```
We need to pass **nostdlib** as we do not wish to include the content of libc. If we do not use this flag then gcc will complain that there are multiple start defined. We also need to pass **PIE** as we need to create a binary where the memory location where all the bits will be loaded is not hardcoded in the binary and is determined during runtime. 

```bash
	objcopy --dump-section .text=shellcode-raw shellcode-elf
```
The binary that we will produce will have various additional piece of code that is used when the binary is executed natively. 

For our challenge, we need to pass the raw bytes of the shellcode to the stdin of the challenge executable. We need to extract the **.text** segment (Where the main code is located) and store it into a file.


## Uselful links
 - [Syscall refrence](https://syscalls64.paolostivanin.com/)
 - [X86_64 Register Map](https://static.wikia.nocookie.net/cheatengine/images/2/2c/Table_of_x86_Registers_svg.svg.png/revision/latest?cb=20220323182451)
 - [Standard Linux Error Codes](https://www.javatpoint.com/linux-error-codes)
 - [GDB Reference Map](https://cs.brown.edu/courses/cs033/docs/guides/gdb.pdf)