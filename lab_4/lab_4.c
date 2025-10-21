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

void c_chord(int duration) {
  Sound_Play(130.81, duration);  // chord C freq 130.81Hz duration 500ms
}


void d_chord(int duration) {
  Sound_Play(146.83, duration);  // chord D freq 146.83Hz duration 500ms
}


void e_chord(int duration) {
  Sound_Play(164.81, duration);  // chord E freq 164.81Hz duration 500ms
}


void f_chord(int duration) {
  Sound_Play(174.61, duration);  // chord F freq 174.61Hz duration 500ms
}


void g_chord(int duration) {
  Sound_Play(196.00, duration);  // chord G freq 196.00Hz duration 500ms
}


void h_chord(int duration) {
  Sound_Play(220.00, duration);  // chord H freq 220.00Hz duration 500ms
}


void i_chord(int duration) {
  Sound_Play(246.94, duration);  // chord I freq 246.94Hz duration 500ms
}


void j_chord(int duration) {
  Sound_Play(261.63, duration);  // chord J freq 261.63Hz duration 500ms
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
    PORTB = 0x00;  // clear on each pass

    // if first bit of PORTB is active, play tone 1
    if (Button(&PORTB,1,1,1)) {
      c_chord(50);
      while(RB0_bit);
    }

    if (Button(&PORTB,2,1,1)) {
      d_chord(50);
      while(RB1_bit);
    }

    if (Button(&PORTB,3,1,1)) {
      e_chord(50);
      while(RB2_bit);
    }

    if (Button(&PORTB,4,1,1)) {
      f_chord(50);
      while(RB3_bit);
    }

    if (Button(&PORTB,5,1,1)) {
      g_chord(50);
      while(RB4_bit);
    }

    if (Button(&PORTB,6,1,1)) {
      h_chord(50);
      while(RB5_bit);
    }

    if (Button(&PORTB,7,1,1)) {
      i_chord(50);
      while(RB6_bit);
    }

    if (Button(&PORTB,8,1,1)) {
      j_chord(50);
      while(RB7_bit);
    }
  }
}