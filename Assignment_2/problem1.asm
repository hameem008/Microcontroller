.MODEL SMALL

.STACK 100H

.DATA
CR EQU 0DH
LF EQU 0AH
N DW ?
K DW ?
ANS DW ?

.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

;FOR INFINITY TEST CASES
INFINITY:
    ;INITIALIZING WITH 0
    MOV AX,0
    MOV BX,0
    MOV CX,0
    MOV DX,0
    
    ;FOR TAKING INPUT OF N
    INPUT_N:
        ;INPUT OF A NUMBER CHARECTER
        MOV AH,1
        INT 21H
        
        ;FOR GETTING A SPACE OR NOT
        MOV CX,0
        MOV CL,AL
        CMP CL,' '
        JZ EXIT_INPUT_N
        
        ;STORING THE NUMBER INTO BX
        MOV AX,10
        MUL BX
        MOV BX,AX
        
        ;TAKING THE LAST FOUND DIGIT
        SUB CX,'0'
        ADD BX,CX
    JMP INPUT_N
    EXIT_INPUT_N:
    
    ;ASSIGNING INTO VARIABLE N
    MOV N,BX
    
    ;INITIALIZING WITH ZERO
    MOV AX,0
    MOV BX,0
    MOV CX,0
    MOV DX,0
    
    ;FOR TAKING INPUT OF K
    INPUT_K:
        ;INPUT OF A NUMBER CHARECTER
        MOV AH,1
        INT 21H
        
        ;FOR GETTING A NEW LINE
        MOV CX,0
        MOV CL,AL
        CMP CL,13
        JZ EXIT_INPUT_K
        
        ;STORING THE NUMBER INTO BX
        MOV AX,10
        MUL BX
        MOV BX,AX
        
        ;TAKING THE LAST FOUND DIGIT
        SUB CX,'0'
        ADD BX,CX
    JMP INPUT_K
    EXIT_INPUT_K:
    
    ;ASSIGNING INTO VARIABLE K
    MOV K,BX
    
    ;INITIALIZING ANS VARIABLE
    MOV AX,0
    MOV ANS,AX
    
    LP:
        ;INITIALIZING ALL REGISTERS
        MOV AX,0
        MOV BX,0
        MOV CX,0
        MOV DX,0
        
        MOV AX,N
        MOV BX,K
        ;N = N/K + N%K
        ;ANS = ANS + N - N%K
        DIV BX
        
        CMP AX,0
        JZ EXIT_LP
        MOV CX,N
        SUB CX,DX
        ADD CX,ANS
        MOV ANS,CX
        
        ADD AX,DX
        MOV N,AX
        JMP LP
    EXIT_LP:
    
    ;ADDING LAST REMAINDER
    ADD DX,ANS
    MOV ANS,DX
    
    MOV AX,0
    MOV DX,0
    
    ;PUSHING THE ANS INTO THE STACK DIGIT BY DIGIT
    ST:     
        MOV AX,ANS
        CMP AX,0
        JZ EXIT_ST
        
        MOV AX,ANS
        MOV BX,10
        DIV BX
        MOV ANS,AX
        PUSH DX
        
        MOV AX,0
        MOV DX,0
        
        JMP ST
    EXIT_ST:
    
    ;NEW LINE
    MOV AH,2
    MOV DL,CR
    INT 21H
    MOV AH,2
    MOV DL,LF
    INT 21H
    
    ;POPING THE ANS DIGITS BY DIGIT TO PRINT
    PRINT:     
        CMP SP,100H
        JZ EXIT_PRINT
        
        POP DX
        ADD DX,'0'
        MOV AH,2
        INT 21H
        JMP PRINT
    EXIT_PRINT:
    
    ;NEW LINE
    MOV AH,2
    MOV DL,CR
    INT 21H
    MOV AH,2
    MOV DL,LF
    INT 21H  
    
JMP INFINITY

MAIN ENDP
END MAIN