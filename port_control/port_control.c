/* File Name: port_control.c (LAB 10)
   Developed By: Penny Belle
   Submission To: AECT/AET Dept.
   Development Date: 2024-04-08
   Description: Use key switches to drive port logic output.
/* ************************************************************************** */


/* ******************* BOILER PLATE ********************* */
// Lcd module prep
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

char i; // Loop variable
char txt1[] = "Port Control";
char txt2[] = "Logic HIGH";
char txt3[] = "Logic LOW";
char signature[] = "By Penny Belle";
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


// global vars
int logic_state; // keep track of logic high or low
int e_state; // keep track of PORTE state for lcd out

int numbers[10] = {
  0x55, // NUM1
  0xAA, // NUM2
  0xF0, // NUM3
  0x0F, // NUM4
  0xFF, // NUM5
  0x00, // NUM6
  0x33, // NUM7
  0xCC, // NUM8
  0x81, // NUM9
  0x7E // NUM10
};


void main() {
  lcd_display_prep();
  lcd_display_out(txt1, signature);

  // prep port D for input
  TRISD = 0xFF;
  ANSELD = 0x00;
  PORTD = 0x00;

  // prep port E for input
  TRISE = 0xFF;
  ANSELE = 0x00;
  PORTE = 0x00;
  
  // prep port C for output
  TRISC = 0x00;
  PORTC = 0x00;
  
  // loop forever
  while(1) {
    // clear each port at start of loop
    PORTD = 0x00;
    PORTC = 0x00;

    // check for logic_state from port E
    if (PORTE && e_state != PORTE) { // turn on port E to enable logic High
      ANSELD = 0x00;
      PORTD = 0xFF;
      logic_state = 0;
      lcd_display_out(txt1, txt2);
      e_state = PORTE;
    } else if (e_state != PORTE) { // turn off port E to enable logic Low
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
      // repeat the following block 3 times
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