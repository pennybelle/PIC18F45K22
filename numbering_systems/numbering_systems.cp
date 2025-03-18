#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/numbering_systems/numbering_systems.c"
#line 1 "c:/users/michelle/documents/github/pic18f45k22/numbering_systems/display_utils.h"


unsigned short mask(unsigned short num);
#line 11 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/numbering_systems/numbering_systems.c"
unsigned short shifter, portd_index;
unsigned int digit;
unsigned short portd_array[4];


sbit LCD_RS at LATB4_bit;
sbit LCD_EN at LATB5_bit;
sbit LCD_D4 at LATB0_bit;
sbit LCD_D5 at LATB1_bit;
sbit LCD_D6 at LATB2_bit;
sbit LCD_D7 at LATB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;

char i;

char txt1[] = "C Number Systems";
char signature[] = "By Penny Belle";



int number;


int delay_in_ms = 500;

void interrupt() {
 LATA = 0;
 LATD = portd_array[portd_index];
 LATA = shifter;


 shifter <<= 1;
 if (shifter > 8u)
 shifter = 1;


 portd_index++ ;
 if (portd_index > 3u)
 portd_index = 0;
 TMR0L = 0;
 TMR0IF_bit = 0;
}

void seven_seg_prep() {
 ANSELA = 0;
 ANSELD = 0;

 TRISA = 0;
 LATA = 0;
 TRISD = 0;
 LATD = 0;

 T0CON = 0xC4;
 TMR0L = 0;
 digit = 0;
 portd_index = 0;
 shifter = 1;

 GIE_bit = 1;
 TMR0IE_bit = 1;
}

void bit_walk_prep() {
 TRISC = 0x00;
}

void seven_seg_out() {
 digit = number / 1000u ;
 portd_array[3] = mask(digit);
 digit = (number / 100u) % 10u;
 portd_array[2] = mask(digit);
 digit = (number / 10u) % 10u;
 portd_array[1] = mask(digit);
 digit = number % 10u;
 portd_array[0] = mask(digit);
}

void lcd_display_prep() {
 ANSELB = 0;
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
}

void lcd_display_out(char first_line, char second_line) {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,first_line);

 Lcd_Out(2,1,second_line);
}

void main() {
 lcd_display_prep();
 seven_seg_prep();
 lcd_display_out(txt1, signature);

 TRISC=0b00000000;
 TRISC=0x00;
 PORTC=0b00000000;

 while (1) {
 number = 0b00001111;
 seven_seg_out();
 PORTC = number;
 vdelay_ms(delay_in_ms);

 number = 0b11110000;
 seven_seg_out();
 PORTC = number;
 vdelay_ms(delay_in_ms);
 }
}
