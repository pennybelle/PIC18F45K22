#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/knight_rider/knight_rider.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdbool.h"



 typedef char _Bool;
#line 1 "c:/users/michelle/documents/github/pic18f45k22/knight_rider/display_utils.h"


unsigned short mask(unsigned short num);
#line 12 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/knight_rider/knight_rider.c"
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

char txt1[] = "Knight Rider";
char txt2[] = "Delay: 500ms";
char txt3[] = "Delay: 600ms";
char txt4[] = "Delay: 150ms";
char txt5[] = "Variable Delay";
char signature[] = "By Penny Belle";



int number = 1;


unsigned int delay_in_ms = 500;
unsigned int delay_taken = 0;
unsigned int iteration;
unsigned int max_iterations;

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

void bit_walk(int delay) {
 PORTC = number;
 vdelay_ms(delay);
 number *= 2;
}

void reverse_bit_walk(int delay) {
 PORTC = number;
 vdelay_ms(delay);
 number /= 2;
}

void knight_rider(int delay,  _Bool  is_variable) {
 iteration = 0;
 if (is_variable) {
 max_iterations = 10000;
 } else {
 max_iterations = 15;
 }


 while (iteration <= max_iterations) {

 while (number != 128) {
 if (is_variable && delay >= 20) {
 delay -= 20;
 }
 seven_seg_out();
 bit_walk(delay);
 iteration++;
 }


 while (number != 1) {
 if (is_variable && delay >= 20) {
 delay -= 20;
 }
 seven_seg_out();
 reverse_bit_walk(delay);
 iteration++;
 }
 }
}

void main() {
 lcd_display_prep();
 seven_seg_prep();
 lcd_display_out(txt1, signature);


 TRISC=0x00;
 PORTC=0b00000000;




 while (1) {

 knight_rider(1,  0 );
#line 182 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/knight_rider/knight_rider.c"
 }
}
