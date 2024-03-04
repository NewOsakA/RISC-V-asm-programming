{\rtf1\ansi\ansicpg1252\cocoartf2639
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 .text\
main:\
    addi a0, x0, 110\
    addi a1, x0, 50\
    \
    jal mult            # Call mult function\
    \
    # print result\
    mv a1, a0  \
    addi a0, x0, 1\
    ecall \
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
mult:\
    # base case\
    # compare a1 with 1, if the two are equal you exit the mult function\
    addi t0, x0, 1\
    beq a1, t0, exit_base_case\
    \
    # recursive case\
    addi sp, sp, -4\
    sw ra, 0(sp)        \
    \
    # mult(a, b-1)\
    addi sp, sp, -4\
    sw a0, 0(sp)\
    addi a1, a1, -1         \
    jal mult \
    \
    # a + mult(a, b-1)\
    # mv t1, a0\
    \
    # restore the original a value before the call to mult\
    lw t1, 0(sp)   \
    addi sp, sp, 4         \
    add a0, a0, t1\
\
    lw ra, 0(sp)\
    addi sp, sp, 4\
    jr ra  \
    \
exit_base_case:\
    jr ra}