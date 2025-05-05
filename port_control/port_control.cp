#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/port_control/port_control.c"
#line 11 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/port_control/port_control.c"
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
char txt1[] = "Port Control";
char txt2[] = "Logic HIGH";
char txt3[] = "Logic LOW";
char signature[] = "By Penny Belle";



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




int logic_state;
int e_state;

int numbers[10] = {
 0x55,
 0xAA,
 0xF0,
 0x0F,
 0xFF,
 0x00,
 0x33,
 0xCC,
 0x81,
 0x7E
};


void main() {
 lcd_display_prep();
 lcd_display_out(txt1, signature);


 TRISD = 0xFF;
 ANSELD = 0x00;
 PORTD = 0x00;


 TRISE = 0xFF;
 ANSELE = 0x00;
 PORTE = 0x00;


 TRISC = 0x00;
 PORTC = 0x00;


 while(1) {

 PORTD = 0x00;
 PORTC = 0x00;


 if (PORTE && e_state != PORTE) {
 ANSELD = 0x00;
 PORTD = 0xFF;
 logic_state = 0;
 lcd_display_out(txt1, txt2);
 e_state = PORTE;
 } else if (e_state != PORTE) {
 ANSELD = 0x00;
 PORTD = 0x00;
 logic_state = 1;
 lcd_display_out(txt1, txt3);
 e_state = PORTE;
 }

 if (RD0_bit == logic_state) {
 PORTC = numbers[0];
 delay_ms(3000);
 }

 if (RD1_bit == logic_state) {
 PORTC = numbers[1];
 delay_ms(2000);
 }

 if (RD2_bit == logic_state) {
 PORTC = numbers[2];
 delay_ms(1000);
 PORTC = numbers[3];
 delay_ms(1000);
 }

 if (RD3_bit == logic_state) {
 PORTC = numbers[4];
 delay_ms(500);

 for (i=0; i < 3; i++) {
 PORTC = numbers[5];
 delay_ms(500);
 }
 }

 if (RD4_bit == logic_state) {
 PORTC = numbers[1];
 delay_ms(250);
 PORTC = numbers[0];
 delay_ms(250);
 }

 if (RD5_bit == logic_state) {
 PORTC = numbers[6];
 delay_ms(1000);
 PORTC = numbers[7];
 delay_ms(1000);
 }

 if (RD6_bit == logic_state) {
 PORTC = numbers[8];
 delay_ms(750);
 PORTC = numbers[9];
 delay_ms(750);
 }

 if (RD7_bit == logic_state) {
 for (i=0; i < 10; i++) {
 PORTC = numbers[i];
 delay_ms(500);
 }
 }
 }
}
