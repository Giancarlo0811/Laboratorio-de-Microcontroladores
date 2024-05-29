#include "p16f877a.inc"
__CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_ON & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _WRT_OFF & _CP_OFF
LIST P=16F877A
ORG 0

num EQU 0x21
i EQU 0x22
Valor EQU 0x23
 
BSF STATUS, RP0 ; Ir al bank 1
BCF TRISB, 0 ; PIN 0 como salida
BCF TRISB, 1 ; PIN 1 como salida
BCF STATUS, RP0 ; Ir al bank 0
    
BCF PORTB, 0 ; LED 1 inicialmente apagado
BCF PORTB, 1 ; LED 2 inicialmente apagado

PROGRAMA
BSF PORTB, 0 ; encender LED 1
BCF PORTB, 1 ; apagar LED 2
CALL RETARDO1S ; llamar el retardo de 1s
BCF PORTB, 0 ; apagar LED 1
BSF PORTB, 1 ; encender LED 2
CALL RETARDO1S ; llamar el retardo de 1s
GOTO PROGRAMA    

; retardo para 1HZ == 1s
RETARDO1S ; 2cm 
MOVLW d'26' ; 1cm --> N
MOVWF num ; 1cm
ARRIBA
MOVLW d'255' ; 1cm*N --> M
MOVWF i ; 1cm*N
BUCLE1
MOVLW d'255' ; 1cm*N*M --> P
MOVWF Valor ; 1cm*N*M
REPITE1
DECFSZ Valor,1 ; --> (P-1)*M*N + 2M*N
GOTO REPITE1 ; --> (P-1)*M*N*2
DECFSZ i,1 ; --> (M-1)*N + 2N
GOTO BUCLE1 ; --> (M-1)*2*N
DECFSZ num,1 ; --> (N-1) + 2cm
GOTO ARRIBA ; --> (N-1)*2
RETURN ; 2cm

END
    
    