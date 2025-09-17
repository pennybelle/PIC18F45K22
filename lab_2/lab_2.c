/* File Name: Project 02 C Language Structure
   Developed By: Penny Belle
   Submission To: AECT/AET Department
   Development Date: 09-03-2025
   Description: Turns PORTA, PORTB, PORTC, and PORTD LEDs ON/OFF
   SETUP NOTE: Turn ON the PORT LEDs using SW3, dip-switch 1, 2, 3, and 4     */
/* ************************************************************************** */

void main() {    // Main Function (program core)
  TRISC = 0x00;  // TRISC sets direction of data traffic on PORTC to Output
  TRISB = 0xFF;  // TRISD sets direction of data traffic on PORTD to Input
  PORTC = 0x00;  // Set PORTC logic to low
  
  // initialize variables with data
  int bin1 = 0b10101010;
  int hex1 = 0x55;
  int dec1 = 55;
  int oct1 = 0252;

  // loop forever
  while(1) {
    // if port b lsb (only) is on, flip between odd and even bit outputs
    if (PORTB == 0b00000001) {
      PORTC = 0xAA;
      delay_ms(1000);
      PORTC = 0x55;
      delay_ms(1000)
    }
  }
}