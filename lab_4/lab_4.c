/* File Name: Project 04 Tone-Control-Piezo Buzzer
   Developed By: Penny Belle
   Submission To: AECT/AET Department
   Development Date: 10-15-2025
   Description: Program uses onboard Piezo buzzer to create alarm tone        */
/* ************************************************************************** */

/* *****************************************************************************
Setup:
PORTC is set to Digital INPUT to read selected key switch,
PORTE is set to OUTPUT, drives Piezo buzzer on RE1, JumperJ21, is set to RE1.
SW3 PORTB Toggled to the LEDs ON position
Pull-Down pins RB7 through RB3 in PORTB for input selection to active HIGH when 
depressed.
Enable Library Functions Sound_Init and Button
***************************************************************************** */

void main() {     // Main Function (program core)
  // setup ports
  TRISC = 0xFF;           // PORTC as INPUT
  ANSELC = 0x00;          // PORTC as digital
  PORTC = 0x00;           // clear PORTC
  TRISE = 0x00;           // PORTE as OUTPUT
  ANSELE = 0xFF;          // PORTE as analog
  PORTE = 0x00;           // clear PORTE

  Sound_Init(&PORTE, 1);  // init Piezo on PORTE bit 1

  // loop forever
  while(1) {
    // if first bit of PORTE is active, play sound twice
    if (RC0_bit == 1) {
      // loop over sound twice with 4 second delay
      for (i=1; i<=2; i++) {
        Sound_Play(440, 2000);
        delay_ms(4000);
      }
    }
    
  }
}