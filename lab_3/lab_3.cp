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

void main() {
 while(1) {
 SetupClearPorts();
 option6();
 option5();
 option4();
 option3();
 option2();
 option1();
 }
}
