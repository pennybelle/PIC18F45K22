/* File Name: Project 01 Microcontroller Port Testing
   Developed By: Penny Belle
   Submission To: AECT/AET Department
   Development Date: 09-03-2025
   Description: Turns PORTA, PORTB, PORTC, and PORTD LEDs ON/OFF
   SETUP NOTE: Turn ON the PORT LEDs using SW3, dip-switch 1, 2, 3, and 4     */
/* ************************************************************************** */

int number = 1;  // bit used to walk via knight_rider()

void knight_rider() {
  PORTD = ~0x00;  // refresh portd (uses compliment of 0 for anode LEDs)

  // walk bit forward until it reachest 128 (msb)
  while (number <= 128) {  // once bit reaches 256 it leaves the loop
    PORTC = number;  // set portc to value of bit
    delay_ms(250);  // delay 250ms
    number *= 2;  // multiply bit by 2 to walk bit forward across LEDs
  }

  number /= 2;  // bring back bit from 256 to 128

  PORTC = 0x00;  // refresh portc

  // walk bit backward until it reachest 1 (lsb)
  while (number >= 1) {
    PORTD = ~number;  // set portd to compliment of bit value (anode LEDs)
    delay_ms(250);  // delay 250ms
    if (number == 1) {  // guard clause to catch when bit reaches 1
      break;  // if bit == 1, leave while loop
    } else {
      number /= 2;  // if bit != 1, divide bit by 2 to walk bit backwards
    }
  }
}


void main() {    // Main Function (program core)
  TRISA = 0x00;  // TRISA sets direction of data traffic on PORTA to Output
  TRISB = 0x00;  // TRISB sets direction of data traffic on PORTB to Output
  TRISC = 0x00;  // TRISC sets direction of data traffic on PORTC to Output
  TRISD = 0x00;  // TRISD sets direction of data traffic on PORTD to Output
  
  while(1) {
    knight_rider();
  }
}