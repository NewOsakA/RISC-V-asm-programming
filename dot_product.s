{\rtf1\ansi\ansicpg1252\cocoartf2639
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 .data\
a: .word 1, 2, 3, 4, 5\
b: .word 6, 7, 8, 9, 10\
newline: .string "The dot product is: "\
\
.text\
main: \
# Register NOT to be used x0 to x4 and x10 to x17; reason to be explained later\
# Register that we can use x5 to x9 adn x18 to x31; reason to be explained later\
\
#   int size=5, i, sop = 0\
    addi x5, x0, 5     # let x5 be size and set it to be 5\
    addi x6, x0, 0      # let x6 be sop and set it to 0\
\
#   for (i = 0; i < 5; i++) \
#       sop += a[i] * b[i]\
    addi x7, x0, 0      # let x7 be i and set it to 0\
    la x8, a            # loading the address of a to x8\
    la x9, b            # loading the address of b to x9\
    \
loop1:\
    bge x7, x5, exit    # check if i >= size, if so goto exit1\
    slli x18, x7, 2     # set x18 to i*4\
    add x19, x18, x8    # add i*4 to the base address off a and put it to x19\
    lw x20, 0(x19)      # load x19 to x20\
    add x21, x18, x9    # add i*4 to the base address off b and put it to x21\
    lw x22, 0(x21)      # load x21 to x22\
    mul x23, x20 x22    # muliply x20, x21\
    add x6, x6, x23     # add new sum to sop\
    addi x7, x7, 1      # i++\
    j loop1\
      \
exit:\
    # print_string\
    addi a0, x0, 4\
    la a1, newline\
    ecall\
    \
    # print_int; sop\
    addi a0, x0, 1\
    add a1, x0, x6\
    ecall    \
    \
    # exit cleanly\
    addi a0, x0, 10\
    ecall\
\
    }