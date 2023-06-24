.model tiny
.data
    ;INPUT ONE ALPHABET FROM USER
    ;DISPLAY CHARACTER ENETERED IS/NNOT A
    out1 db 'The character entered is a$'
    out2 db 'The character entered is not a$'

    max1 db 2
    act1 db ?
    inp1 db 2 dup('$')

.code
.startup

    ;TAKE INPUT FROM USER
    MOV AH, 01H
    LEA DX, max1
    INT 21H

    ;INPUT IN AL

    ;CHECK IF A
    CMP AL, 'a'
    JB X2

    X1:
        CMP AL, 'a'
        JNZ X4
        JMP X3

    X2:
        CMP AL, 'A'
        JNZ X4

    X3:
        ;OUTPUT STRING OUT1
        LEA DX, OUT1
        MOV AH, 09H
        INT 21H
        JMP TERM

    X4:
        ;OUTPUT STRING OUT2
        LEA DX, OUT2
        MOV AH, 09H
        INT 21H

    TERM:
        MOV AH, 4CH
        INT 21H

.exit
end
        