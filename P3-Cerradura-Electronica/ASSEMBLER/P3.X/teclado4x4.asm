; ....................www.rodrigocarita.com................................
; Librer�a para teclado matricial 4x4
;Versi�n : 1.0
;..:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;Atencion: Esta librer�a funciona con la macro en Versi�n 1.2 y superiores.
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;   | 1 | 2 | 3 | A |   --->PORTB,0
;   | 4 | 5 | 6 | B |   ---> PORTB,1
;   | 7 | 8 | 9 | C |    --->PORTB,2
;   | * | 0 | # | D |   ---> PORTB,3
;      |    |    |    |
;    RB4 RB5 RB6 RB7
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;Modo de conexi�n es sencilla, con el teclado mir�ndonos, los pines se conectan de modo
;                                    RB0,RB1,RB2,RB3,...,RB7,
;-----------------------------------------------------------------------------------------------------------------------------

CBLOCK               ;Bloque de memorias para la subrutina
tekl4pul5        ;Registro donde se almacenar� el valor de la tecla pulsada
c0mpparadD0r ;Registro que ser� el comparador para el escaner de teclado
Sit3cl4pus     ;Registro de bucle para pausar o leer de corrido
Hhayrt3cla     ;Registro que permite saber si hay una tecla pulsada
ENDC		;Fin bloques de memorias	

IN1ci0t3cla4do  		; Subrutina de configuraci�n de Teclado. Activa las resistencias PULL-UP
banco 1           			;Vamos al banco 1
MOVLW b'11110000' 	; Configuramos las columnas como salida y las filas como entrada
MOVWF TRISB			;del puerto B.
BCF OPTION_REG,7		;Activa las resistencias tipo PULL-UP del pic
banco 0           			;Regresamos al Banco 0
CLRF tekl4pul5		;Limpiamos memorias de teclapulsada
CLRF Sit3cl4pus		;Limpiamos permisos para bucles
RETURN				;Salimos de la subrutina de configuraci�n

Tttest3aTecld0o							;t�tulo de subrutina para escaner de teclado	
cargarvalor .0,Hhayrt3cla				;Limpiamos el valor de comprobaci�n si hubo una tecla pulsada
cargarvalor b'11111110',PORTB			;Cargamos el primer valor para escanear la primera fila
nop										;Tiempo paran�ico
copiarregistro PORTB,c0mpparadD0r		;Leemos el puerto B para ver si hay un bot�n pulsado
csi c0mpparadD0r,b'11101110',BoTt0Nn1	;Iniciamos el Escaneo, Se puls� la primera column�?	
csi c0mpparadD0r,b'11011110',BoTt0Nn2	;Se puls� la segunda columna?	
csi c0mpparadD0r,b'10111110',BoTt0Nn3	;Se puls� la tercera columna?
csi c0mpparadD0r,b'01111110',BoTt0NnA	;Se puls� la cuarta columna?

cargarvalor b'11111101',PORTB			;Cargamos el segundo valor para escanear la segunda fila
nop										;Tiempo paran�ico
copiarregistro PORTB,c0mpparadD0r		 ;Leemos el puerto B para ver si hay un bot�n pulsado
csi c0mpparadD0r,b'11101101',BoTt0Nn4         ;Iniciamos el Escaneo, Se puls� la primera column�?	
csi c0mpparadD0r,b'11011101',BoTt0Nn5         ;Se puls� la segunda columna?	
csi c0mpparadD0r,b'10111101',BoTt0Nn6         ;Se puls� la tercera columna?
csi c0mpparadD0r,b'01111101',BoTt0NnB         ;Se puls� la cuarta columna?

cargarvalor b'11111011',PORTB			;Cargamos el tercer valor para escanear la tercera fila	
nop                                                                                    ;Tiempo paran�ico 
copiarregistro PORTB,c0mpparadD0r                  ;Leemos el puerto B para ver si hay un bot�n pulsado
csi c0mpparadD0r,b'11101011',BoTt0Nn7         ;Iniciamos el Escaneo, Se puls� la primera column�?	
csi c0mpparadD0r,b'11011011',BoTt0Nn8         ;Se puls� la segunda columna?	
csi c0mpparadD0r,b'10111011',BoTt0Nn9         ;Se puls� la tercera columna?
csi c0mpparadD0r,b'01111011',BoTt0NnC         ;Se puls� la cuarta columna?

