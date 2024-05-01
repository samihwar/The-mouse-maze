; Convention: Haifa
.ORIG X3B54

PrintMatrix:    
    ;R1=> - pointer to the last cell
    ;R3=> adress of the cell
    ;R4=> N
    ;R5=> the adress of the first cell

    ADD R6, R6, #-6

    STR R1, R6, #0          ;R1=-R1 -> pointer to last cell in matrix
    STR R2, R6, #1   
    STR R3, R6, #2          ;adress of cell
    STR R4, R6, #3          ;number of cols/rows
    STR R5, R6, #4          ;the adress of the first cell
    STR R7, R6, #5

    LDR R1,R6,#6            ;-pointer to last cell in matrix
    LDR R3,R6,#7            ;adress of cell
    LDR R4,R6,#8            ;number of cols/rows
    LDR R5,R6,#9            ;the adress of the first cell

    LD R2, STAR_PM          ;put star in R2
    STR R2, R3, #0

    ADD R0,R0,#0
    BRn FINISH_PM

    ADD R2, R3, R1          ;if(R3=the last cell)
    BRnp NOT_LAST_CELL_PM

        LDR R5,R6,#9
        STR R4,R6,#-2       ;N
        STR R5,R6,#-1       ;first cell

        ADD R6,R6,#-2

        LD R1, PrintMatrixPrev_Ptr_PM
        JSRR R1             ;prints matrix and returns in R0 if we want another solution or not, if yes R0=1, else R0=-1

        ADD R6,R6,#2

        BR END_PM

    NOT_LAST_CELL_PM:

    ADD R0, R0, #0
    BRn END_PM

    LDR R5,R3,#-1           ;R5=*[R3-1]
    LD R2, MINUS_ONE_ASCII_PM
    ADD R5, R5, R2          ;check if we can go left
    BRnp ELSE1_PM

        ADD R3, R3, #-1
        ;R4=N

        LDR R1,R6,#6
        STR R1,R6,#-4       ; - pointer to the last cell
        STR R3,R6,#-3       ;adress of the cell
        STR R4,R6,#-2       ;N
        LDR R3,R6,#9
        STR R3,R6,#-1       ;R3 is pointer to the matrix

        ADD R6,R6,#-4

        JSR PrintMatrix

        ADD R6,R6,#4

        LDR R3,R6,#7        ;return original value
        ADD R0, R0, #0
        BRn END_PM

    ELSE1_PM:
    ADD R0, R0, #0
    BRn END_PM

    LDR R5,R3,#1            ;R5=*[R3+1]
    LD R2, MINUS_ONE_ASCII_PM
    ADD R5, R5, R2          ;check if we can go right
    BRnp ELSE2_PM

        ADD R3, R3, #1
        ;R4=N

        LDR R1,R6,#6
        STR R1,R6,#-4       ; - pointer to the last cell
        STR R3,R6,#-3       ;adress of the cell
        STR R4,R6,#-2       ;N
        LDR R3,R6,#9
        STR R3,R6,#-1       ;R3 is pointer to the matrix

        ADD R6,R6,#-4

        JSR PrintMatrix

        ADD R6,R6,#4

        LDR R3,R6,#7        ;return original value
        ADD R0, R0, #0
        BRn END_PM
        
    ELSE2_PM:
    ADD R0, R0, #0
    BRn END_PM

    ADD R3, R3, R4
    ADD R3, R3, #2 
    LDR R5, R3, #0          ;R5=*[R3+N+2]
    LD R2, MINUS_ONE_ASCII_PM
    ADD R5, R5, R2          ;check if we can go down
    BRnp ELSE3_PM

        ;R4=N

        LDR R1,R6,#6
        STR R1,R6,#-4       ; - pointer to the last cell
        STR R3,R6,#-3       ;adress of the cell
        STR R4,R6,#-2       ;N
        LDR R3,R6,#9
        STR R3,R6,#-1       ;R3 is pointer to the matrix

        ADD R6,R6,#-4

        JSR PrintMatrix

        ADD R6,R6,#4

        ADD R0, R0, #0
        BRn END_ELSE3_PM

    ELSE3_PM:
    NOT R4, R4
    ADD R4, R4, #1
    LDR R3,R6,#7            ;return original value


    ADD R0, R0, #0
    BRn END_PM

    ADD R3, R3, R4
    ADD R3, R3, #2 
    LDR R5, R3, #0          ;R5=*[R3-N+2]
    LD R2, MINUS_ONE_ASCII_PM
    ADD R5, R5, R2          ;check if we can go up
    BRnp ELSE4_PM

        ;R4=N

        LDR R1,R6,#6
        STR R1,R6,#-4       ; - pointer to the last cell
        STR R3,R6,#-3       ;adress of the cell
        STR R4,R6,#-2       ;N
        LDR R3,R6,#9
        STR R3,R6,#-1       ;R3 is pointer to the matrix

        ADD R6,R6,#-4

        JSR PrintMatrix

        ADD R6,R6,#4
        
        ADD R0, R0, #0
        BRn ELSE4_PM

        LDR R3,R6,#7         ;return original value
        BR END_PM


    ELSE4_PM:
    LDR R3,R6,#7             ;return original value
    BR END_PM

    END_ELSE3_PM:
    LDR R3,R6,#7             ;return original value



    END_PM:
        LD R2, ONE_ASCII_PM
        STR R2, R3, #0

    LDR R2,R6,#9
    ADD R2,R2,#1
    NOT R2, R2
    ADD R2, R2, #1

    ADD R2, R3, R2
    BRnp FINISH_PM
    ;we are in the first cell
    ADD R0, R0, #0
    BRn FINISH_PM
    BRz NO_SOLUTION_PM
    ;if R0=1-> there is no additional solution
        ADD R2, R0, #0      ;we save the value of R0 in R2 since we're going to use R0 for printing
        LEA R0, NO_EXTRA_SOLUTION_PM
        PUTS
        ;print new line
        AND R0, R0, #0
        ADD R0, R0, #10
        OUT
        ADD R0, R2, #0     ;return the original value of R0

        BR FINISH_PM
    NO_SOLUTION_PM: 
    ;if R0=0-> there is no solution for the maze at all
        ADD R2, R0, #0    ;we save the value of R0 in R2 since we're going to use R0 for printing
        LEA R0, NO_SOLUTION_PRINT_PM
        PUTS
        ;print new line
        AND R0, R0, #0
        ADD R0, R0, #10
        OUT
        ADD R0, R2, #0     ;return the original value of R0

    FINISH_PM:

    LDR R1, R6, #0
    LDR R2, R6, #1
    LDR R3, R6, #2
    LDR R4, R6, #3
    LDR R5, R6, #4
    LDR R7, R6, #5

    ADD R6, R6, #6

RET

STAR_PM  .fill #42
ONE_ASCII_PM .fill #49
MINUS_ONE_ASCII_PM .fill #-49
PrintMatrixPrev_Ptr_PM .fill x3C80
NO_EXTRA_SOLUTION_PM .STRINGZ "OH NO! It seems the mouse could not find another solution for this maze."
NO_SOLUTION_PRINT_PM .STRINGZ "OH NO! It seems the mouse has no luck in this maze."

.END


