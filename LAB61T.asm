.model tiny
.data
    ;$ TERMINATED OUTPUT STRING
    out1 db 'Please Enter Your Name: $'

    ;PARAMETERS TO TAKE STRING AS INPUT
    max1 db 32
    act1 db ?
    inputstring db 32 dup('$')

    ;PARAMETER OF FILENAME AND FILE HANDLE
    filename db 'lab6task1.txt',0
    filehandle db ?

.code
.startup
    ;OUTPUT STRING TO ASK TO ENTER NAME
    LEA DX, out1
    MOV AH, 09H
    INT 21H

    ;INPUT STRING FROM USER
    LEA DX, max1
    MOV AH, 0AH
    INT 21H

    ;CREATE NEW TEXT FILE
    MOV AH, 3CH
    MOV CX, 00H
    MOV DX, filename
    MOV AL, 00H
    INT 21H
    MOV filehandlle, AX

    ;OPEN THIS FILE FOR WRITING
    MOV AH, 3DH
    MOV AL, 01H
    MOV DX, filename
    INT 21H
    MOV filehandle, AX

    ;WRITE NAME INTO FILE
    MOV AH, 40H
    MOV BX, filehandle
    LEA DX, inputstring
    MOV CX, act1 ;NUMBER OF CHARACTERS TO WRITE
    INT 21H

.exit
end



