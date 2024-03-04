{\rtf1\ansi\ansicpg1252\cocoartf2639
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 .data\
A: .word 11, 22, 33, 44, 55\
newline: .string "\\n"\
space: .string " "\
\
.text\
main:\
    la a0, A        # loading the starting address off array A to a0\
    addi a1, x0, 5  # passing the array size value to a1\
    jal print_array\
    \
    addi a0, x0, 10\
    addi a1, x0, 0\
    ecall # Terminate ecall\
\
print_array:\
    addi t0, x0, 0      # let the i value be in t0\
\
loop1:\
    bge t0, a1, exit1\
    slli t1, t0, 2      # t1 has the i*4 value\
    add t2, t1, a0\
    lw t3, 0(t2)        # t3 has the value of A[i]\
    \
    # print A[i]\
    # save a0 and a1 onto the stack; caller save as ecall realizes that a0 and a1 needed after the call\
    addi sp, sp, -8\
    sw a0, 0(sp)\
    sw a1, 4(sp)\
    \
    addi a0, x0, 1\
    mv a1, t3\
    ecall\
    \
    # print space\
    addi a0, x0, 4\
    la a1, space\
    ecall\
    \
    # restoring a0 and a1 to their original \
    lw a0, 0(sp)\
    lw a1, 4(sp)\
    addi sp, sp, 8\
    \
    addi t0, t0, 1      # i++\
    j loop1\
\
\
exit1:\
    # print a new line\
    addi a0, x0, 4\
    la a1, newline\
    ecall\
    \
    jr ra\
\
\
    \
    \
    \
    }