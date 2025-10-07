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


// Walk bit on PORTC from lsb to msb
void walkPORTC1() {
  int i;  // iterator var
  for(i=1; i<=128; i*=2) {
    PORTC = i;  // set PORTC to value of iterator var
    delay_ms(250);
  }
}


// Walk bit on PORTC from msb to lsb
void walkPORTC2() {
  int i;  // iterator var
  for(i=128; i>=1; i/=2) {
    PORTC = i;  // set PORTC to value of iterator var
    delay_ms(250);
  }
}


// Walk bit on PORTC from lsb to msb
void walkPORTD1() {
  int i;  // iterator var
  for(i=1; i<=128; i*=2) {
    PORTD = i;  // set PORTC to value of iterator var
    delay_ms(250);
  }
}


// Walk bit on PORTC from msb to lsb
void walkPORTD2() {
  int i;  // iterator var
  for(i=128; i>=1; i/=2) {
    PORTD = i;  // set PORTC to value of iterator var
    delay_ms(250);
  }
}


void main() {     // Main Function (program core)
  // loop forever
  while(1) {
    // run functions
//    SetupClearPorts();
//    option1();
//    option2();
//    option3();
//    option4();
//    option5();
//    option6();
//    delay_ms(5000);
    
    // run functions in reverse order
//    SetupClearPorts();
//    option6();
//    option5();
//    option4();
//    option3();
//    option2();
//    option1();
//    delay_ms(5000);

    SetupClearPorts();
    walkPORTC1();
    walkPORTC2();

    SetupClearPorts();
    walkPORTD1();
    walkPORTD2();

    SetupClearPorts();
    walkPORTD2();
    walkPORTD1();

    SetupClearPorts();
    walkPORTC2();
    walkPORTC1();
  }
}