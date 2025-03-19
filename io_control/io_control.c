/* File Name: io_control.c
   Developed By: Penny Belle
   Submission To: AECT/AET Dept.
   Development Date: 2024-03-18
   Description: Control outputs with inputs (dip switches)
/* ************************************************************************** */

//#include "Display_Utils.h"

//// Seven Segment Display prep
//unsigned short shifter, portd_index;
//unsigned int digit;
//unsigned short portd_array[4];

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

char txt1[] = "IO Control";
char txt2[] = "Not Inverted";
char txt3[] = "Inverted";
char txt4[] = "Special Output!";
char signature[] = "By Penny Belle";
// End Lcd module prep

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

void lcd_update(char i) {
  if (i != input) {
    input = i;
    lcd_display_out(txt1, i);
  }
}

void main() {
  lcd_display_prep();
  lcd_display_out(txt1, signature);

  TRISE = 0xFF; // set port E as input (im using this to toggle bit inversion)
  TRISD = 0xFF; // set port D as input (this is the input data that gets output)
  TRISC = 0x00; // set port C as output
  PORTC = 0x00; // set all bits in port C to 0
  ANSELD = 0x00; // turn off ADC latches to accept TTL inputs
  ANSELE = 0x00;

  delay_ms(3000); // wait for plug

  while (1) {
  PORTC = 0x00;

    // i get that using conditionals and binary values is meant to
    // teach me how to use them but i already know how so i refactored
    // the logic a bit because it doesn't need to be anything more than:
    if (PORTE) {
      if (PORTD == 0b00000101) {
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