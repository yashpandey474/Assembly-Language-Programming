.model tiny
.data
    out1 db 'Enter 10 character long user name $'
    out2 db 'Enter 5 character long password $'
    out3 db 'Hello $'

    incorrect1 db 'Incorrect Username$'
    incorrect2 db 'Incorrect Password$'

    max1 db 12
    act1 db ?
    username db 12 dup('$')

    max2 db 6
    act2 db ?
    password db 6 dup('$')

    correct_username db 'ypandey474$'
    count1 db 11

    correct_password db 'pass1$'
    count2 db 6

    nline db 0AH, 0DH, '$'

.code
.startup

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

    ; ;INPUT STRING
    ; LEA DX, max2
    ; MOV AH, 0AH
    ; INT 21H

    ; ;CHECK 2
    ; MOV CX, 06
    ; LEA SI, password
    ; LEA DI, correct_password

    ;CHECK PASSWORD
    ; REPE CMPSB

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






