{\rtf1\ansi\ansicpg1252\cocoartf2639
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 .data\
a: .word 1, 2, 3, 4, 5\
b: .word 6, 7, 8, 9, 10\
output: .string "The dot product is: "\
\
.text\
main:\
    addi s0, x0, 0 # load 0 to s0\
    \
    la a0, a # loading the base address of a\
    la a1, b # loading the base address of b\
    li a2, 5 # let a2 be size of both arrays (5)\
    \
    jal dot_product\
    \
    mv s0, a0 # get result from dot_product that is in a0\
    \
    # print the output\
    addi a0, x0, 4\
    la a1, output\
    ecall\
    \
    # print result\
    addi a0, x0, 1\
    add a1, x0, s0\
    ecall\
    \
    # print newline\
    addi a0, x0, 11\
    addi a1, x0, 10\
    ecall\
    \
    # exit cleanly\
    addi a0, x0, 10\
    ecall\
    \
dot_product: \
    # base case\
    addi t0, x0, 1 # let t0 be 1\
    ble a2, t0, exit_base_case\
    \
    # recursive case\
    addi sp, sp, -4\
    sw ra, 0(sp) # storing the ra value onto the stack\
    \
    # storing the arguments\
    addi sp, sp, -8\
    sw a0, 0(sp)\
    sw a1, 4(sp)\
    \
    # set the next recursive arguments\
    addi a0, a0, 4\
    addi a1, a1, 4\
    addi a2, a2, -1\
    \
    jal dot_product\
    \
    # dot_product(a+1, b+1, size-1)\
    mv t1, a0\
    \
    # restore the original values for a0 and a1\
    lw a0, 0(sp)\
    lw a1, 4(sp)\
    addi sp, sp, 8\
    \
    lw t2, 0(a0) # a[i]\
    lw t3, 0(a1) # b[i]\
    mul t4, t2, t3 # a[i]*b[i]\
    \
    add a0, t4, t1 # a[i]*b[i] + dot_product(a+1, b+1, size-1)\
\
    lw ra, 0(sp)\
    addi sp, sp, 4\
    \
    jr ra\
    \
exit_base_case:\
    # load values of a[i] and b[i], then multiply them together and return the value\
    lw t0, 0(a0) # a[i]\
    lw t1, 0(a1) # b[i]\
    mul a0, t0, t1 # a[i]*b[i]\
    jr ra\
    }