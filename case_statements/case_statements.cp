#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/case_statements/case_statements.c"
#line 11 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/case_statements/case_statements.c"
char i;
char txt1[] = "Case Statements";
char signature[] = "By Penny Belle";

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



int j;



void first_thing(int hex_num, int timer) {
 PORTC = hex_num;
 vdelay_ms(timer);
}



void second_thing(int hex_num1, int hex_num2) {
 PORTC = hex_num1;
 delay_ms(1000);
 PORTC = hex_num2;
 delay_ms(1000);
}
#line 78 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/case_statements/case_statements.c"
void main() {
 lcd_display_prep();
 lcd_display_out(txt1, signature);


 TRISD = 0xFF;
 ANSELD = 0x00;
 PORTD = 0x00;


 TRISC = 0x00;
 PORTC = 0x00;

 while(1) {
 switch(PORTD) {
 case 1:
 first_thing(0x55, 3000);
 break;

 case 2:
 first_thing(0xAA, 3000);
 break;

 case 4:
 first_thing(0xF0, 2000);
 break;

 case 8:
 second_thing(0xFF, 0x00);
 break;

 case 16:
 second_thing(0xAA, 0x55);
 break;

 case 32:
 second_thing(0xF0, 0x0F);
 break;

 case 64:
 PORTC = 0x81;
 delay_ms(3000);
 break;

 case 128:
 for (i = 0; i < 0xFF; i++) {
 PORTC = i;
 delay_ms(500);
 }
 break;

 default:
 PORTC = 0x00;
 }
 }
}
