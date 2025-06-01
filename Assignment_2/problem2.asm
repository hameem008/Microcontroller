.MODEL SMALL

.STACK 100H

.DATA
CR EQU 0DH
LF EQU 0AH
N DW ?
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
        CMP CL,13
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
    
    MOV AX,0
    MOV BX,0
    MOV CX,0
    MOV DX,0
    
    MOV ANS,AX
    MOV AX,N    
    PUSH AX
    CALL DIGIT_SUM
    
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
    
    ;POPING THE ANS DIGIT BY DIGIT TO PRINT
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

;RECURSIVE FUNCTION
DIGIT_SUM PROC NEAR
    
    PUSH BP
    MOV BP,SP
    
    ;BASE CASE OF THE FUNCTION
    CMP WORD PTR[BP+4],0
    JZ RETURN
    
    MOV AX,0
    MOV DX,0
    MOV AX,[BP+4]
    MOV BX,10
    DIV BX
    PUSH AX
    
    ;STORING THE ANSWER
    ADD ANS,DX
    
    ;RECURSIVE CALL
    CALL DIGIT_SUM
    
    RETURN:
        POP BP
        RET 2

DIGIT_SUM ENDP
 
END MAIN