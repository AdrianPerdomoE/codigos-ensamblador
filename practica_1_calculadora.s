;****** PROGRAMA CALCULADORA ***********
        .MODEL  SMALL 
	.386 
	.STACK           
	.DATA      
N1   DB	?
N2	DB      ?
RES	DB      ?
UNI  DB      ?
DECE DB      ?
REST DB     	?
COCI DB      ?
MSSINC DB     	10,13,'CALCULADORA PARA NUMEROS DE DOS DIGITOs: $' 
MSSOPC  DB      10,10,13,'OPCIONES: $' 
MSGIIV	DB      10,10,13,'VALOR INGRESADO NO CORRESPONDE A UN NUMERO, INGRESE UN VALOR NUEVAMENTE: $' 
MSSOP1  DB      10,10,13,'<S> PARA SUMAR. $' 
MSSOP2  DB      10,10,13,'<R> PARA RESTAR. $' 
MSSOP3  DB      10,10,13,'<M> PARA MULTIPLICAR. $' 
MSSOP4  DB      10,10,13,'<D> PARA DIVIDIR. $' 
MSSNUM1 DB     	10,10,13,'INGRESAR NUMERO 1: $' 
MSSNUM2 DB     	10,10,13,'INGRESAR NUMERO 2: $' 
MSSRES  DB     	10,10,13,'RES DE LA OPERACION: $' 
MSGSAL  DB     	10,10,13,'DIGITE <E> PARA SALIR: $'
MSSCOCI  DB     10,10,13,'COCIENTE DE LA DIVISION: $' 
MSSREST  DB     10,10,13,'RESTO DE LA DIVISION: $' 
ASCVAL  DB      5 DUP(00H),'$'
BINVAL  DW      0000 
         .CODE 
         ORG     0000     
         JMP     MAIN 
;****** DEFINICION DEL SEGMENTO DE DATOS ***********        
 SEG_DAT: 
     MOV     AX,@DATA 
     MOV     DS,AX 
     RET 
;**************************************************** 
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


 
;******* MENSAJE MENU DE OPCIONES ******************************* 
VIZMEN: 
     MOV     DX,OFFSET MSSINC 
     MOV     AH,09H 
     INT     21H
     RET 
;******* MENSAJE OPCIONES *******************************
VIZOPCNS: 
     MOV     DX,OFFSET MSSOPC 
     MOV     AH,09H 
     INT     21H
     RET 
;******* MENSAJE OPCION SUMA *******************************
VIZOPCS: 
     MOV     DX,OFFSET MSSOP1 
     MOV     AH,09H 
     INT     21H
     RET 
;******* MENSAJE OPCION RESTA*******************************
VIZOPCR: 
     MOV     DX,OFFSET MSSOP2 
     MOV     AH,09H 
     INT     21H
     RET 
;******* MENSAJE OPCION MULTIPLICAR ******************************* 
VIZOPCM:
     MOV     DX,OFFSET MSSOP3 
     MOV     AH,09H 
     INT     21H
     RET
;******* MENSAJE OPCION DIVISION******************************* 
VIZOPCD:
     MOV     DX,OFFSET MSSOP4 
     MOV     AH,09H 
     INT     21H 
     RET 
;******* MENSAJE NUMERO 1 ******************************* 
VIZ_MSSNUM1: 
     MOV     DX,OFFSET MSSNUM1 
     MOV     AH,09H 
     INT     21H 
     RET 
;**************************************************** 
 
 
;******* MENSAJE NUMERO 2 ******************************* 
VIZ_MSSNUM2: 
     MOV     DX,OFFSET MSSNUM2 
     MOV     AH,09H 
     INT     21H 
     RET 
;******* MENSAJE RES ******************************* 
VIZ_RES: 
     MOV     DX,OFFSET MSSRES 
     MOV     AH,09H          
	 INT     21H 
     RET 
;**************************************************** 
 ;*** MENSAJE COCIENTE********* 
VIZ_COCI: 
     MOV     DX,OFFSET MSSCOCI 
     MOV     AH,09H          
     INT     21H 
     RET 
;******************
;*** MENSAJE RESTO *********** 
VIZ_REST: 
     MOV     DX,OFFSET MSSREST
     MOV     AH,09H          
     INT     21H 
     RET 
;******************
 
;******* MENSAJE  SALIR ******************************* 
VIZ_MSGSAL: 
     MOV     DX,OFFSET MSGSAL 
     MOV     AH,09H 
     INT     21H 
     RET 
