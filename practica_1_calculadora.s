;****** PROGRAMA CALCULADORA *********** 
 .MODEL  SMALL
        ;.386
        .STACK          

        .DATA     
NUMBER1      DB      ?
NUMBER2      DB      ?
RESULT     DB      ?
UNI     DB      ?
DECE    DB      ?
MENSAJE_INICIAL:    DB     'CALCULADORA PARA NUMEROS DE DOS DIGITOS INGRESE LA OPCION CORESPONDIENTE A LA OPERACION QUE DESEA REALIZAR: $'
MENSAJE_OPCIONES:   DB      'OPCIONES: $'
MENSAJE_INGRESO_INVALIDO:   DB      'VALOR INGRESADO NO CORRESPONDE A UN NUMERO, INGRESE UN VALOR NUEVAMENTE: $'
MENSAJE_OPCION1:    DB      '<S> PARA SUMAR. $'
MENSAJE_OPCION2:    DB      '<R> PARA RESTAR. $'
MENSAJE_OPCION3:    DB      '<M> PARA MULTIPLICAR. $'
MENSAJE_OPCION4:    DB      '<D> PARA DIVIDIR. $'
MENSAJE_NUMERO1:     DB     'INGRESAR NUMERO 1: $'
MENSAJE_NUMERO2:     DB     'INGRESAR NUMERO 2: $'
MENSAJE_RESULTADO:    DB     'RESULTADO DE LA OPERACION: $'
MENSAJE_SALIR:  DB     'DIGITE <E> PARA SALIR: $'

        .CODE
        ORG     0000    
        JMP     MAIN

;****** DEFINICION DEL SEGMENTO DE DATOS ***********       
SEG_DAT:
        MOV     AX,@DATA
        MOV     DS,AX
        RET
;****************************************************

;******* MENSAJE MENU DE OPCIONES *******************************
VISUALIZAR_MENU:
    MOV     DX,OFFSET MENSAJE_INICIAL
    MOV     AH,09h
    INT     21h
;******* MENSAJE OPCIONES *******************************
    MOV     DX,OFFSET MENSAJE_OPCIONES
    MOV     AH,09h
    INT     21h
;******* MENSAJE OPCION SUMA *******************************
    MOV     DX,OFFSET MENSAJE_OPCION1
    MOV     AH,09h
    INT     21h
;******* MENSAJE OPCION RESTA*******************************
    MOV     DX,OFFSET MENSAJE_OPCION2
    MOV     AH,09h
    INT     21h
;******* MENSAJE OPCION MULTIPLICAR *******************************
    MOV     DX,OFFSET MENSAJE_OPCION3
    MOV     AH,09h
    INT     21h
;******* MENSAJE OPCION DIVISION*******************************
    MOV     DX,OFFSET MENSAJE_OPCION4
    MOV     AH,09h
    INT     21h
    RET
;******* MENSAJE NUMERO 1 *******************************
VISUALIZAR_MENSAJE_NUMERO1:
        MOV     DX,OFFSET MENSAJE_NUMERO1
        MOV     AH,09H
        INT     21H
        RET
;****************************************************

;******* MENSAJE NUMERO 2 *******************************
VISUALIZAR_MENSAJE_NUMERO2:
        MOV     DX,OFFSET MENSAJE_NUMERO2
        MOV     AH,09H
        INT     21H
        RET
;******* MENSAJE RESULTADO *******************************
VISUALIZAR_RESULTADO:
        MOV     DX,OFFSET MENSAJE_RESULTADO
        MOV     AH,09H
        INT     21H
        RET
;****************************************************

;******* MENSAJE  SALIR *******************************
VISUALIZAR_MENSAJE_SALIR:
        MOV     DX,OFFSET MENSAJE_SALIR
        MOV     AH,09H
        INT     21H
        RET
;****************************************************

;********** INGRESO NUMERO *****************************
INGRESO:
        MOV     AH,01H
        INT     21H
        RET
;********** INGRESO INVALIDO *****************************
INGRESO_INVALIDO:  
    MOV     DX,OFFSET MENSAJE_INGRESO_INVALIDO
    MOV     AH,09H
    INT     21H
    JMP     INGRESO    
;********** VALIDAR QUE EL VALOR INGRESADO SEA NUMERICO *****************************
VALIDAR_INGRESO:  
     CMP     AL, 39H
     JG      INGRESO_INVALIDO
     RET

;**********************************************************


;*********** OPERACIONES *************************
SUMAR:
    RET
RESTAR:
    RET
MULTIPLICAR:
    RET
DIVIDIR:
    RET
;*********** PROGRAMA PRINCIPAL *************************
MAIN:   CALL    SEG_DAT

CICLOING:
        CALL    VISUALIZAR_MENU
        CALL    INGRESO
        CMP     AL,'S'
        JE      SUMAR
        CMP     AL,'R'
        JE      RESTAR
        CMP     AL,'M'
        JE      MULTIPLICAR
        CMP     AL,'D'
        JE      DIVIDIR
        CALL    VISUALIZAR_MENSAJE_SALIR
        CALL    INGRESO
        CMP     AL,'E'
        JE      SALIR
        JMP     CICLOING

SALIR:  MOV     AH,4CH
        INT     21H
   END