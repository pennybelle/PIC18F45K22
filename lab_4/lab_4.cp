#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/lab_4/lab_4.c"
#line 18 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/lab_4/lab_4.c"
void c_chord(int duration) {
 Sound_Play(130.81, duration);
}


void d_chord(int duration) {
 Sound_Play(146.83, duration);
}


void e_chord(int duration) {
 Sound_Play(164.81, duration);
}


void f_chord(int duration) {
 Sound_Play(174.61, duration);
}


void g_chord(int duration) {
 Sound_Play(196.00, duration);
}


void h_chord(int duration) {
 Sound_Play(220.00, duration);
}


void i_chord(int duration) {
 Sound_Play(246.94, duration);
}


void j_chord(int duration) {
 Sound_Play(261.63, duration);
}


void main() {

 TRISB = 0xFF;
 ANSELB = 0x00;
 PORTB = 0x00;
 C1ON_bit=0;
 C2ON_bit=0;




 Sound_Init(&PORTE, 1);


 while(1) {
 PORTB = 0x00;


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
