.model tiny
.data
    ;PRINT FULL NAME IN REVERSE DIAGONAL ORDER
    ;DISPLAY MODE 03H [TEXT VGA MODE]
    inp db 'YASH PANDEY'
    count db 11
    colmstr dw ?
    rowstr dw ?
.code
.startup

    ;SET DISPLAY MODE
        MOV AH, 00H
        MOV AL, 03H
        INT 10H

    ;INITIALISE
    LEA SI, inp
    LEA DI, count
    MOV CH, 00H
    MOV CL, [DI] ;COUNT
    ADD SI, CX
    DEC SI ;SET POINTER TO LAST CHARACTER
    MOV colmstr, 00
    MOV rowstr, 00
    LEA DI, colmstr
    LEA BX, rowstr

    WRITE1:
        PUSH CX ;STORE COUNT

        ;SET CURSOR POSITION
        MOV AH, 02H
        MOV DH, [BX] ;ROW
        MOV DL, [DI] ;COLUMN
        MOV BH, 00 ;PAGE NUMBER
        INT 10H

        ;WRITE CHARACTER AT CURSOR POSITION
        MOV AH, 09H
        MOV AL, [SI] ;CHARACTER IN AL
        MOV BH, 00H ;PAGE NUMBER
        MOV BL, 10001111b ;ATTRIBUTE
        MOV CX, 01 ;WRITE JUST ONCE
        INT 10H

        ;CHECK COUNT
        POP CX
        ;CHANGE VERTICES
        DEC SI ;NEXT CHARACTER
        INC WORD PTR[DI] ;NEXT COLUMN
        INC WORD PTR[BX] ;NEXT ROW
        DEC CL ;DECREMENT COUNT
        JNZ WRITE1 ;IF CHARACTERS LEFT


    ;BLOCKER FUNCTION
    MOV AH, 07H
    X1: INT 21H
        CMP AL, '#'
        JNZ X1

    ;EXIT FUNCTION
    TERM:
        MOV AH, 4CH
        INT 21H

.exit
end