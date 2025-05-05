#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/rgb_led/rgb_led.c"
#line 9 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/rgb_led/rgb_led.c"
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
char txt1[] = "RGB LED Input";
char txt2[] = "RGB LED Pattern";
char signature[] = "By Penny Belle";



int RED = 0b00000001;
int GREEN = 0b00000010;
int BLUE = 0b00000100;
int MAGENTA = 0b00000101;
int YELLOW = 0b00000110;
int CYAN = 0b00000011;
int WHITE = 0b00000111;


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


void output_to_rgb() {
 if (PORTD == RED) {
 PORTC = RED;
 } else if (PORTD == GREEN) {
 PORTC = GREEN;
 } else if (PORTD == BLUE) {
 PORTC = BLUE;
 } else {
 PORTC = 0x00;
 }
 delay_ms(20);
}


void color_cycle(int delay) {
 PORTC = RED;
 vdelay_ms(delay);
 PORTC = GREEN;
 vdelay_ms(delay);
 PORTC = BLUE;
 vdelay_ms(delay);
}


void main() {
 lcd_display_prep();
 lcd_display_out(txt1, signature);

 TRISE = 0xFF;
 ANSELE = 0x00;

 TRISD = 0xFF;
 ANSELD = 0x00;

 TRISC = 0x00;
 PORTC = 0x00;

 while(1) {
 if (PORTE == 0b00000001) {
 color_cycle(1000);
 } else if (PORTE == 0b00000010) {
 color_cycle(50);
 } else {
 PORTC = PORTD;

 if (PORTC == PORTD && PORTC != 0x00) {
 delay_ms(20);
 }
 }
 }
}
