.model tiny
.data
    firstname dw 'Yash'
    count dw 4
.code
.startup

    ;REVERSE FIRST NAME IN PLACE USING ONLY THE STACK
    LEA SI, firstname
    LEA DI, firstname
    MOV CX, count

    X1:
        PUSH [DI]
        INC DI
        LOOP X1
    
    MOV CX, count
    X2:
        POP [SI]
        INC SI
        LOOP X2
.exit
end