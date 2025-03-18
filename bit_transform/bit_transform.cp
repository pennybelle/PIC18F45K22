#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/bit_transform/bit_transform.c"
#line 1 "c:/users/michelle/documents/github/pic18f45k22/bit_transform/display_utils.h"


unsigned short mask(unsigned short num);
#line 11 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/bit_transform/bit_transform.c"
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

char txt1[] = "Bit Walk";
char txt2[] = "Bit Climb";
char txt3[] = "Reverse Bit Walk";
char txt4[] = "Bit Walk Sped Up";
char empty_txt[] = "By Penny Belle";



int number = 1;


int new_delay = 500;
int iteration_count = 1000;

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

void lcd_display_prep() {
 ANSELB = 0;
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
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

void lcd_display_out(char first_line, char second_line) {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,first_line);

 Lcd_Out(2,1,second_line);
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

void bit_walk(int delay_time) {
 PORTC = number;
 vdelay_ms(delay_time);
 number *= 2;



}

void reverse_bit_walk(int delay_time) {

 PORTC = number;
 vdelay_ms(delay_time);
 number /= 2;



}

void bit_climb(int delay_time) {

 PORTC = number;
 vdelay_ms(delay_time);
 number += 1;



}

void reset_prog() {
 number = 1;
 delay_ms(2000);
}

void number_check(int n) {
 if ( number != n ) {
 number = n;
 }
}

int main() {
 lcd_display_prep();
 seven_seg_prep();
 bit_walk_prep();

 while(1){

 number_check(1);
 lcd_display_out(txt1, empty_txt);
 while(number <= 128) {
 seven_seg_out();
 bit_walk(750);
 }
 delay_ms(2000);


 number_check(128);
 lcd_display_out(txt3, empty_txt);
 while(number >= 1) {
 seven_seg_out();
 reverse_bit_walk(750);
 }
 reset_prog();


 lcd_display_out(txt4, empty_txt);
 while (iteration_count > 0) {
 number_check(1);
 while(number <= 128) {
 seven_seg_out();
 bit_walk(new_delay);
 }





 if (new_delay >= 100) {
 new_delay = new_delay - 100;
 } else if (new_delay < 100) {
 new_delay = 0;
 }
 iteration_count--;
 }
 new_delay = 500;
 iteration_count = 1000;
 reset_prog();


 number_check(1);
 lcd_display_out(txt2, empty_txt);
 while (number < 256 ) {
 bit_climb(50);
 seven_seg_out();
 }
 reset_prog();
 }
 return 0;
}
