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

void tone_1() {
  Sound_Play(130.81, 500);  // chord C freq 130.81Hz duration 500ms
}


void tone_2() {
  Sound_Play(146.83, 500);  // chord D freq 146.83Hz duration 500ms
}


void tone_3() {
  Sound_Play(164.81, 500);  // chord E freq 164.81Hz duration 500ms
}


void tone_4() {
  Sound_Play(174.61, 500);  // chord F freq 174.61Hz duration 500ms
}


void tone_5() {
  Sound_Play(196.00, 500);  // chord G freq 196.00Hz duration 500ms
}


void tone_6() {
  Sound_Play(220.00, 500);  // chord H freq 220.00Hz duration 500ms
}


void tone_7() {
  Sound_Play(246.94, 500);  // chord I freq 246.94Hz duration 500ms
}


void tone_8() {
  Sound_Play(261.63, 500);  // chord J freq 261.63Hz duration 500ms
}


void main() {     // Main Function (program core)
  // setup ports
  TRISB = 0xFF;           // PORTB as INPUT
  ANSELB = 0x00;          // PORTB as digital
  PORTB = 0x00;           // clear PORTB
  C1ON_bit=0;
  C2ON_bit=0;
  // TRISE = 0x00;           // PORTE as OUTPUT
  // ANSELE = 0xFF;          // PORTE as analog
  // PORTE = 0x00;           // clear PORTE

  Sound_Init(&PORTE, 1);  // init Piezo on PORTE bit 1

  // loop forever
  while(1) {
    // if first bit of PORTB is active, play tone 1
    if (Button(&PORTB,1,1,1)) {
      while(RB1_bit) {
        tone_1();
      }
      // // loop over sound twice with 4 second delay
      // for (i=1; i<=2; i++) {
      //   Sound_Play(440, 2000);
      //   delay_ms(4000);
      // }
    }

    if (Button(&PORTB,2,1,1)) {
      while(RB2_bit) {
        tone_2();
      }
    }

    if (Button(&PORTB,3,1,1)) {
      while(RB3_bit) {
        tone_3();
      }
    }

    if (Button(&PORTB,4,1,1)) {
      while(RB4_bit) {
        tone_4();
      }
    }

    if (Button(&PORTB,5,1,1)) {
      while(RB5_bit) {
        tone_5();
      }
    }

    if (Button(&PORTB,6,1,1)) {
      while(RB6_bit) {
        tone_6();
      }
    }

    if (Button(&PORTB,7,1,1)) {
      while(RB7_bit) {
        tone_7();
      }
    }

    if (Button(&PORTB,8,1,1)) {
      while(RB8_bit) {
        tone_8();
      }
    }
  }
}