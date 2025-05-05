/* File Name: logical_operators.c (LAB 14)
   Developed By: Penny Belle
   Submission To: AECT/AET Dept.
   Development Date: 2024-04-22
   Description: Control output with case statements.
/* ************************************************************************** */


int i;
int reference = 0b00000001;
int reference2 = 0b10000000;


void main() {
   TRISA = 0xFF; // set portA as input
   TRISB = 0xFF; // set portB as input
   TRISC = 0xFF; // set portC as input
   TRISD = 0x00; // set portD as output

   // set all 4 ports as digital
   ANSELA = 0x00;
   ANSELB = 0x00;
   ANSELC = 0x00;
   ANSELD = 0x00;

   while(1) {
     if (PORTA == 0b00000001) {
       PORTD = PORTB & PORTC;
     } else if (PORTA == 0b00000010) {
       PORTD = PORTB | PORTC;
     } else if (PORTA == 0b00000100) {
       PORTD = PORTB ^ PORTC;
     } else if (PORTA == 0b0001000) {
       PORTD = ~PORTB;
     } else if (PORTA == 0b00010000) {
       for (i=1; i<=8; i++) {
         PORTD = reference;
         delay_ms(500);
         reference = reference << 1;
       }
       reference = 0b00000001;
     } else if (PORTA == 0b00100000) {
       for (i=1; i<=8; i++) {
         PORTD = reference2;
         delay_ms(500);
         reference2 = reference2 >> 1;
       }
       reference2 = 0b10000000;
     }
   }
}