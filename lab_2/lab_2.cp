#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/lab_2/lab_2.c"
#line 31 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/lab_2/lab_2.c"
int bin1 = 0b10101010;
int hex1 = 0x55;
int hex2 = 0xAA;
int dec1 = 55;
int oct1 = 0252;

void main() {
 TRISC = 0x00;
 PORTC = 0x00;
 TRISB = 0xFF;
 ANSELB = 0x00;


 while(1) {









 if (PORTB == 0b00000001) {
 PORTC = 0x55;
 delay_ms(2000);
 } else {
 PORTC = 0xAA;
 delay_ms(2000);
 }
 }
}
