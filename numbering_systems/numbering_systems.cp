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
char txt2[] = "Using: Binary";
char txt3[] = "Using: Octal";
char txt4[] = "Using: Hex";
char txt5[] = "Using: Decimal";
char txt6[] = "Binary Display";
char txt7[] = "Delay: 10sec";
char signature[] = "By Penny Belle";



int number = 0;


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

void do_the_thing(int i) {
 number = i;
 seven_seg_out();
 PORTC = number;
 vdelay_ms(delay_in_ms);
}

void procedure_loop(int number_1, int number_2) {
 for (i = 0; i < 5; i++) {
 do_the_thing(number_1);
 do_the_thing(number_2);
 }
 delay_ms(1500);
 LATD = 0;
}

display_bits(int i) {
 number = i;
 seven_seg_out();
 PORTC = number;
 delay_ms(10000);
}

void main() {
 lcd_display_prep();
 lcd_display_out(txt1, signature);
 seven_seg_prep();
 seven_seg_out();

 TRISC=0x00;
 PORTC=0x00;


 delay_ms(3000);

 while (1) {

 lcd_display_out(txt1, txt2);
 procedure_loop(0b00001111, 0b11110000);


 lcd_display_out(txt1, txt2);
 procedure_loop(0b01010101, 0b10101010);


 lcd_display_out(txt1, txt3);
 procedure_loop(0125, 0252);


 lcd_display_out(txt1, txt4);
 procedure_loop(0x55, 0xAA);


 lcd_display_out(txt1, txt5);
 procedure_loop(85, 170);

 lcd_display_out(txt6, txt7);
 display_bits(0xA5);
 display_bits(186);
 display_bits(055);
 display_bits(0xF3);
 display_bits(28);
 display_bits(0212);
 display_bits(255);
 display_bits(0252);
 display_bits(0xF1);
 }
}
