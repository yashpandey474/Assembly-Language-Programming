.model tiny
.data

    output1 db 'PLEASE ENTER A CHARACTER: $' ;$ WHEN OUTPUTTING A STRING

    filename db 'lab1.txt', 0 ;FILE NAME NULL TERMINATED
    filehandle dw ?

    input1 db 13 dup('$')

    colmstr dw 10
    rowstr dw 10

    colmend dw 510
    ROWend dw 510

    count dw 00

.code
.startup

    ;GET INPUT FROM USER
     
    ;PRINT 'ENTER A STRING'
    LEA DX, output1
    MOV AH, 09H
    INT 21H

    ;INPUT A SINGLE CHARACTER
    MOV AH, 07H
    INT 21H
    
    ;CHARACTER STORED IN AL

    ;OPEN FILE FOR READING
    MOV AH, 3DH
    MOV AL, 00H ;ALREADY EXISTS
    LEA DX, filename ;FILENAME IN DX
    MOV filehandle, AX ;FILEHANDLE STORED

    ;READ 12 CHARACTERS FROM FILE
    MOV AH, 3FH
    MOV BX, filehandle
    MOV CX, 13
    LEA DX, input1
    INT 21H

    ;CLOSE THE FILE
    MOV BX, filehandle
    MOV AH, 3EH
    INT 21H

    ;SET GRAPHICS MODE
    MOV AH, 00H
    MOV AL, 12H
    INT 10H

    ;SET CURSOR POSITION TO 20,20 FOR GRACEFUL EXIT
    MOV AH, 02H
    MOV DH, 20 ;ROW
    MOV DL, 20 ;COLUMN
    MOV BH, 00 ;PAGE NO
    INT 10H

    ;COMPARE INPUT TO 12TH CHARACTER
    LEA SI, input1
    MOV BL, [SI+11]
    CMP AL, BL
    JNZ PAINTPINK

    PAINTGREEN:
        MOV SI, ROWSTR

        ROW1:
            ;FOR EVERY COLUMN
            MOV CX, colmend

        COLUMN1:
            ;FOR EVERY COLUMN
            
            ;DECREMENT AND STORE CX
            DEC CX
            MOV DI, CX
            PUSH CX

            ;PAINT THE PIXEL
            MOV AH, 0CH
            MOV AL, 1010b ;COLOR
            MOV CX, DI ;COLUMN
            MOV DX, SI ;ROW
            INT 10H

            ;CHECK COLUMN
            POP CX
            CMP CX, colmstr
            JNZ COLUMN1

            ;CHECK ROW
            INC SI
            CMP SI, rowend
            JNZ ROW1

    ;CHANGE PARAMTERS
    LEA SI, rowstr
    ADD WORD PTR[SI], 10
    ;ONLY STARTING ROW AND TOTAL BOXES PAINTED CHANGES
    LEA SI, COUNT
    ADD WORD PTR[SI], 1

    ;IF ALL PAINTED
    MOV AL, 25
    CMP [SI], AL
    JZ X1

    PAINTPINK:
        MOV SI, ROWSTR

        ROW2:
            ;FOR EVERY COLUMN
            MOV CX, colmend

        COLUMN2:
            ;FOR EVERY COLUMN
            
            ;DECREMENT AND STORE CX
            DEC CX
            MOV DI, CX
            PUSH CX

            ;PAINT THE PIXEL
            MOV AH, 0CH
            MOV AL, 1101b ;COLOR
            MOV CX, DI ;COLUMN
            MOV DX, SI ;ROW
            INT 10H

            ;CHECK COLUMN
            POP CX
            CMP CX, colmstr
            JNZ COLUMN2

            ;CHECK ROW
            INC SI
            CMP SI, rowend
            JNZ ROW2

    ;CHANGE PARAMTERS
    LEA SI, rowstr
    ADD WORD PTR[SI], 10
    ;ONLY STARTING ROW AND TOTAL BOXES PAINTED CHANGES
    LEA SI, COUNT
    ADD WORD PTR[SI], 1

    ;IF ALL PAINTED
    MOV AL, 25
    CMP [SI], AL
    JNZ PAINTGREEN

    ;BLOCKER FUNCTION
    X1:
        MOV AH, 07H
        INT 21H
        CMP AL, '%'
        JNZ X1

    ;END FUNCTION
    TERM:
        MOV AH, 4CH
        INT 21H

.exit
end

    

.