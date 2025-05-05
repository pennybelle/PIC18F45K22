#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/logical_operators/logical_operators.c"
#line 9 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/logical_operators/logical_operators.c"
int i;
int reference = 0b00000001;
int reference2 = 0b10000000;


void main() {
 TRISB = 0xFF;
 TRISC = 0xFF;
 TRISD = 0x00;
 TRISA = 0xFF;


 ANSELB = 0x00;
 ANSELC = 0x00;
 ANSELD = 0x00;
 ANSELA = 0x00;

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
