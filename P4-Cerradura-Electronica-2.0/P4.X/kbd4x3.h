
#include <xc.h>
#define _XTAL_FREQ 20000000

#define R1_PIN PORTDbits.RD4
#define R2_PIN PORTDbits.RD5
#define R3_PIN PORTDbits.RD6
#define R4_PIN PORTDbits.RD7
#define C1_PIN PORTDbits.RD0
#define C2_PIN PORTDbits.RD1
#define C3_PIN PORTDbits.RD2

#define R1_DIR TRISDbits.TRISD4
#define R2_DIR TRISDbits.TRISD5
#define R3_DIR TRISDbits.TRISD6
#define R4_DIR TRISDbits.TRISD7
#define C1_DIR TRISDbits.TRISD0
#define C2_DIR TRISDbits.TRISD1
#define C3_DIR TRISDbits.TRISD2

void Keypad_Init(void);
char Keypad_Get_Char(void);