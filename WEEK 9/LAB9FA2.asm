.model tiny
.data

    colmstr dw 10
    colmend dw 610

    rowstr dw 10
    rowend dw 610

    count db 00  ;NUMBER OF BOXES PRINTED - INITIALLY 0

.code
.startup

    ;SET DISPLAY MODE
    MOV AH, 00H
    MOV AL, 12H
    INT 10H

    ;INITIALISE
    MOV SI, rowstr
    MOV CX, colmend
   
    ;SET CURSOR POSITION [OUT OF PAINTING]]
    MOV AH, 02H
    MOV DH, 20
    MOV DL, 20
    MOV BH, 00H
    INT 10H

    ;PAINT BOXES
    PAINT1:
        MOV SI, rowstr

        ROW1:
            ;FOR EVERY ROW
            MOV CX, colmend

        COLUMN1:
            ;FOR EVERY COLUMN
            
            ;DECREASE AND STORE CX
            DEC CX
            MOV DI, CX
            PUSH CX

            ;PAINT PIXEL
            MOV AH, 0CH
            MOV AL, 1111b ;WHITE BOX: 1111b
            MOV CX, DI ;COLUMN
            MOV DX, SI ;ROW
            INT 10H

            ;CHECK COLUMN
            POP CX
            CMP CX, colmstr
            JNZ COLUMN1 ;NEXT COLUMN

            INC SI
            CMP SI, rowend
            JNZ ROW1 ;NEXT ROW

                ;CHANGE PARAMETERS
    LEA SI, rowstr
    ADD WORD PTR[SI], 10
    LEA SI, rowend
    SUB WORD PTR[SI], 10
    LEA SI, colmstr
    ADD WORD PTR[SI], 10
    LEA SI, colmend
    SUB WORD PTR[SI], 10
    
    ;INCREMENT NUMBER OF BOXES
    LEA SI, count
    INC BYTE PTR[SI]

    MOV AL, 07H
    CMP [SI], AL
    JZ X1

    PAINT2:
        MOV SI, rowstr

        ROW2:
            ;FOR EVERY ROW
            MOV CX, colmend

        COLUMN2:
            ;FOR EVERY COLUMN
            
            ;DECREASE AND STORE CX
            DEC CX
            MOV DI, CX
            PUSH CX

            ;PAINT PIXEL
            MOV AH, 0CH
            MOV AL, 1100b ;WHITE BOX: 1111b
            MOV CX, DI ;COLUMN
            MOV DX, SI ;ROW
            INT 10H

            ;CHECK COLUMN
            POP CX
            CMP CX, colmstr
            JNZ COLUMN2 ;NEXT COLUMN

            INC SI
            CMP SI, rowend
            JNZ ROW2 ;NEXT ROW

    ;CHANGE PARAMETERS
    LEA SI, rowstr
    ADD WORD PTR[SI], 10
    LEA SI, rowend
    SUB WORD PTR[SI], 10
    LEA SI, colmstr
    ADD WORD PTR[SI], 10
    LEA SI, colmend
    SUB WORD PTR[SI], 10
    
    ;INCREMENT NUMBER OF BOXES
    LEA SI, count
    INC BYTE PTR[SI]

    MOV AL, 07H
    CMP [SI], AL
    JNZ PAINT1

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
