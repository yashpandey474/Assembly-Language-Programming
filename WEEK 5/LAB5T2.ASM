.model tiny
.data
    ;CONVERT INPUT STRING [ALL LOWERCASE]
    ;TO UPPERCASE AND DISPLAY TO USER
    ;A-Z: 41-5A, a-z: 61-7Aß
    
    max1 db 32
    act1 db ?ß
    inp1 db 32 dup('$')

.code
.startup

    ;TAKE INPUT FROM USER
    LEA DX, max1
    MOV AH, 0AH
    INT 21H

    ;CONVERT TO UPPERCASE
    LEA SI, inp1
    MOV CH, 00Hd
    MOV CL, act1
    
    X1:
        SUB BYTE PTR[SI], 20H
        INC SI
        LOOP X1

    ;OUTPUT STRING TO USER
    MOV AH, 09H
    LEA DX, inp1
    INT 21H
.exit
end
    
