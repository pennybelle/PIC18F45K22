/* File Name: Project 02 C Language Structure
   Developed By: Penny Belle
   Submission To: AECT/AET Department
   Development Date: 09-15-2025
   Description: Turns PORTA, PORTB, PORTC, and PORTD LEDs ON/OFF
   SETUP NOTE: Turn ON the PORT LEDs using SW3, dip-switch 1, 2, 3, and 4     */
/* ************************************************************************** */

int i; // used in for loop

void main() {     // Main Function (program core)
  TRISC = 0x00;   // TRISC sets direction of data traffic on PORTC to Output
  PORTC = 0x00;   // Set PORTC logic to low
  TRISB = 0xFF;   // TRISB sets direction of data traffic on PORTB to Input
  ANSELB = 0x00;

  while(1) {
    // If Else Statements
//    if (PORTB == 0b00000001) {
//      PORTC = 0x55;
//      delay_ms(2000);
//    } else {
//      PORTC = 0xAA;
//      delay_ms(2000);
//    }

    // Relational Operators
//    if (PORTB == 0b00000001) {
//      PORTC = 0xFF;
//      delay_ms(500);
//      PORTC = 0x00;
//      delay_ms(500);
//    } else if (PORTB != 0b00000001) {
//      PORTC = 0xFF;
//      delay_ms(500);
//      PORTC = 0x00;
//      delay_ms(500);
//    } else if (PORTB > 0b00000001) {
//      PORTC = 0xFF;
//      delay_ms(500);
//      PORTC = 0x00;
//      delay_ms(500);
//    } else if (PORTB < 0b00000001) {
//      PORTC = 0xFF;
//      delay_ms(500);
//      PORTC = 0x00;
//      delay_ms(500);
//    }

    // For Loop (print and attach)
    for (i=1; i <= 255; i++) {
      PORTC = i;
      delay_ms(250);
    }

    for (i=255; i >= 1; i--) {
      PORTC = i;
      delay_ms(250);
    }

    // Bitwise Logic Functions
//    int var1 = 0b10101010;
//    int var2 = 0b01010101;
//    int var3 = 0x0F;
//
//    PORTC = var1 & var2;
//    delay_ms(1000);
//    PORTC = var1 | var2;
//    delay_ms(1000);
//    PORTC = var1 ^ var2;
//    delay_ms(1000);
//
//    PORTC = ~var3;
//    delay_ms(1000);
  }
}