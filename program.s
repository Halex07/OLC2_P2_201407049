.global main
.extern printf
.extern malloc
.extern snprintf
.extern strcpy
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

parseFloatFunc:
    stp x29, x30, [sp, #-16]! 
    mov x29, sp
    mov x1, xzr
    bl printf
    fcvt s0, d0
    ldp x29, x30, [sp], #16
    ret


# Function: hola
hola:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #1600
    # Print
    adr x1, str_0
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
hola_end:
    add sp, sp, #1600
    ldp x29, x30, [sp], #16
    ret

# Function: saludar
saludar:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #1600
    # Declaracion: x
    mov x1, #42
    str x1, [sp, #2]
    # Print
    ldr x1, [sp, #2]
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
saludar_end:
    add sp, sp, #1600
    ldp x29, x30, [sp], #16
    ret

# Function: suma
suma:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #1600
    # Parametro: a
    str x0, [sp, #18]
    # Parametro: b
    str x1, [sp, #34]
    # Declaracion: resultado
    ldr x2, [sp, #18]
    ldr x3, [sp, #34]
    add x1, x2, x3
    str x1, [sp, #50]
    # Return
    ldr x0, [sp, #50]
    b suma_end
suma_end:
    add sp, sp, #1600
    ldp x29, x30, [sp], #16
    ret

# Function: moin
moin:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #1600
    # Declaracion: x
    # Call function: suma
    mov x0, #23
    mov x1, #5
    bl suma
    mov x1, x0
    str x1, [sp, #66]
    # Print
    ldr x1, [sp, #66]
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Declaracion: y
    # Call function: saludar
    bl saludar
    mov x1, x0
    str x1, [sp, #82]
    # Print
    ldr x1, [sp, #82]
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
    # Declaracion: z
    # Call function: hola
    bl hola
    mov x1, x0
    str x1, [sp, #98]
    # Print
    ldr x1, [sp, #98]
    mov x0, x1
    bl printValue
    adr x0, newline
    bl printf
moin_end:
    add sp, sp, #1600
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
    adr x1, str_1
    str x1, [sp, #80]
    # Print
    ldr x1, [sp, #80]
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
    # Print
    adr x1, str_4
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Declaracion: entero
    mov x1, #225
    str x1, [sp, #96]
    # Print
    adr x1, str_5
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
    adr x1, str_6
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
    adr x1, str_7
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
    adr x1, str_8
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
    adr x1, str_9
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
    adr x1, str_10
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
    adr x1, str_11
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
    adr x1, str_12
    str x1, [sp, #176]
    # Declaracion: bc
    adr x1, str_13
    str x1, [sp, #192]
    # Print
    adr x1, str_14
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
    adr x1, str_15
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
L0:
L1:
    # If
    ldr x2, [sp, #128]
    ldr x3, [sp, #112]
    cmp x2, x3
    cset x1, lt
    cmp x1, #0
    beq L2
    # Print
    adr x1, str_16
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    b L3
L2:
    # Print
    adr x1, str_17
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
L3:
    # Asignacion: b
    mov x1, #33
    str x1, [sp, #128]
    # If
    ldr x2, [sp, #128]
    ldr x3, [sp, #112]
    cmp x2, x3
    cset x1, lt
    cmp x1, #0
    beq L4
    # Print
    adr x1, str_18
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    b L5
L4:
    # If
    ldr x2, [sp, #112]
    ldr x3, [sp, #128]
    cmp x2, x3
    cset x1, gt
    cmp x1, #0
    beq L6
    # Print
    adr x1, str_19
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    b L7
L6:
    # Print
    adr x1, str_20
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
L7:
L5:
    # Declaracion: ciclo
    mov x1, #0
    str x1, [sp, #208]
    # Print
    adr x1, str_21
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # While
L8:
    ldr x2, [sp, #208]
    mov x3, #10
    cmp x2, x3
    cset x1, lt
    cmp x1, #0
    beq L9
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
    b L8
L9:
    # Print
    adr x1, str_22
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # For
    # Declaracion: ii
    mov x1, #0
    str x1, [sp, #224]
L10:
    ldr x2, [sp, #224]
    mov x3, #5
    cmp x2, x3
    cset x1, lt
    cmp x1, #0
    beq L11
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
    b L10
L11:
    # Print
    adr x1, str_23
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Declaracion: numero
    mov x1, #35
    str x1, [sp, #240]
    # Declaracion: s1
    ldr x2, [sp, #240]
    mov x20, x2
    mov x0, #64
    bl malloc
    mov x2, x0
    mov x19, x2
    mov x0, x19
    mov x1, #64
    adr x2, .fmt_int
    mov x3, x20
    bl snprintf
    mov x1, x19
    str x1, [sp, #256]
    # Print
    ldr x1, [sp, #256]
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    adr x1, str_24
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Declaracion: cadena
    adr x1, str_25
    str x1, [sp, #272]
    # Declaracion: cad
    ldr x2, [sp, #272]
    mov x20, x2
    mov x0, #64
    bl malloc
    mov x2, x0
    mov x0, x2
    mov x1, x20
    bl strcpy
    mov x1, x0
    str x1, [sp, #288]
    # Print
    ldr x1, [sp, #288]
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    adr x1, str_26
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Declaracion: valor
    mov x1, #19
    str x1, [sp, #304]
    # Declaracion: s3
    ldr x2, [sp, #304]
    mov x20, x2
    mov x0, #64
    bl malloc
    mov x2, x0
    mov x19, x2
    mov x0, x19
    mov x1, #64
    adr x2, .fmt_int
    mov x3, x20
    bl snprintf
    mov x1, x19
    str x1, [sp, #320]
    # Print
    ldr x1, [sp, #320]
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    adr x1, str_27
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Declaracion: dobu
    adr x1, float_2
    ldr x1, [x1]
    str x1, [sp, #336]
    # Declaracion: s9
    ldr x2, [sp, #336]
    mov x20, x2
    mov x0, #64
    bl malloc
    mov x2, x0
    mov x19, x2
    mov x0, x19
    mov x1, #64
    adr x2, .fmt_float
    fmov d0, x20
    bl snprintf
    mov x1, x19
    str x1, [sp, #352]
    # Print
    ldr x1, [sp, #352]
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Print
    adr x1, str_28
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Declaracion: s5
    # Float
    adr x2, str_29
    mov x0, x2
    bl parseFloatFunc
    fmov s2, s0
    str x1, [sp, #368]
    # Print
    ldr x1, [sp, #368]
    mov x0, x1
    bl printFloat
    adr x0, newline
    bl printf
    # Print
    adr x1, str_30
    mov x0, x1
    bl printString
    adr x0, newline
    bl printf
    # Declaracion: func
    # Call function: moin
    bl moin
    mov x1, x0
    str x1, [sp, #384]

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
.fmt_int: .asciz "%d"
.fmt_float: .asciz "%f"
.str_true: .asciz "true"
.str_false: .asciz "false"
str_0: .asciz " fredy Mercury Pirrir el mariflor69"
str_1: .asciz "te dicen"
str_2: .asciz "hola mundo"
str_3: .asciz "                    haveriguar por que lo pusistes"
str_4: .asciz "ya se por que lo puse"
str_5: .asciz "======= valor entero ======="
str_6: .asciz "======= bit and ======="
str_7: .asciz "======= bit or ======="
str_8: .asciz "======= bit xor ======="
str_9: .asciz "======= desplazamiento << ======="
str_10: .asciz "======= desplazamiento >> ======="
str_11: .asciz "======= desplazamiento negativo >> ======="
str_12: .asciz "hola"
str_13: .asciz "holas"
str_14: .asciz "======= comparacion equals ======="
str_15: .asciz "si a mayor"
str_16: .asciz "si b menor"
str_17: .asciz "si a mayor"
str_18: .asciz "si b menor"
str_19: .asciz "si a mayor"
str_20: .asciz "operacion invalida"
str_21: .asciz "======= bucle while ======="
str_22: .asciz "======= bucle for ======="
str_23: .asciz "======= String valueOf ======="
str_24: .asciz "======= String valueOf String======="
str_25: .asciz "23.17"
str_26: .asciz "======= String valueOf int======="
str_27: .asciz "======= String valueOf float======="
str_28: .asciz "======= parse float ======="
str_29: .asciz "15.15"
str_30: .asciz "======= llamada al main ======="
float_0: .double 3.141624
float_1: .double 2.500000
float_2: .double 19.190001
