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
#include <stdio.h>
#include <string.h>

#include "lcd.h" // libreria para la pantalla LCD
#include "kbd4x3.h" // libreria para teclado matricial 4x4

#define LED_ROJO PORTCbits.RC0 // led de acceso incorrecto
#define LED_VERDE PORTCbits.RC1 // led de acceso correcto
#define BUZZER PORTCbits.RC2 // buzzer

char tecla;                  // Almacena el valor de la tecla presionada
char clave[5];               // Almacena la clave ingresada por el usuario
char clave_enter[5] = "0626"; // Clave para acceder

void main(void) {
    ADCON1bits.PCFG = 0x0F; // coloca todos los pines como digitales
    TRISC = 0x00; // PUERTO C como salida (leds y buzzer)
    LED_VERDE = 0; // led verde inicialmente apagado
    LED_ROJO = 0; // led rojo inicalmente apagado
    BUZZER = 0; // buzzer incialmente apagado
    Keypad_Init();   // Inicializa el teclado matricial 4x4
    Lcd_Init();      // Inicializa la pantalla lcd
    
    while (1) {
        int i = 0;   // Contador para las veces que se pulsa alguna tecla
        Lcd_Set_Cursor(1,2);
        Lcd_Write_String("INGRESAR PIN"); // Mensaje de solicitud para ingresar clave
        
        while(i < 4)
        {
            tecla = Keypad_Get_Char(); // Lee el dato de la tecla presionada
            if(tecla != 0)  // Verifica si se ha presionado alguna tecla
            {
                clave[i] = tecla;   // Almacena cada tecla presionada en el arreglo
                Lcd_Set_Cursor(2,2+i);
                Lcd_Write_Char(tecla); // Muestra la tecla presionada. Puede ser reemplazado por * (para ocultarla)
                i++;  // Incrementa el contador
            }
        }
        __delay_ms(200);
        Lcd_Clear();   // Limpia la pantalla lcd
        
        if(!strcmp(clave, clave_enter)) // Compara si la clave es la correcta
        {
            LED_VERDE = 1; // enciende el led verde
            LED_ROJO = 0; // apaga el led rojo
            BUZZER = 1; //  enciende el buzzer
            Lcd_Set_Cursor(1,2);
            Lcd_Write_String("INSTRUMENT C.A");
            Lcd_Set_Cursor(2,2);
            Lcd_Write_String("PIN CORRECT0");
            __delay_ms(2000);
        }
        else   // Sino es la clave correcta, no permite el acceso
        {
            LED_ROJO = 1;
            LED_VERDE = 0;
            BUZZER = 1;
            Lcd_Set_Cursor(2,2);
            Lcd_Write_String("PIN INCORRECTO");
            __delay_ms(400);
            BUZZER = 0;
            __delay_ms(400);
            BUZZER = 1;
            __delay_ms(400);
            BUZZER = 0;
            __delay_ms(400);
            BUZZER = 1;
            __delay_ms(400);
            BUZZER = 0;
        }
        i = 0;         // Reinicia el contador
        LED_ROJO = 0;  // Apagar led rojo
        LED_VERDE = 0; // apagar led verde
        BUZZER = 0; // apaga buzzer
        Lcd_Clear();  // Limpia la pantalla lcd
    }
}
