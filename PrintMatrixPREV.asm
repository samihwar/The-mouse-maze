; 324888155, 50%
; 209632108, 50%
; Convention: Haifa
.orig X3C80
PrintMatrixPREV: ;just print the matrix and ask
;R3=> MATRIX_PTR
;R4=> N
    ADD R6,R6,#-6

    STR R1,R6,#0
    STR R2,R6,#1
    STR R3,R6,#2
    STR R4,R6,#3
    STR R5,R6,#4
    STR R7,R6,#5    ; Backup return address like any other register

    LDR R4,R6,#6    ;R4 = n
    LDR R3,R6,#7    ;matrix ptr

    ADD R2,R0,#1 ;sol_number++

    LEA R0, WE_FIND_IT_PMP
    PUTS
    AND R0,R0,#0
    ADD R0,R0,#10
    OUT


    ADD R5,R4,#0

    F_LOOP_PMP:                         ; we fill the matrix R4(second loop) * R5 (first loop)
        LDR R4,R6,#3                    ;here we put the size again in R4
        ADD R3, R3, #1
            S_LOOP_PMP:
                LDR R0,R3,#0            ;print the value
                OUT
                LD R0,SP_ASCCI_PMP       ;print space
                OUT
                ADD R3,R3,#1

                ADD R4,R4,#-1           ;counter1 --
            BRp S_LOOP_PMP
        ADD R3, R3, #1    
        ;new line
        AND R0,R0,#0
        ADD R0,R0,#10
        OUT

    ADD R5,R5,#-1                   ;counter2 --
    BRp F_LOOP_PMP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ;here we ask the customer if he wants another sol if yes we return R0=1 else R0=-1
    LEA R0,ASK_PMP
    PUTS
    GETC
    OUT
    LD R5,MINUS_Y_PMP
    ADD R5,R0,R5
    BRz END_PMP

    LD R5,MINUS_y_PMP
    ADD R5,R0,R5
    BRz END_PMP

    ;thats a n or N
    AND R0,R0,#0
    ADD R0,R0,#-1
    ADD R2,R0,#0
    
END_PMP:
    GETC ; "ENTER ;)"
    OUT
    ADD R0,R2,#0

    LDR R1,R6,#0
    LDR R2,R6,#1
    LDR R3,R6,#2
    LDR R4,R6,#3
    LDR R5,R6,#4
    LDR R7,R6,#5    ; Backup return address like any other register

    ADD R6,R6,#6

RET

ASK_PMP          .STRINGZ "Would you like to see another solution? "
WE_FIND_IT_PMP   .STRINGZ "Yummy! The mouse has found the cheese!"
MINUS_Y_PMP      .fill #-89
MINUS_y_PMP      .fill #-121
SP_ASCCI_PMP      .fill #32
.END