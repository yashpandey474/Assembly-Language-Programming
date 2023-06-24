.model tiny
.data
    ;PROCEDURE TO CALCULATE NPR: N!/(N-R)!
    valuen dW 5
    valuer dW 2

.code
.startup
    MOV BX, valuen
    MOV DX, valuer
    CALL NPR

    ;RESULT SHOULD BE IN AX

    FACTORIAL PROC NEAR
    ;PARAMETER PASSED IN CX
    ;RESULT STORED IN AX
    CMP CX, 01H 
    JZ X1
        PUSH CX
        SUB CX, 1
        CALL FACTORIAL
        POP BX
        MUL BL

    X1: RET    
    FACTORIAL ENDP

    
    NPR PROC NEAR
    ;DX STORES (N-R)!
        MOV AX, BX
        SUB AX, DX
        MOV DX, AX

    MOV AX, 1
    ;CALCULATE N!
        MOV CX, BX
        CALL FACTORIAL
        ;AX = N!
        MOV BX, AX

    MOV AX, 1
    ;CALCULATE (N-R)!
        MOV CX, DX
        CALL FACTORIAL
        ;AX = (N-R)!

    MOV DX, AX
    MOV AX, BX
    DIV DX
    
    NPR ENDP
        
.exit


end
