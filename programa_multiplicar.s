;PROGRAMA PARA MULTIPLICAR DOS NUMEROS DE DOS DIGITOS****************************
;**************************************************************************


        .MODEL  SMALL
        .386
        .STACK          ;DEFINIR SEGMENTO DE PILA

        .DATA           ;DEFINIIR SEGMENTO DE DATOS????????
N1      DB      ?
N2      DB      ?
RES     DW      ?
UNI     DB      ?
DECE    DB      ?
MMEN  DB     10,13,'PROGRAMA PARA MULTIPLICAR NUMEROS DE DOS DIGITOS $'
MN1     DB      10,10,13,'INGRESAR NUMERO 1 (DOS DIGITOS): $'
MN2     DB      10,13,'INGRESAR NUMERO 2 (DOS DIGITOS): $'
MRES    DB      10,10,13,'RESULTADO DE OPERACION: $'
MSALIR  DB      10,10,13,'DIGITE <S> PARA SALIR: $'
ASCVAL  DB      5 DUP(00H),'$'
BINVAL  DW      0000

        .CODE
        ORG     0000    ;ASEGURAR DESPLAZAMIENTO 0000 PARA EL CS
        JMP     MAIN

;****** DEFINICION DEL SEGMENTO DE DATOS ***********
SEG_DAT:
        MOV     AX,@DATA
        MOV     DS,AX
        RET
;****************************************************

;******* RUTINA PARA MENSAJE *******************************
VIS_MENSAJE:
        MOV     AH,09H
        INT     21H
        RET
;****************************************************

;********** INGRESO NUMERO *****************************
INGRESO:
        MOV     AH,01H
        INT     21H
        RET
;**********************************************************

;**********************************************************
INGRESO2DIG:
	MOV	AH,01H
	INT	21H
	AND	AL,0FH
	MOV	AH,0
	MOV	DL,10
	MUL	DL
        MOV     BL,AL
	MOV	AH,01H
	INT	21H
	AND	AL,0FH
	ADD	BL,AL
	RET
;**********************************************************

;**********************************************************
SALIR:  MOV     AH,4CH
        INT     21H
	RET
;**********************************************************

;**********************************************************
BINASCII:       
	LEA     SI,ASCVAL
        MOV     CX,5
        MOV     AL,00H
C10:    MOV     [SI],AL
        INC     SI
        LOOP    C10
        MOV     CX,10
        LEA     SI,ASCVAL+4
        MOV     AX,BINVAL
C20:    CMP     AX,CX
        JB      C30
        XOR     DX,DX
        DIV     CX
        OR      DL,30H
        MOV     [SI],DL
        DEC     SI
        JMP     C20
C30:    OR      AL,30H
        MOV     [SI],AL
        RET
;**********************************************************

;*********** PROGRAMA PRINCIPAL *************************
MAIN:   CALL    SEG_DAT
CICLOING:
        MOV     DX,OFFSET MMEN
	CALL    VIS_MENSAJE

MULTI:   MOV     DX,OFFSET MN1
	CALL    VIS_MENSAJE
        CALL    INGRESO2DIG
	MOV	N1,BL

        MOV	DX,OFFSET MN2
	CALL    VIS_MENSAJE
        CALL    INGRESO2DIG
	MOV	N2,BL

        MOV     AH,0
	MOV	AL,N1
        MUL     N2

	MOV	BINVAL,AX
	CALL	BINASCII

	MOV	DX,OFFSET MRES
	CALL    VIS_MENSAJE
	MOV	DX,OFFSET ASCVAL
	CALL    VIS_MENSAJE
	
        MOV	DX,OFFSET MSALIR
        CALL    VIS_MENSAJE
        CALL    INGRESO
        CMP     AL,'S'
        JE      SALIR
        JMP     CICLOING


        END
