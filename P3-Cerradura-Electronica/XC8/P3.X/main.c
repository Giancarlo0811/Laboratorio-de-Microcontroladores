// PIC16F877A Configuration Bit Settings

// CONFIG
#pragma config FOSC = HS        
#pragma config WDTE = OFF       
#pragma config PWRTE = ON       
#pragma config BOREN = OFF      
#pragma config LVP = OFF        
#pragma config CPD = OFF        
#pragma config WRT = OFF       
#pragma config CP = OFF         

#define _XTAL_FREQ 20000000
#include <xc.h>
#include <string.h>

#include "kbd4x3.h" // libreria para keypad

#define led_rojo PORTCbits.RC0 // led de acceso incorrecto
#define led_verde PORTCbits.RC1 // led de acceso correcto
#define buzzer PORTCbits.RC2 // buzzer

// display de 7 segmentos catodo comun
unsigned char display[13] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F,0x49,0x76,0x40};

char tecla; // almacena el valor de la tecla presionada
char claveIntroducida[5]; // almacena la clave ingresada por el usuario
char clave[5] = "0626"; // clave para acceder: ultimos 4 digitos carnet USB

void main(void) {
    ADCON1bits.PCFG = 0x0F; // coloca todos los pines como digitales
    TRISD = 0x00;
    TRISC = 0x00;
    led_rojo = 0;
    led_verde = 0;
    buzzer = 0;
    PORTD = display[12];
    Keypad_Init();
    
    while (1) {
        int i = 0; // contador para las veces que se presiona una tecla
        
        while(i < 4) {
            tecla = Keypad_Get_Char(); // lee el dato de la tecla presionada
            if (tecla !=0) { // verifica si se presiona una tecla
                claveIntroducida[i] = tecla; // almacena cada tecla
                switch(tecla) { // muestra el numero en el display segun la tecla presionada
                    case '0':
                        PORTD = display[0];
                        break;
                    case '1':
                        PORTD = display[1];
                        break;
                    case '2':
                        PORTD = display[2];
                        break;
                    case '3':
                        PORTD = display[3];
                        break;
                    case '4':
                        PORTD = display[4];
                        break;
                    case '5':
                        PORTD = display[5];
                        break;
                    case '6':
                        PORTD = display[6];
                        break;
                    case '7':
                        PORTD = display[7];
                        break;
                    case '8':
                        PORTD = display[8];
                        break;
                    case '9':
                        PORTD = display[9];
                        break;
                    case '*':
                        PORTD = display[10];
                        break;
                    case '#':
                        PORTD = display[11];
                        break;
                }
                i++;
            }
        }
        __delay_ms(400);
        PORTD = display[12]; // limpiar display
        
        if (!strcmp(claveIntroducida, clave)) { // comprueba si la clave es correcta
            led_verde = 1;
            buzzer = 1;
            led_rojo = 0;
            __delay_ms(2000);
        }
        else {
            led_rojo = 1;
            buzzer = 1;
            led_verde = 0;
            __delay_ms(400);
            buzzer = 0;
            __delay_ms(400);
            buzzer = 1;
            __delay_ms(400);
            buzzer = 0;
            __delay_ms(400);
            buzzer = 1;
            __delay_ms(400);
            buzzer = 0;
        }
        i = 0; // reinicia el contador
        led_rojo = 0;
        led_verde = 0;
        buzzer = 0;
        PORTD = display[12]; // limpiar display
    }
}
