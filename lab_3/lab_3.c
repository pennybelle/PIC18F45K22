/* File Name: Project 03 Functions / Port Control
   Developed By: Penny Belle
   Submission To: AECT/AET Department
   Development Date: 09-15-2025
   Description: Program uses Functions to demonstrate control over ports      */
/* ************************************************************************** */

// Function to clear all ports and set to output
void SetupClearPorts() {
  TRISB = 0x00;
  TRISC = 0x00;
  TRISD = 0x00;
  PORTB = 0x00;
  PORTC = 0x00;
  PORTD = 0x00;
}

// Flash PORTB on and off (1s delay)
void option1() {
  PORTB = 0xFF;
  delay_ms(1000);
  PORTB = 0x00;
  delay_ms(1000);
}

// Flash PORTC on and off (1s delay)
void option2() {
  PORTC = 0xFF;
  delay_ms(1000);
  PORTC = 0x00;
  delay_ms(1000);
}

// Flash PORTD on and off (1s delay)
void option3() {
  PORTD = 0xFF;
  delay_ms(1000);
  PORTD = 0x00;
  delay_ms(1000);
}

// Flash PORTB evens (1s delay)
void option4() {
  PORTB = 0x55;
  delay_ms(1000);
  PORTB = 0x00;
  delay_ms(1000);
}

// Flash PORTC odds (1s delay)
void option5() {
  PORTC = 0xAA;
  delay_ms(1000);
  PORTC = 0x00;
  delay_ms(1000);
}

// Flash PORTD evens and odds (1s delay)
void option6() {
  PORTD = 0x55;
  delay_ms(1000);
  PORTD = 0xAA;
  delay_ms(1000);
  PORTD = 0x00;
}

void main() {     // Main Function (program core)
  // loop forever
  while(1) {
    // run functions
    SetupClearPorts();
    option6();
    option5();
    option4();
    option3();
    option2();
    option1();
  }
}