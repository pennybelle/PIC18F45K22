/* File Name: bit_transform.c
   Developed By: Penny Belle
   Submission To: AECT/AET Dept.
   Development Date: 2024-02-05
   Description: Show decimal value on seven seg display & binary value on LEDs
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

char txt1[] = "Bit Walk";
char txt2[] = "Bit Climb";
char txt3[] = "Reverse Bit Walk";
char empty_txt[] = "By Penny Belle";
// End Lcd module prep

// decimal value used in incrementing bit_walk()
int number = 1;

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

void lcd_display_prep() {
  ANSELB = 0;                        // Configure PORTB pins as digital
  Lcd_Init();                        // Initialize Lcd
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
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

void lcd_display_out(char first_line, char second_line) {
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Out(1,1,first_line);                 // Write text in first row

  Lcd_Out(2,1,second_line);                 // Write text in second row
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

void bit_walk(int delay_time) {
  PORTC = number; // set PORTA to number, initually 1 or 0b00000001
  vdelay_ms(delay_time);
  number *= 2; // multiply decimal by 2 to move bit left one character
//  if (number > 128) {
//    number = 1;
//  }
}

void reverse_bit_walk(int delay_time) {
  // when bit reaches 0b11111111, reset to 0b00000001
  PORTC = number; // set PORTA to number, initually 1 or 0b00000001
  vdelay_ms(delay_time);
  number /= 2; // multiply decimal by 2 to move bit left one character
//  if (number > 128) {
//    number = 1;
//  }
}

void bit_climb(int delay_time) {
  // when bit reaches 0b11111111, reset to 0b00000001
  PORTC = number; // set PORTA to number, initually 1 or 0b00000001
  vdelay_ms(delay_time);
  number += 1; // add 1 to decimal value to show binary value climb
//  if (number > 256) {
//    number = 1;
//  }
}

void reset_prog() {
  number = 1;
  delay_ms(2000);
}

void number_check(int n) {
  if ( number != n ) {
    number = n;
  }
}

int main() {
  lcd_display_prep();
  seven_seg_prep();
  bit_walk_prep();
  
  while(1){
    // Bit Walk
    number_check(1);
    lcd_display_out(txt1, empty_txt);
    while(number <= 128) {
      seven_seg_out();
      bit_walk(750); // parameter is delay in milliseconds
    }
    delay_ms(2000); // dont reset to 1, instead walk bit back
    
    // Reverse Bit Walk
    number_check(128);
    lcd_display_out(txt3, empty_txt);
    while(number >= 1) {
      seven_seg_out();
      reverse_bit_walk(750);
    }
    reset_prog();

    // Bit Climb
    number_check(1);
    lcd_display_out(txt2, empty_txt);
    while (number < 256 ) {
      bit_climb(50); // parameter is delay in milliseconds
      seven_seg_out();
    }
    reset_prog();
  }
  return 0;
}