/* File Name: buzzer.c (LAB 15)
   Developed By: Penny Belle
   Submission To: AECT/AET Dept.
   Development Date: 2024-04-23
   Description: Control buzzer with bitwise commands.
/* ************************************************************************** */


void main() {
  TRISB = 0x0F; // set first four bits on B as inputs
  ANSELB = 0x00; // set as digital inputs
  PORTB = 0x00; // clear, set to logic low
  
  TRISC = 0x00; // set C as output
  PORTC = 0x00; // clear, set to logic low
  
  while(1) {
    int a, b, c, d, x;
    
    PORTC = 0x00; // set to low each loop start

    a = RB0_bit; // set each var to a bit on port B
    b = RB1_bit;
    c = RB2_bit;
    d = RB3_bit;
    
    x = a & b | b & c & d | a & c; // bitwise statement to determine logic out
    
    if (x==1) {
      PORTC = 0x01;
      delay_ms(1000);
    }
  }
}