;**************************************************** 
 
 VIZ_MENSAJE:
     MOV     AH,09H
     INT     21H
     RET
;**** INGRESO NUMERO *********** 
INGRESO: 
     MOV     AH,01H 
     INT     21H 
     RET 
;********************
INGRESO2DIG:
	CALL INGRESO
     CALL VALIDAR_INGRESO
	AND	AL,0FH
	MOV	AH,0
	MOV	DL,10
	MUL	DL
	MOV  BL,AL
	CALL INGRESO
     CALL VALIDAR_INGRESO
	AND	AL,0FH
	ADD	BL,AL
	RET
;********************
;**** INGRESO INVALIDO *********** 
 INGRESO_INVALIDO:   
     MOV     DX,OFFSET MSGIIV 
     MOV     AH,09H 
     INT     21H 
     JMP     INGRESO2DIG     
;**** VALIDAR QUE EL VALOR INGRESADO SEA NUMERICO *********** 
VALIDAR_INGRESO:   
     CMP     AL, 3AH 
     JAE     INGRESO_INVALIDO 
     RET 
  
  
;********************************************************** 
;*********** OPERACIONES ************************* 
MULTIPLICAR: 
     CALL    VIZ_MSSNUM1
     CALL    INGRESO2DIG
     MOV	   N1,BL
     CALL    VIZ_MSSNUM2
     CALL    INGRESO2DIG
     MOV	    N2,BL
     MOV      AH,0
     MOV	    AL,N1
     MUL      N2
     MOV	    BINVAL,AX
     CALL    BINASCII
     CALL    VIZ_RES
     MOV	    DX,OFFSET ASCVAL
     CALL    VIZ_MENSAJE
     CALL    CICLOING
SUMAR: 
     CALL   VIZ_MSSNUM1
     CALL   INGRESO2DIG  
     MOV    N1,BL
     CALL   VIZ_MSSNUM2
     CALL   INGRESO2DIG         
     MOV    N2,BL  
     MOV    AH,0              
     MOV    AL,N1
     ADD    AL,N2                
     MOV    BINVAL,AX
     CALL   BINASCII
     CALL   VIZ_RES
     MOV    DX,OFFSET ASCVAL    
     CALL   VIZ_MENSAJE     
     CALL   CICLOING  
N1MENORN2:
     MOV AL,N2
     MOV N2,N1
     RET
RESTAR:
     CALL VIZ_MSSNUM1
     CALL INGRESO2DIG
     MOV	N1,BL

     CALL VIZ_MSSNUM2
     CALL INGRESO2DIG
     MOV  N2,BL
     MOV  AH,0
     MOV  AL,N1
     CMP  AL,N2
     JL  N1MENORN2
     SUB AL,N2
     AAS
     OR   AX,3030H
     CALL VIZ_RES
     MOV  DH,0
     MOV  DECE,AH
     MOV  UNI,AL
     MOV  DL,DECE
     CALL VIZ_MENSAJE
     MOV  DL,UNI
     CALL VIZ_MENSAJE
     CALL CICLOING  
DIVIDIR:
     CALL VIZ_MSSNUM1
     CALL INGRESO2DIG
     MOV	N1,BL

     CALL VIZ_MSSNUM2
     CALL INGRESO2DIG
     MOV  N2,BL
     MOV  AH,0
     MOV AL,N1

     DIV N2
     OR  AX,3030H
     MOV REST,AH
     MOV COCI,AL
     MOV DH,0
     CALL VIZ_RES
     CALL VIZ_REST
     MOV  DL,REST
     CALL VIZ_MENSAJE
     
     CALL VIZ_COCI
     MOV  DL,COCI
     CALL VIZ_MENSAJE
     CALL CICLOING 
;*********** PROGRAMA PRINCIPAL ************************* 
 MAIN:   CALL    SEG_DAT 
 
CICLOING: 
     CALL    VIZMEN
     CALL	 VIZOPCNS
     CALL	 VIZOPCS
     CALL	 VIZOPCR
     CALL	 VIZOPCM
     CALL	 VIZOPCD	
     CALL    INGRESO 
     CMP     AL,'S' 
     JE      SUMAR 
     CMP     AL,'R' 
     JE      RESTAR 
     CMP     AL,'M' 
     JE      MULTIPLICAR 
     CMP     AL,'D' 
     JE      DIVIDIR 
     CALL    VIZ_MSGSAL 
     CALL    INGRESO 
     CMP     AL,'E' 
     JE      SALIR 
     JMP     CICLOING  
SALIR:  
	MOV     AH,4CH 
     INT     21H 
    END 