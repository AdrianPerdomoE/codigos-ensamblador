;PROGRAMA PARA REALIZAR LA SUMA DE DOS NUMEROS DE UN SOLO DIGITO
;*****************************************************************
        .MODEL  SMALL
        ;.386
        .STACK          ;DEFINIR SEGMENTO DE PILA

        .DATA           ;DEFINIIR SEGMENTO DE DATOS
N1      DB      ?
N2      DB      ?
RES     DB      ?
UNI     DB      ?
DECE    DB      ?
MMEN:    DB     'PROGRAMA PARA LA SUMA DE DOS NUMEROS DE UN SOLO DIGITO: $'
MN1:     DB     'INGRESAR NUMERO 1: $'
MN2:     DB     'INGRESAR NUMERO 2: $'
MRES:    DB     'RESULTADO DE OPERACION: $'
MSALIR:  DB     'DIGITE <S> PARA SALIR: $'

        .CODE
        ORG     0000    ;ASEGURAR DESPLAZAMIENTO 0000 PARA EL CS
        JMP     MAIN

;****** DEFINICION DEL SEGMENTO DE DATOS ***********
SEG_DAT:
        MOV     AX,@DATA
        MOV     DS,AX
        RET
;****************************************************

;******* MENSAJE MENU *******************************
VIS_MMEN:
        MOV     DX,OFFSET MMEN
        MOV     AH,09h
        INT     21h
        RET
;****************************************************

;******* MENSAJE NUMERO 1 *******************************
VIS_MMN1:
        MOV     DX,OFFSET MN1
        MOV     AH,09H
        INT     21H
        RET
;****************************************************

;******* MENSAJE NUMERO 2 *******************************
VIS_MMN2:
        MOV     DX,OFFSET MN2
        MOV     AH,09H
        INT     21H
        RET
;****************************************************

;******* MENSAJE RESULTADO *******************************
VIS_MMRES:
        MOV     DX,OFFSET MRES
        MOV     AH,09H
        INT     21H
        RET
;****************************************************

;******* MENSAJE  SALIR *******************************
VIS_MMSALIR:
        MOV     DX,OFFSET MSALIR
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


;*********** PROGRAMA PRINCIPAL *************************
MAIN:   CALL    SEG_DAT
CICLOING:
        CALL    VIS_MMEN
        CALL     SUMA

SUMA:   CALL    VIS_MMN1
        CALL    INGRESO
        AND     AL,0FH          ;CONVERSION DE ASCII A HEX
        MOV     N1,AL
        CALL    VIS_MMN2
        CALL    INGRESO
        AND     AL,0FH
        MOV     N2,AL
        MOV     AH,0
        ADD     AL,N1
        AAM
        OR      AX,3030H        ;CONVERSION DE HEX A ASCII
        MOV     DECE,AH
        MOV     UNI,AL
        CALL    VIS_MMRES
        MOV     DL,DECE
        MOV     AH,02H
        INT     21H
        MOV     DL,UNI
        MOV     AH,02H
        INT     21H
        CALL    VIS_MMSALIR
        CALL    INGRESO
        CMP     AL,'S'
        JE      SALIR
        JMP     CICLOING

SALIR:  MOV     AH,4CH
        INT     21H

        END
