.model tiny
.data
    ;WRITE NAME AT (20,20)
    inp db 'YASH PANDEY'
    count dw 11

    colmstr db 20
    rowstr db 20

.code
.startup

    ;SET DISPLAY MODE
    MOV AH, 00H
    MOV AL, 03H
    INT 10H

    ;INITIALISE
    LEA SI, inp
    MOV CX, count ;COUNT OF CHARACTERS
    LEA DI, colmstr ;CURRENT COLUMN
    LEA BX, rowstr ;CURRENT ROW

    ;WRITE
    WRITE1:
        PUSH CX ;PUSH COUT

        ;SET CURSOR
        MOV AH, 02H
        MOV DH, [BX] ;ROW
        MOV DL, [DI] ;COLUMN
        MOV BH, 00H ;PAGE
        INT 10H

        ;WRITE THE CHARACTER
        MOV AH, 09H
        MOV AL, [SI] ;CHARACTER
        MOV BH, 00H ;PAGE NUMBER
        MOV BL, 10001001b ;ATTRIBUTE
        MOV CX, 01H ;NUMBER OF TIMES TO WRITE
        INT 10H

        ;CHECK COUNT
        POP CX
        
        ;INCREMENT COLUMN
        LEA DI, colmstr
        LEA BX, rowstr
        INC BYTE PTR[DI]
        INC SI

        DEC CX
        JNZ WRITE1

    ;BLOCKER FUNCTION
    MOV AH, 07H
    X1:
        INT 21H
        CMP AL, '%'
        JNZ X1
    
    TERM:
        MOV AH, 4CH
        INT 21H

.exit
end
