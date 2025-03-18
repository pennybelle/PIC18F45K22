/* File Name: numbering_systems.c
   Developed By: Penny Belle
   Submission To: AECT/AET Dept.
   Development Date: 2024-03-18
   Description: Use different numbering systems in C to manipulate bits on PORTC
/* ************************************************************************** */

#include "Display_Utils.h"

// Seven Segment Display prep
unsigned short shifter, portd_index;
unsigned int digit;
unsigned short portd_array[4];

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

char i;                              // Loop variable

char txt1[] = "C Number Systems";
char signature[] = "By Penny Belle";
// End Lcd module prep

// init value used for converting to string
int number;

// global delay in milliseconds
int delay_in_ms = 500;

void interrupt() {
  LATA = 0;                             // Turn off all 7seg displays
  LATD = portd_array[portd_index];      // bring appropriate value to PORTD
  LATA = shifter;                       // turn on appropriate 7seg. display

  // move shifter to next digit
  shifter <<= 1;
  if (shifter > 8u)
    shifter = 1;

  // increment portd_index
  portd_index++ ;
  if (portd_index > 3u)
    portd_index = 0;             // turn on 1st, turn off 2nd 7seg.
  TMR0L  =   0;                  // reset TIMER0 value
  TMR0IF_bit = 0;                // Clear TMR0IF
}

void seven_seg_prep() {
  ANSELA = 0;                    // Configure PORTA pins as digital
  ANSELD = 0;                    // Configure PORTD pins as digital

  TRISA = 0;                     // Configure PORTA as output
  LATA  = 0;                     // Clear PORTA
  TRISD = 0;                     // Configure PORTD as output
  LATD  = 0;                     // Clear PORTD

  T0CON = 0xC4;                  // Set TMR0 in 8bit mode, assign prescaler to TMR0
  TMR0L = 0;                     // clear TMROL
  digit = 0;
  portd_index = 0;
  shifter = 1;

  GIE_bit = 1;
  TMR0IE_bit = 1;
}

void bit_walk_prep() {
  TRISC = 0x00; // set direction of data traffic to output
}

void seven_seg_out() {
  digit = number / 1000u ;             // extract thousands digit
  portd_array[3] = mask(digit);        // and store it to PORTD array
  digit = (number / 100u) % 10u;       // extract hundreds digit
  portd_array[2] = mask(digit);        // and store it to PORTD array
  digit = (number / 10u) % 10u;        // extract tens digit
  portd_array[1] = mask(digit);        // and store it to PORTD array
  digit = number % 10u;                // extract ones digit
  portd_array[0] = mask(digit);        // and store it to PORTD array
}

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

void main() {
  lcd_display_prep();
  seven_seg_prep();
  lcd_display_out(txt1, signature);

  TRISC=0b00000000; // set port C as output for all bits
  TRISC=0x00;       // same as above but with hex instead of binary
  PORTC=0b00000000; // clear port C (set all to logic low or 0 volts)
  
  while (1) {
    number = 0b00001111;
    seven_seg_out();
    PORTC = number;
    vdelay_ms(delay_in_ms);

    number = 0b11110000;
    seven_seg_out();
    PORTC = number;
    vdelay_ms(delay_in_ms);
  }
}