.model tiny
.data
    colmstr dw 10
    rowstr dW 10

    colmend dw 410
    rowend dw 410

.code
.startup

    ;PRINT A WHITE SQUARE OF PIXEL 400X400 AND FROM (10,10)
    LEA SI, rowstr
    LEA DI, colmend

    ;SET GRAPHICS MODE
    MOV AH, 00H
    MOV AL, 12H
    INT 10H

    ;SET THE CURSOR POSITION
    MOV AH, 02H
    MOV DH, 20 ;ROW
    MOV DL, 20 ;COLUMN
    MOV BH, 00H
    INT 10H



    ;PAINT THE BOX
    PAINT1:
        MOV SI, rowstr

        ROW1:
            ;FOR EVERY ROW
            MOV CX, colmend

        COLUMN1:
            ;FOR EVERY COLUMN OF EVERY ROW

            ;DECREMENT AND STORE CX
            DEC CX
            MOV DI, CX
            PUSH CX


            ;PAINT THE PIXEL
            MOV AH, 0CH
            MOV AL, 1111b
            MOV DX, SI ;ROW
            MOV CX, DI ;COLUMN
            INT 10H

            ;CHECK COLUMN
            POP CX
            CMP CX, colmstr
            JNZ COLUMN1

            ;CHECK ROW
            INC SI
            CMP SI, rowend
            JNZ ROW1

        ;BLOCKER FUNCTION
        MOV AH, 07H
        X1:
            INT 21H
            CMP AL, '%'
            JNZ X1

        ;TERMINATE PROGRAM
        TERM:
            MOV AH, 4CH
            INT 21H

.exit
end            