#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/lab_2/lab_2.c"
#line 9 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/lab_2/lab_2.c"
int i;

void main() {
 TRISC = 0x00;
 PORTC = 0x00;
 TRISB = 0xFF;
 ANSELB = 0x00;

 while(1) {
#line 62 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/lab_2/lab_2.c"
 int var1 = 0b10101010;
 int var2 = 0b01010101;
 int var3 = 0x0F;

 PORTC = var1 & var2;
 delay_ms(1000);
 PORTC = var1 | var2;
 delay_ms(1000);
 PORTC = var1 ^ var2;
 delay_ms(1000);

 PORTC = ~var3;
 delay_ms(1000);
 }
}
