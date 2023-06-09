.model tiny
.data
;TAKE CORRECT USERNAME AND PASSWORD FROM FILES
    out1 db 'Enter 10 character long user name $'
    out2 db 'Enter 5 character long password $'
    out3 db 'Hello $'

    filename1 db 'username.txt',0
    filename2 db 'pswd.txt',0

    filehandle1 dw ?
    filehandle2 dw ?

    incorrect1 db 'Incorrect Username$'
    incorrect2 db 'Incorrect Password$'

    max1 db 12
    act1 db ?
    username db 12 dup('$')

    max2 db 6
    act2 db ?
    password db 6 dup('$')

    correct_username db 11 dup('$')
    correct_password db 6 dup('$')

    nline db 0AH, 0DH, '$'

.code
.startup

    ;OPEN USERNAME FILE
    MOV AH, 3DH
    MOV AL, 00H
    LEA DX, filename1
    INT 21H
    MOV filehandle1, AX

    ;READ FROM USERNAME FILE
    MOV AH, 3FH
    MOV BX, filehandle1
    MOV CX, 11
    LEA DX, correct_username
    INT 21H

    ;OPEN PASSWORD FILE
    MOV AH, 3DH
    MOV AL, 00H
    LEA DX, filename2
    INT 21H
    MOV filehandle2, AX

    ;READ FROM PASSWORD FILE
    MOV AH, 3FH
    MOV BX, filehandle2
    MOV CX, 6
    LEA DX, correct_password
    INT 21H

    ;display correct one
    LEA DX, correct_username
    MOV AH, 09H
    INT 21H

    LEA DX, out3
    MOV AH, 09H
    INT 21H


    ;CLOSE FILES
    MOV AH, 3EH
    INT 21H

    MOV BX, filehandle1
    MOV AH, 3EH
    INT 21H

    ;DISPLAY STRING
    MOV AH, 09H
    LEA DX, out1
    INT 21H
    
    ;PRINT NEW LINE
    LEA DX, nline
    MOV AH, 09H
    INT 21H

    ;INPUT STRING
    MOV AH, 0AH
    LEA DX, max1
    INT 21H

    ;CHECK 1
    MOV CX, 11
    LEA SI, username
    LEA DI, correct_username

    ;CHECK USERNAME
    CLD
    REPE CMPSB
    
    CMP CX, 00
    JNZ X4

    ;CORRECT USERNAME

    ;DISPLAY STRING
    MOV AH, 09H
    LEA DX, out2
    INT 21H

    ;PRINT NEW LINE
    MOV AH, 09H
    LEA DX, NLINE
    INT 21H

    ;MASK CHARACTERS
    MOV CX, 06H
    LEA DI, password

    X1:
        MOV AH, 08H
        INT 21H

        MOV [DI], AL
        INC DI

        MOV DL, '*'
        MOV AH, 02H
        INT 21H

        LOOP X1



    ;PRINT NEWLINE
    LEA DX, nline
    MOV AH, 09H
    INT 21H


    ;CHECK PASSWORD
    MOV CX, 06H
    LEA SI, password
    lEA DI, correct_password

    CLD
    REPE CMPSB

    CMP CX, 00H
    JNZ X5

    ;PRINT NEWLINE
    LEA DX, nline
    MOV AH, 09H
    INT 21H

    ;DISPLAY GREETING AND USERNAME
    LEA DX, OUT3
    MOV AH, 09H
    INT 21H

    LEA DX, username
    MOV AH, 09H
    INT 21H

    LEA DX, nline
    MOV AH, 09H
    INT 21H
    
    JMP TERM



    X4:
        LEA DX, incorrect1 
        MOV AH, 09H
        INT 21H
        JMP TERM

    X5:
        LEA DX, incorrect2
        MOV AH, 09H
        INT 21H

    TERM:
        MOV AH, 4CH
        INT 21H

.exit
end






