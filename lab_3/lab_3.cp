#line 1 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/lab_3/lab_3.c"
#line 9 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/lab_3/lab_3.c"
void SetupClearPorts() {
 TRISB = 0x00;
 TRISC = 0x00;
 TRISD = 0x00;
 PORTB = 0x00;
 PORTC = 0x00;
 PORTD = 0x00;
}



void option1() {
 PORTB = 0xFF;
 delay_ms(1000);
 PORTB = 0x00;
 delay_ms(1000);
}



void option2() {
 PORTC = 0xFF;
 delay_ms(1000);
 PORTC = 0x00;
 delay_ms(1000);
}



void option3() {
 PORTD = 0xFF;
 delay_ms(1000);
 PORTD = 0x00;
 delay_ms(1000);
}



void option4() {
 PORTB = 0x55;
 delay_ms(1000);
 PORTB = 0x00;
 delay_ms(1000);
}



void option5() {
 PORTC = 0xAA;
 delay_ms(1000);
 PORTC = 0x00;
 delay_ms(1000);
}



void option6() {
 PORTD = 0x55;
 delay_ms(1000);
 PORTD = 0xAA;
 delay_ms(1000);
 PORTD = 0x00;
}



void walkPORTC1() {
 int i;
 for(i=1; i<=128; i*=2) {
 PORTC = i;
 delay_ms(250);
 }
}



void walkPORTC2() {
 int i;
 for(i=128; i>=1; i/=2) {
 PORTC = i;
 delay_ms(250);
 }
}



void walkPORTD1() {
 int i;
 for(i=1; i<=128; i*=2) {
 PORTD = i;
 delay_ms(250);
 }
}



void walkPORTD2() {
 int i;
 for(i=128; i>=1; i/=2) {
 PORTD = i;
 delay_ms(250);
 }
}


void main() {

 while(1) {
#line 137 "C:/Users/michelle/Documents/GitHub/PIC18F45K22/lab_3/lab_3.c"
 SetupClearPorts();
 walkPORTC1();
 walkPORTC2();

 SetupClearPorts();
 walkPORTD1();
 walkPORTD2();

 SetupClearPorts();
 walkPORTD2();
 walkPORTD1();

 SetupClearPorts();
 walkPORTC2();
 walkPORTC1();
 }
}
