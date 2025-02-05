/* File Name: binary_step.c
   Developed By: Penny Belle
   Submission To: AECT/AET Dept.
   Development Date: 2024-02-05
   Description: Show decimal value on seven seg display & binary value on LEDs
/* ************************************************************************** */

#include "Display_Utils.h"

unsigned short shifter, portd_index;
unsigned int digit;
unsigned short portd_array[4];

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

void bit_walk(int delay_time) {
  // when bit reaches 0b11111111, reset to 0b00000001
  PORTC = number; // set PORTA to number, initually 1 or 0b00000001
  vdelay_ms(delay_time);
  number += 1; // add 1 to decimal value to get next binary value
  if (number > 256) {
    number = 1;
  }
}

int main() {
  seven_seg_prep();
  bit_walk_prep();

  while(1) {
    bit_walk(250); // parameter is delay in milliseconds
    seven_seg_out();
  }

  return 0;
}