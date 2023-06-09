.model tiny
.data

    filename1 db 'name.txt', 0
    filename2 db 'id.txt', 0
    filename3 db 'splice.txt', 0

    filehandle1 dw ?
    filehandle2 dw ?
    filehandle3 dw ?

    max1 db 32
    act1 db ?
    inputname  db 32 dup('$')

    max2 db 32
    act2 db ?
    inputid db 32 dup('$')

.code
.startup

    ;CREATE FILE NAME.TXT
    MOV AH, 3CH
    MOV CX, 00H
    LEA DX, filename1
    MOV AL, 00H
    INT 21H
    MOV filehandle1, AX

    ;CREATE FILE ID.TXT
    MOV AH, 3CH
    MOV CX, 00H
    LEA DX, filename2
    MOV AL, 00H
    INT 21H
    MOV filehandle2, AX

    ;TAKE NAME INPUT FROM USER
    MOV AH, 0AH
    LEA DX, max1
    INT 21H

    ;TAKE ID INPUT FROM USER
    MOV AH, 0AH
    LEA DX, max2
    INT 21H

    ;OPEN NAME.TXT
    MOV AH, 3DH
    MOV AL, 01H
    LEA DX, filename1
    INT 21H
    MOV filehandle1, AX

    ;OPEN ID.TXT
    MOV AH, 3DH
    MOV AL, 01H
    LEA DX, filename2
    INT 21H
    MOV filehandle1, AX

    ;WRITE TO NAME.TXT
    MOV AH, 40H
    MOV BX, filehandle1
    LEA DX, inputname
    MOV CH, 00H
    MOV CL, act1

    ;WRITE TO ID.TXT
    MOV AH, 40H
    MOV BX, filehandle2
    LEA DX, inputid
    MOV CH, 00
    MOV CL,act2

    ;CLOSE FILES
    MOV AH, 3EH
    INT 21H

    MOV BX, filehandle1
    MOV AH, 3EH
    INT 21H

    ;CREATE SPLICE.TXT
    MOV AH, 3CH
    LEA DX, filename3
    MOV CX, 00H
    MOV AL, 00H
    INT 21H
    MOV filehandle3, AX

    ;OPEN SPLICE.TXT FOR WRITING
    MOV AH, 3DH
    MOV AL, 01H
    LEA DX, filename3
    INT 21H
    MOV filehandle3, AX
    
    ;WRITE ID TO FILE
    MOV AH, 40H
    MOV BX, filehandle3
    LEA DX, inputid
    MOV CH, 00H
    MOV CL, act2
    INT 21H

    ;WRITE NAME TO FILE
    MOV AH, 40H
    MOV BX, filehandle3
    LEA DX, inputname
    MOV CH, 00H
    MOV CL, act1
    INT 21H


    ;CLOSE SPLICE.TXT
    MOV BX, filehandle3
    MOV AH, 3EH
    INT 21H

    TERM:
        MOV AH, 4CH
        INT 21H

.exit
end
