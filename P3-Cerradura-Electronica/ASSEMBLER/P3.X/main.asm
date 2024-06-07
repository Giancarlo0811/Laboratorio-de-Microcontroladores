#include "p16f877a.inc"
__CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_ON & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _WRT_OFF & _CP_OFF
LIST P=16F877A
INCLUDE <mimacro.inc>
CBLOCK 0x20 ; bloque de memorias
teclapulsada ; Variable donde se guarda la 1ra tecla pulsada
teclapulsada2 ; Variable donde se guarda la 2da tecla pulsada
teclapulsada3 ; Variable donde se guarda la 3ra tecla pulsada
teclapulsada4 ; Variable donde se guarda la 4ta tecla pulsada
ENDC ; fin del bloque de memorias
ORG 0

banco 1 ; ir al banco 1
CLRF TRISD ; puerto D como salida (display)
BCF TRISC, 0 ; puerto RC0 como salida (led rojo - acceso denegado)
BCF TRISC, 1 ; puerto RC1 como salida (led verde - acceso permitido)
BCF TRISC, 2 ; puerto RC2 como salida (buzzer)
banco 0 ; ir al banco 0
CLRF PORTD      ;Limpiamos puerto D (Apagamos el display)
BCF PORTC, 0 ;led rojo inicialmente apagado
BCF PORTC, 1 ;led verde inicialmente apagado
BCF PORTC, 2 ;buzzer inicialmente apagado
iniciar_teclado ;Iniciamos el teclado matricial 4x4 (configuraciones)

PROGRAMA
    
leertecla		;leemos 1ra tecla
MOVWF teclapulsada      ;Guardamos la tecla pulsada en el registro 
registrocdisplay teclapulsada ;Escribimos la teclapulsada en el display (catodo comun)
milisegundo .255 ; delay antirebote
    
leertecla		;leemos 2da tecla
MOVWF teclapulsada2      ;Guardamos la tecla pulsada en el registro 
registrocdisplay teclapulsada2 ;Escribimos la teclapulsada en el display (catodo comun)
milisegundo .255 ; delay antirebote
    
leertecla		;leemos 3ra tecla
MOVWF teclapulsada3      ;Guardamos la tecla pulsada en el registro 
registrocdisplay teclapulsada3 ;Escribimos la teclapulsada en el display (catodo comun)
milisegundo .255 ; delay antirebote 
    
leertecla		;leemos 4ta tecla
MOVWF teclapulsada4      ;Guardamos la tecla pulsada en el registro 
registrocdisplay teclapulsada4 ;Escribimos la teclapulsada en el display (catodo comun)
milisegundo .255 ; delay antirebote

; ----------------------- Sección de la contraseña: 0626 --------------------
csni teclapulsada,.0, DENEGADO ; Si al consultar la contraseña, 1 digito falla
csni teclapulsada2,.6, DENEGADO ; automaticamente se irá a la subrutina
csni teclapulsada3,.2, DENEGADO ; llamada denegado
csni teclapulsada4,.6, DENEGADO
 
; ----------------------- Secuencia de entrada permitida -------------------
; Si se ha llegado aquí es porque la contraseña es correcta.
CALL PERMITIDO
GOTO PROGRAMA           ;finaliza el programa
 
DENEGADO ; aquí empieza la subrutina en caso de que la contraseña sea erronea
BSF PORTC, 0 ; encendemos led rojo
BSF PORTC, 2 ; encendemos buzzer - alarma
segundo .2 ; delay de 2 segundos
BCF PORTC, 0 ; apagamos led rojo
BCF PORTC, 2 ; apagamos buzzer - alarma
CLRF PORTD
GOTO PROGRAMA ; reiniciamos el programa

PERMITIDO
BSF PORTC, 1 ; encendemos led verde
segundo .2 ; delay de 2 segundos
BCF PORTC, 1 ; apagamos led verde
CLRF PORTD
GOTO PROGRAMA ; reiniciamos el programa
 
INCLUDE <teclado4x4.asm> ; libreria para teclado
INCLUDE <display.ASM> ; libreria display 7 segmentos
INCLUDE <RETARDOS.ASM> ; libreria para retardos

END
    
