; Convention: Haifa
.ORIG X3000
Main:
LD R6 RSixPt_ptr_M
; get number the rows of the matrix
    LD R5, GetNumSub_ptr_M
    LEA R0,PROMPT_row_M      ;get rows
    PUTS
    JSRR R5
    ADD R4,R0,#0            ;R4=number

; Call GetMatrix
    LD R3,MATRIX_ptr_M     ;R3 is pointer to the matrix
    LEA R0,PROMPT_values_M
    PUTS
    AND R0,R0,#0
    ADD R0,R0,#10
    OUT

    STR R3,R6,#-2   ;pointer to the matrix
    STR R4,R6,#-1   ;N

    ADD R6,R6,#-2

    LD R5,GetMatrixSub_ptr_M
    JSRR R5                 ;we go to GetMatrix and in R4 we have the n

    ADD R6,R6,#2
    ;here we have in R0 a pointer to the last cell

;print the ways and ask

    NOT R0,R0
    ADD R1,R0,#1

    AND R0,R0,#0
    LD R3,MATRIX_ptr_M     ;R3 is pointer to the matrix
    ADD R3,R3,#1

    STR R1,R6,#-4   ; - pointer to the last cell
    STR R3,R6,#-3   ;adress of the cell
    STR R4,R6,#-2   ;N
    LD R3,MATRIX_ptr_M
    STR R3,R6,#-1   ;R3 is pointer to the matrix

    ADD R6,R6,#-4

    LD R5,PrintMatrix_ptr_M
    JSRR R5

    ADD R6,R6,#4

HALT
MATRIX_ptr_M            .fill X36CA     ;36b4(hex)+16(hex)(=22 "n") ;so we will have the first row of -1...
RSixPt_ptr_M            .fill XBFFF
GetNumSub_ptr_M		    .fill X38FC
GetMatrixSub_ptr_M	    .fill X39C4
PrintMatrix_ptr_M	    .fill X3B54
PROMPT_row_M		    .stringz "Please enter a number between 2 to 20: "
PROMPT_values_M		    .stringz "Please enter the maze matrix:"

.END
