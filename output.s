.global main
.extern printf
.text

printValue:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    mov x1, x0
    adr x0, int_fmt
    bl printf
    ldp x29, x30, [sp], #16
    ret

printString:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    mov x1, x0
    adr x0, str_fmt
    bl printf
    ldp x29, x30, [sp], #16
    ret

printFloat:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    fmov d0, x0
    adr x0, float_fmt
    bl printf
    ldp x29, x30, [sp], #16
    ret

stringEquals:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
compare_loop:
    ldrb w2, [x0], #1
    ldrb w3, [x1], #1
    cmp w2, w3
    b.ne not_equal
    cbz w2, equal
    b compare_loop
equal:
    mov x0, #1
    b end_compare
not_equal:
    mov x0, #0
end_compare:
    ldp x29, x30, [sp], #16
    ret

    # x0 = dirección del literal string
stringValueOf:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    bl printString
    ldp x29, x30, [sp], #16
    ret

 parseFloat:
 stp x29, x30, [sp, #-16]!
 mov x29, sp
 adr x1, float_fmt
 bl printf
 ldp x29, x30, [sp], #16
 ret

main:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #1600
    # Declaracion: x
    mov x2, #2
    mov x3, #5
    add x1, x2, x3
    str x1, [sp, #0]
    # Declaracion: y
    mov x1, #3
    str x1, [sp, #16]
    # Declaracion: z
    mov x2, #10
    mov x3, #5
    sdiv x1, x2, x3
    str x1, [sp, #32]
    # Asignacion: y
    mov x1, #100
    str x1, [sp, #16]
    # Print
    ldr x1, [sp, #0]
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Print
    ldr x1, [sp, #16]
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Print
    mov x1, #5
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Declaracion: pi
    adr x1, float_0
    ldr x1, [x1]
    str x1, [sp, #48]
    # Declaracion: xz
    adr x1, float_1
    ldr x1, [x1]
    str x1, [sp, #64]
    # Print
    ldr x2, [sp, #48]
    ldr x3, [sp, #64]
    fmov d0, x2
    fmov d1, x3
    fadd d0, d0, d1
    fmov x1, d0
    mov x0, x1
    bl printFloat
    adr x0, newline
    bl printf
    # Print
    ldr x1, [sp, #64]
    mov x0, x1
    bl printFloat
    adr x0, newline
    bl printf
    # Print
    ldr x1, [sp, #32]
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Declaracion: loca
    adr x1, str_0
    str x1, [sp, #80]
    # Print
    ldr x1, [sp, #80]
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    adr x1, str_1
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    adr x1, str_2
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    adr x1, str_3
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Declaracion: entero
    mov x1, #225
    str x1, [sp, #96]
    # Print
    adr x1, str_4
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    ldr x1, [sp, #96]
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Declaracion: a
    mov x1, #5
    str x1, [sp, #112]
    # Declaracion: b
    mov x1, #3
    str x1, [sp, #128]
    # Declaracion: f
    mov x1, #1
    str x1, [sp, #144]
    # Declaracion: bb
    mov x2, #0
    mov x3, #3
    sub x1, x2, x3
    str x1, [sp, #160]
    # Print
    adr x1, str_5
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    ldr x2, [sp, #112]
    ldr x3, [sp, #128]
    and x1, x2, x3
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Print
    adr x1, str_6
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    ldr x2, [sp, #112]
    ldr x3, [sp, #128]
    orr x1, x2, x3
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Print
    adr x1, str_7
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    ldr x2, [sp, #112]
    ldr x3, [sp, #128]
    eor x1, x2, x3
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Print
    adr x1, str_8
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    ldr x2, [sp, #128]
    ldr x3, [sp, #144]
    lsl x1, x2, x3
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Print
    adr x1, str_9
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    ldr x2, [sp, #128]
    ldr x3, [sp, #144]
    asr x1, x2, x3
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Print
    adr x1, str_10
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    ldr x2, [sp, #160]
    ldr x3, [sp, #144]
    asr x1, x2, x3
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Declaracion: ac
    adr x1, str_11
    str x1, [sp, #176]
    # Declaracion: bc
    adr x1, str_12
    str x1, [sp, #192]
    # Print
    adr x1, str_13
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    ldr x2, [sp, #176]
    ldr x3, [sp, #192]
    mov x0, x2
    mov x1, x3
    bl stringEquals
    mov x1, x0
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # If
    ldr x2, [sp, #112]
    ldr x3, [sp, #128]
    cmp x2, x3
    cset x1, gt
    cmp x1, #0
    beq L0
    # Print
    adr x1, str_14
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
L0:
    # Declaracion: ciclo
    mov x1, #0
    str x1, [sp, #208]
    # Print
    adr x1, str_15
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # While
L1:
    ldr x2, [sp, #208]
    mov x3, #7
    cmp x2, x3
    cset x1, lt
    cmp x1, #0
    beq L2
    # Print
    ldr x1, [sp, #208]
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Asignacion: ciclo
    ldr x2, [sp, #208]
    mov x3, #1
    add x1, x2, x3
    str x1, [sp, #208]
    b L1
L2:
    # Print
    adr x1, str_16
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # For
    # Declaracion: ii
    mov x1, #0
    str x1, [sp, #224]
L3:
    ldr x2, [sp, #224]
    mov x3, #10
    cmp x2, x3
    cset x1, lt
    cmp x1, #0
    beq L4
    # Print
    ldr x1, [sp, #224]
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Asignacion: ii
    ldr x2, [sp, #224]
    mov x3, #1
    add x1, x2, x3
    str x1, [sp, #224]
    b L3
L4:
    # Print
    mov x8, #4
    mov x9, #5
    add x6, x8, x9
    mov x7, #6
    add x4, x6, x7
    mov x6, #7
    mov x7, #11
    mul x5, x6, x7
    add x2, x4, x5
    mov x3, #2
    sdiv x1, x2, x3
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf

    # Salir
    add sp, sp, #1600
    ldp x29, x30, [sp], #16
    mov x0, #0
    ret

.data
int_fmt: .asciz "%d"
str_fmt: .asciz "%s"
float_fmt: .asciz "%f"
newline: .asciz "\n"
str_0: .asciz "te dicen"
str_1: .asciz "hola mundo"
str_2: .asciz "                    haveriguar por que lo pusistes"
str_3: .asciz "ya se por que lo puse"
str_4: .asciz "======= valor entero ======="
str_5: .asciz "======= bit and ======="
str_6: .asciz "======= bit or ======="
str_7: .asciz "======= bit xor ======="
str_8: .asciz "======= desplazamiento << ======="
str_9: .asciz "======= desplazamiento >> ======="
str_10: .asciz "======= desplazamiento negativo >> ======="
str_11: .asciz "hola"
str_12: .asciz "hola"
str_13: .asciz "======= comparacion equals ======="
str_14: .asciz "si a mayor"
str_15: .asciz "======= bucle while ======="
str_16: .asciz "======= bucle for ======="
float_0: .double 3.141624
float_1: .double 2.500000
