; Convention: Haifa
.ORIG X39C4
GetMatrix:  ; R3 = pointer to 2D matrix, R4 = matrix size

; Increase stack size by number of registers to backup
    ADD R6,R6,#-6

    STR R1,R6,#0
    STR R2,R6,#1
    STR R3,R6,#2
    STR R4,R6,#3
    STR R5,R6,#4
    STR R7,R6,#5    ; Backup return address like any other register

    LDR R3,R6,#6    ;pointer to the matrix
    LDR R4,R6,#7    ;N

    BR START_GM
    GET_MATRIX_START_GM:
    LEA R0, TRY_AGAIN_GM
    PUTS 
    ;new line
    AND R0,R0,#0
    ADD R0,R0,#10
    OUT
START_GM:
    LDR R3,R6,#2
    AND R2,R2,#0
    LDR R4,R6,#3

    ADD R5,R4,#0

    LDR R4,R6,#3                        ;here we put the size again in R4

        F_LOOP_GM:                      ; we fill the matrix R4(second loop) * R5 (first loop)
            LDR R4,R6,#3                ;here we put the size again in R4
            
            ADD R3,R3,#1                ;we add -1 before every row

            S_LOOP_GM:
                LD R1, GETNUM_GM
                JSRR R1                 ;we dont use arguments so we just call the func :)
                ;we will check if input is 0 or 1 else R2(flag)++
                ADD R0,R0,#0
                BRz DONE1_GM
                ADD R0,R0,#-1
                BRz DONE2_GM
                ADD R2,R2,#1
                DONE2_GM:
                ADD R0,R0,#1
                DONE1_GM:

                LD R1,ZERO_ASCCI_CODE_GM
                ADD R0,R0,R1            ;so we put the ascci code in the matrix
                STR R0,R3,#0
                ADD R3,R3,#1

                ADD R4,R4,#-1
            BRp S_LOOP_GM

            ADD R3,R3,#1                ;we add -1 after every row

        ADD R5,R5,#-1
        BRp F_LOOP_GM


    ;here we have to check if the first and the last cells are legal
    ADD R3,R3,#-2
    ADD R0,R3,#0                        ;we want to return pointer to the last cell
    LDR R5,R3,#0                        ;the last cell
    LD R1,MINUS_ONE_ASCCI_CODE_GM
    ADD R5,R5,R1
    BRnp NOT_GOOD_GM

    LDR R3,R6,#2
    LDR R5,R3,#1                        ;the first cell
    LD R1,MINUS_ONE_ASCCI_CODE_GM
    ADD R5,R5,R1
    BRz GOOD_GM

    NOT_GOOD_GM:
    ADD R2,R2,#1
    GOOD_GM:

    ADD R3,R0,#0                        ;save R0 in R3 for now

    ADD R2,R2,#0
    BRp GET_MATRIX_START_GM
    LEA R0,MATRIX_DONE_GM
    PUTS
        ;new line
    AND R0,R0,#0
    ADD R0,R0,#10
    OUT

    ADD R0,R3,#0                        ;the return value is a pointer to the last cell

    LDR R1,R6,#0
    LDR R2,R6,#1
    LDR R3,R6,#2
    LDR R4,R6,#3
    LDR R5,R6,#4
    LDR R7,R6,#5

    ADD R6,R6,#6

RET

MATRIX_DONE_GM .STRINGZ "The mouse is hopeful he will find his cheese."
TRY_AGAIN_GM    .STRINGZ "Illegal maze! Please try again:"
GETNUM_GM 	.fill x38FC
MINUS_ONE_ASCCI_CODE_GM	.fill #-49
ZERO_ASCCI_CODE_GM	.fill #48

.END
