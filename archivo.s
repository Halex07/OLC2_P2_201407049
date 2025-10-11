.data
heap: .space 4096
.text
.global _start
_start:
    adr x10, heap
MOV X0, #3
MOV X1, #4
ADD X2, X0, X1
MOV X0, X2