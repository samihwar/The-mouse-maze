; 324888155, 50%
; 209632108, 50%
; Convention: Haifa
.orig x38FC
GetNum:

; Increase stack size by number of registers to backup

    ADD R6,R6,#-6

    STR R1,R6,#0
    STR R2,R6,#1
    STR R3,R6,#2
    STR R4,R6,#3
    STR R5,R6,#4
    STR R7,R6,#5    ; Backup return address like any other register

    AND R2, R2, #0                  ;sum
    AND R4, R4, #0                  ;flag to check if its minus    
    AND R5, R5, #0                  ;used while adding

    GETC_GN:
    GETC
    OUT

    LD R5, MINUS_ASCII_GN
    ADD R5 ,R0, R5                  ;checking if first character is a minus
    BRnp NOT_MINUS_GN
        ADD R4, R4, #1              ;changing flag to 1
        BR GETC_GN
    NOT_MINUS_GN:

    LD R5, MINUS_ZERO_ASCII_GN      ;checking if first char is 0
    ADD R5,R0,R5
    BRz INPUT_GN

    LD R5, MINUS_SPACE_ASCII_GN     ;checking if first char is SPACE
    ADD R5,R0,R5
    BRz GETC_GN

    BR INPUT_GN
    SECOND_GETC_GN:
        GETC
        OUT

        ADD R5, R0, #-10            ;its ENTER
        BRz END_LOOP_GN
        LD R5, MINUS_SPACE_ASCII_GN
        ADD R5, R0, R5              ;its SPACE
        BRz END_LOOP_GN

    INPUT_GN:
        LD R5, MINUS_ZERO_ASCII_GN  ;so we put the ascci thing
        ADD R0, R0, R5
        ;instead of using mul to multiply R0 by 10 we use it this way:
        ADD R5, R2, R2 ;R5=2R2
        ADD R2, R5, R5 ;R2=4R2
        ADD R2, R2, R2 ;R2=8R
        ADD R2, R2, R5 ;R2=10R2
        ADD R2, R2, R0 ;R2= 10R2 + R0

        BR SECOND_GETC_GN
    END_LOOP_GN:

    ADD R4,R4,#0
    BRz R2_ISP_GN
    ;its negative
        NOT R2, R2
        ADD R2, R2,#1
    R2_ISP_GN:

    ADD R0,R2,#0

    LDR R1,R6,#0
    LDR R2,R6,#1
    LDR R3,R6,#2
    LDR R4,R6,#3
    LDR R5,R6,#4
    LDR R7,R6,#5    ; Backup return address like any other register

    ADD R6,R6,#6

RET

MINUS_ASCII_GN       .fill #-45
MINUS_ZERO_ASCII_GN  .fill #-48
MINUS_NINE_ASCII_GN  .fill #-57
MINUS_SPACE_ASCII_GN .fill #-32

.END