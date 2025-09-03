#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/lab_1/lab_1.c"
#line 9 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/lab_1/lab_1.c"
void knight_rider() {
 int number = 1;
 PORTD = ~0x00;


 while (number <= 128) {
 PORTC = number;
 delay_ms(1000);
 number *= 2;
 }

 number = 1;
 PORTC = 0x00;


 while (number <= 128) {
 PORTD = ~number;
 delay_ms(1000);
 number *= 2;
 }
}


void main() {
 TRISA = 0x00;
 TRISB = 0x00;
 TRISC = 0x00;
 TRISD = 0x00;

 while(1) {
 knight_rider();
 }
}
