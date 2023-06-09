.model tiny
.data
    current db 1
    past db 0
    char db 'A'

    column db 0
    row db 0

    count dw 8

.code
.startup
    ;SET DISPLAY MODE
    MOV AH, 00H
    MOV AL, 03H
    INT 10H

    LEA SI, row
    LEA DI, column
    MOV CX, count

    WRITE1:
        PUSH CX

        ;SET CURSOR
        MOV AH, 02H
        MOV DH, row
        MOV DL, column
        MOV BH, 00
        INT 10H

        ;WRITE CHARACTER
        MOV AL,char
        DEC AL
        ADD AL, current

        ;WRITE
        MOV AH, 09H
        MOV BH, 00
        MOV BL, 10001001b
        MOV CH, 00H
        MOV CL, current
        INT 10H

        POP CX

        ;NEXT CHARACTER
        MOV AL, past
        MOV BL, current
        ADD AL, BL
        MOV past, BL
        MOV current, AL
        
        ;CHANGE VERTICES
        MOV AL, 00H
        MOV COLUMN, 00H
        INC BYTE PTR[SI]
        DEC CX
        JNZ WRITE1

    ;BLOCKER FUNCTION
    MOV AH, 07H
    X1: INT 21H
        CMP AL, '%'
        JNZ X1
    
    ;TERMINATE
    TERM:
        MOV AH, 4CH
        INT 21H

.exit
end




