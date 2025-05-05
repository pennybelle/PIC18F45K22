#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/if_else/if_else.c"
#line 11 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/if_else/if_else.c"
char i;
char txt1[] = "Conditionals";
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



void do_the_thing() {
 PORTC = 0xFF;
 delay_ms(500);
 PORTC = 0x00;
 delay_ms(500);
}


int global_var = 0x0F;


void main() {
 lcd_display_prep();
 lcd_display_out(txt1, signature);


 TRISE = 0xFF;
 ANSELE = 0x00;


 TRISD = 0xFF;
 ANSELD = 0x00;


 TRISC = 0x00;

 while(1) {
 PORTC = 0x00;
 PORTD = 0x00;
 PORTE = 0x00;

 if (PORTE == 0b00000001 && PORTD == global_var) {
 do_the_thing();
 } else if (PORTE == 0b00000010 && PORTD != global_var) {
 do_the_thing();
 } else if (PORTE == 0b00000100 && PORTD > global_var) {
 do_the_thing();
 } else if (PORTE == 0b00001000 && PORTD < global_var) {
 do_the_thing();
 } else if (PORTE == 0b00010000 && PORTD >= global_var) {
 do_the_thing();
 } else if (PORTE == 0b00100000 && PORTD <= global_var) {
 do_the_thing();
 } else {
 PORTC = 0xFF;
 delay_ms(3000);
 }
 }
}
