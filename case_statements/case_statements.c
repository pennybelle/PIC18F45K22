/* File Name: case_statements.c (LAB 13)
   Developed By: Penny Belle
   Submission To: AECT/AET Dept.
   Development Date: 2024-04-22
   Description: Control output with case statements.
/* ************************************************************************** */


/* ******************* BOILER PLATE ********************* */
// Lcd module prep
char i; // Loop variable
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
// End Lcd module prep


void lcd_display_prep() {
  ANSELB = 0;                        // Configure PORTB pins as digital
  Lcd_Init();                        // Initialize Lcd
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
}


void lcd_display_out(char first_line, char second_line) {
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Out(1,1,first_line);                 // Write text in first row

  Lcd_Out(2,1,second_line);                 // Write text in second row
}
/* ***************** END BOILER PLATE ******************** */


int j; // global counter


// func to handle repeating code that sets PORTC to a desired num
void first_thing(int hex_num, int timer) {
  PORTC = hex_num;
  vdelay_ms(timer);
}


// func to handle repeating code with PORTC patterns
void second_thing(int hex_num1, int hex_num2) {
  PORTC = hex_num1;
  delay_ms(1000);
  PORTC = hex_num2;
  delay_ms(1000);
}


// func to handle more repeat code that turns all of PORTC on and off
//void third_thing(int hex_num, int counter) {
//  for (i = 0; i < counter; i++) {
//    PORTC = hex_num;
//    delay_ms(500);
//    PORTC = 0x00;
//    delay_ms(500);
//  }
//}


void main() {
  lcd_display_prep();
  lcd_display_out(txt1, signature);

  // prep port D for input
  TRISD = 0xFF;
  ANSELD = 0x00;
  PORTD = 0x00;
  
  // prep port C for output
  TRISC = 0x00;
  PORTC = 0x00;
  
  while(1) {
    switch(PORTD) {
      case 1: // if PORTD switch is in position 0b00000001
        first_thing(0x55, 3000);
        break;

      case 2: // PORTD == 0b00000010
        first_thing(0xAA, 3000);
        break;
        
      case 4: // PORTD == 0b00000100
        first_thing(0xF0, 2000);
        break;
        
      case 8: // PORTD == 0b00001000
        second_thing(0xFF, 0x00);
        break;
        
      case 16: // PORTD == 0b00010000
        second_thing(0xAA, 0x55);
        break;

      case 32: // PORTD == 0b00100000
        second_thing(0xF0, 0x0F);
        break;

      case 64: // PORTD == 0b01000000
        PORTC = 0x81;
        delay_ms(3000);
        break;
        
      case 128: // PORTD == 0b10000000
        for (i = 0; i < 0xFF; i++) {
          PORTC = i;
          delay_ms(500);
        }
        break;

      default:
        PORTC = 0x00; // clear PORTC each loop
    }
  }
}