cargarvalor b'11110111',PORTB			;Cargamos el cuarto valor para escanear la cuarta fila	
nop                                                                                    ;Tiempo paran�ico 
copiarregistro PORTB,c0mpparadD0r                  ;Leemos el puerto B para ver si hay un bot�n pulsado
csi c0mpparadD0r,b'11100111',BoTt0NnAST     ;Iniciamos el Escaneo, Se puls� la primera column�?	
csi c0mpparadD0r,b'11010111',BoTt0Nn0         ;Se puls� la segunda columna?	
csi c0mpparadD0r,b'10110111',BoTt0NnMICH   ;Se puls� la tercera columna? 
csi c0mpparadD0r,b'01110111',BoTt0NnD         ;Se puls� la cuarta columna?
csi c0mpparadD0r,b'11110111',SinTecl4	 ; NO SE PULS� NADA??	

SinTecl4					;Subrutina para cuando no haya alguna tecla pulsada.		
cargarvalor .1,Hhayrt3cla	; Carga el valor de 1 en el registro Hhayrt3cla 
BTFSS Sit3cl4pus,0 			;Esta en el modo de pausa?
RETURN						;Caso falso: Sale de la subrutina continuando con el programa principal
GOTO Tttest3aTecld0o			;Caso verdadero: Continua testeando el teclado hasta que una tecla se pulse

BoTt0Nn0					;Subrutina para cuando se presione el bot�n 0
cargarvalor .0,tekl4pul5		;Carga el valor de "0" en el registro de respuesta tekl4pul5 
RETURN						;Sale de la subrutina de teclado

BoTt0Nn1					;Subrutina para cuando se presione el bot�n 1
cargarvalor .1,tekl4pul5           ;Carga el valor de "1" en el registro de respuesta tekl4pul5 
RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn2					;Subrutina para cuando se presione el bot�n 2
cargarvalor .2,tekl4pul5           ;Carga el valor de "2" en el registro de respuesta tekl4pul5 
RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn3					;Subrutina para cuando se presione el bot�n 3
cargarvalor .3,tekl4pul5           ;Carga el valor de "3" en el registro de respuesta tekl4pul5 
RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn4					;Subrutina para cuando se presione el bot�n 4
cargarvalor .4,tekl4pul5           ;Carga el valor de "4" en el registro de respuesta tekl4pul5 
RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn5					;Subrutina para cuando se presione el bot�n 5
cargarvalor .5,tekl4pul5           ;Carga el valor de "5" en el registro de respuesta tekl4pul5 
RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn6					;Subrutina para cuando se presione el bot�n 6
cargarvalor .6,tekl4pul5           ;Carga el valor de "6" en el registro de respuesta tekl4pul5 
RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn7					;Subrutina para cuando se presione el bot�n 7
cargarvalor .7,tekl4pul5           ;Carga el valor de "7" en el registro de respuesta tekl4pul5 
RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn8					;Subrutina para cuando se presione el bot�n 8
cargarvalor .8,tekl4pul5           ;Carga el valor de "8" en el registro de respuesta tekl4pul5 
RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn9					;Subrutina para cuando se presione el bot�n 9	
cargarvalor .9,tekl4pul5           ;Carga el valor de "9" en el registro de respuesta tekl4pul5 
RETURN                                                  ;Sale de la subrutina de teclado

BoTt0NnA					;Subrutina para cuando se presione el bot�n A
cargarvalor .10,tekl4pul5        ;Carga el valor de "10" en el registro de respuesta tekl4pul5
RETURN                                                  ;Sale de la subrutina de teclado

BoTt0NnB					;Subrutina para cuando se presione el bot�n B
cargarvalor .11,tekl4pul5        ;Carga el valor de "11" en el registro de respuesta tekl4pul5
RETURN                                                  ;Sale de la subrutina de teclado

BoTt0NnC					;Subrutina para cuando se presione el bot�n C
cargarvalor .12,tekl4pul5        ;Carga el valor de "12" en el registro de respuesta tekl4pul5
RETURN                                                  ;Sale de la subrutina de teclado

BoTt0NnD					;Subrutina para cuando se presione el bot�n D
cargarvalor .13,tekl4pul5        ;Carga el valor de "13" en el registro de respuesta tekl4pul5
RETURN                                                  ;Sale de la subrutina de teclado

BoTt0NnAST					;Subrutina para cuando se presione el bot�n *	
cargarvalor .14,tekl4pul5        ;Carga el valor de "14" en el registro de respuesta tekl4pul5
RETURN                                                  ;Sale de la subrutina de teclado

BoTt0NnMICH					;Subrutina para cuando se presione el bot�n #
cargarvalor .15,tekl4pul5        ;Carga el valor de "15" en el registro de respuesta tekl4pul5
RETURN                                                  ;Sale de la subrutina de teclado

; Revisa las �ltimas actualizaciones de la librer�a en:
;......................................................................... rodrigocarita.com ..................................................................................................

