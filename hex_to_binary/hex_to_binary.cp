#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/hex_to_binary/hex_to_binary.c"
#line 1 "c:/users/michelle/documents/github/pic18f45k22/hex_to_binary/display_utils.h"


unsigned short mask(unsigned short num);
#line 11 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/hex_to_binary/hex_to_binary.c"
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

char txt1[] = "Show Binary Val";
char signature[] = "By Penny Belle";


int number;

int delay = 10000;

int dec1 = 255;
int dec2 = 129;
int dec3 = 170;
int dec4 = 55;
int dec5 = 85;

int bin1 = 0b10101010;
int bin2 = 0b01010101;
int bin3 = 0b11111111;
int bin4 = 0b11110000;
int bin5 = 0b00001111;

int hex1 = 0x55;
int hex2 = 0xAA;
int hex3 = 0xFE;
int hex4 = 0xAB;
int hex5 = 0x81;

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

void do_the_thing(int i) {
 number = i;
 PORTC = number;
 seven_seg_out();
 vdelay_ms(delay);
}

void main() {
 lcd_display_prep();
 seven_seg_prep();
 lcd_display_out(txt1, signature);

 TRISC = 0x00;
 PORTC = 0x00;

 while (1) {
 do_the_thing(dec1);
 do_the_thing(dec2);
 do_the_thing(dec3);
 do_the_thing(dec4);
 do_the_thing(dec5);

 do_the_thing(bin1);
 do_the_thing(bin2);
 do_the_thing(bin3);
 do_the_thing(bin4);
 do_the_thing(bin5);

 do_the_thing(hex1);
 do_the_thing(hex2);
 do_the_thing(hex3);
 do_the_thing(hex4);
 do_the_thing(hex5);
 }
}
