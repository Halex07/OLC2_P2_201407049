.data
nombre:
        .asciz "Henry"
lennombre = .-nombre
.text
.global _start

_start:
        mov x0, 1
        ldr x1, = nombre
        mov x2, lennombre
        mov x8, 64
        svc 0 
finalizar:
        mov x0, 0
        mov x8, 93
        svc 0
