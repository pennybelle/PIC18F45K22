#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/io_control/io_control.c"
#line 16 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/io_control/io_control.c"
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

char txt1[] = "IO Control";
char txt2[] = "Not Inverted";
char txt3[] = "Inverted";
char txt4[] = "Special Output!";
char signature[] = "By Penny Belle";


char input;

int output;

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

void lcd_update(char i) {
 if (i != input) {
 input = i;
 lcd_display_out(txt1, i);
 }
}

void main() {
 lcd_display_prep();
 lcd_display_out(txt1, signature);

 TRISE = 0xFF;
 TRISD = 0xFF;
 TRISC = 0x00;
 PORTC = 0x00;
 ANSELD = 0x00;
 ANSELE = 0x00;

 delay_ms(3000);

 while (1) {
 PORTC = 0x00;




 if (PORTE) {
 if (PORTD == 0b00000001) {
 lcd_update(txt4);
 PORTC = 0xFF;
 delay_ms(500);
 PORTC = 0x00;
 delay_ms(500);
 } else {
 lcd_update(txt2);
 PORTC = PORTD;
 }
 } else {
 lcd_update(txt3);
 PORTC = ~PORTD;
 }
 }
}
