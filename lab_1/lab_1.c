/* File Name: Project 01 Microcontroller Port Testing
   Developed By: Penny Belle
   Submission To: AECT/AET Department
   Development Date: 09-03-2025
   Description: Turns PORTA, PORTB, PORTC, and PORTD LEDs ON/OFF
   SETUP NOTE: Turn ON the PORT LEDs using SW3, dip-switch 1, 2, 3, and 4     */
/* ************************************************************************** */

void knight_rider() {
  int number = 1;  // bit used to walk via knight_rider()
  PORTD = ~0x00;  // refresh portd (uses compliment of 0 for anode LEDs)

  // walk bit forward until it reachest 128 (msb)
  while (number <= 128) {  // once bit reaches 256 it leaves the loop
    PORTC = number;  // set portc to value of bit
    delay_ms(1000);  // delay 250ms
    number *= 2;  // multiply bit by 2 to walk bit forward across LEDs
  }

  number = 1;  // bring back bit to 1
  PORTC = 0x00;  // refresh portc
  
  // walk bit forward until it reachest 128 (msb)
  while (number <= 128) {  // once bit reaches 256 it leaves the loop
    PORTD = ~number;  // set portd to value of bit
    delay_ms(1000);  // delay 250ms
    number *= 2;  // multiply bit by 2 to walk bit forward across LEDs
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