#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/buzzer/buzzer.c"
#line 9 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/buzzer/buzzer.c"
void main() {
 TRISB = 0x0F;
 ANSELB = 0x00;
 PORTB = 0x00;

 TRISC = 0x00;
 PORTC = 0x00;

 while(1) {
 int a, b, c, d, x;

 PORTC = 0x00;

 a = RB0_bit;
 b = RB1_bit;
 c = RB2_bit;
 d = RB3_bit;

 x = a & b | b & c & d | a & c;

 if (x==1) {
 PORTC = 0x01;
 delay_ms(1000);
 }
 }
}
