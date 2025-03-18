/* File Name: numbering_systems.c
   Developed By: Penny Belle
   Submission To: AECT/AET Dept.
   Development Date: 2024-03-18
   Description: Use different numbering systems in C to manipulate bits on PORTC
/* ************************************************************************** */

#include "Display_Utils.h"

// Seven Segment Display prep
unsigned short shifter, portd_index;
unsigned int digit;
unsigned short portd_array[4];

// Lcd module prep
sbit LCD_RS at LATB4_bit;
sbit LCD_EN at LATB5_bit;
sbit LCD_D4 at LATB0_bit;
sbit LCD_D5 at LATB1_bit;
sbit LCD_D6 at LATB2_bit;
sbit LCD_D7 at LATB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;

char i;                              // Loop variable

char txt1[] = "C Number Systems";
char txt2[] = "Using: Binary";
char txt3[] = "Using: Octal";
char txt4[] = "Using: Hex";
char txt5[] = "Using: Decimal";
char txt6[] = "Binary Display";
char signature[] = "By Penny Belle";
// End Lcd module prep

// init value used for converting to string
int number;

// global delay in milliseconds
int delay_in_ms = 500;

void interrupt() {
  LATA = 0;                             // Turn off all 7seg displays
  LATD = portd_array[portd_index];      // bring appropriate value to PORTD
  LATA = shifter;                       // turn on appropriate 7seg. display

  // move shifter to next digit
  shifter <<= 1;
  if (shifter > 8u)
    shifter = 1;

  // increment portd_index
  portd_index++ ;
  if (portd_index > 3u)
    portd_index = 0;             // turn on 1st, turn off 2nd 7seg.
  TMR0L  =   0;                  // reset TIMER0 value
  TMR0IF_bit = 0;                // Clear TMR0IF
}

void seven_seg_prep() {
  ANSELA = 0;                    // Configure PORTA pins as digital
  ANSELD = 0;                    // Configure PORTD pins as digital

  TRISA = 0;                     // Configure PORTA as output
  LATA  = 0;                     // Clear PORTA
  TRISD = 0;                     // Configure PORTD as output
  LATD  = 0;                     // Clear PORTD

  T0CON = 0xC4;                  // Set TMR0 in 8bit mode, assign prescaler to TMR0
  TMR0L = 0;                     // clear TMROL
  digit = 0;
  portd_index = 0;
  shifter = 1;

  GIE_bit = 1;
  TMR0IE_bit = 1;
}

void bit_walk_prep() {
  TRISC = 0x00; // set direction of data traffic to output
}

void seven_seg_out() {
  digit = number / 1000u ;             // extract thousands digit
  portd_array[3] = mask(digit);        // and store it to PORTD array
  digit = (number / 100u) % 10u;       // extract hundreds digit
  portd_array[2] = mask(digit);        // and store it to PORTD array
  digit = (number / 10u) % 10u;        // extract tens digit
  portd_array[1] = mask(digit);        // and store it to PORTD array
  digit = number % 10u;                // extract ones digit
  portd_array[0] = mask(digit);        // and store it to PORTD array
}

void lcd_display_prep() {
  ANSELB = 0;                        // Configure PORTB pins as digital
  Lcd_Init();                        // Initialize Lcd
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
}

void lcd_display_out(char first_line, char second_line) {
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Out(1,1,first_line);                 // Write text in first row

  Lcd_Out(2,1,second_line);                 // Write text in second row
}

void do_the_thing(int i) {
  number = i;
  seven_seg_out();
  PORTC = number;
  vdelay_ms(delay_in_ms);
}

void procedure_loop(int number_1, int number_2) {
    for (i = 0; i < 5; i++) {
      do_the_thing(number_1);
      do_the_thing(number_2);
    }
    delay_ms(1500);
    LATD  = 0; // clear seven seg display
}

//void bits(int i){
//  if (!i) {
//    return
//  };
//  bits(i>>1);
//  out = i&1
//  lcd_display_out(txt1, out);
//  printf(“%d”,i&1);
//  return;
//}

display_bits(int i) {
  number = i;
  seven_seg_out();
  PORTC = number;
  delay_ms(10000);
}

void main() {
  lcd_display_prep();
  seven_seg_prep();
  lcd_display_out(txt1, signature);

  TRISC=0b00000000; // set port C as output for all bits
  TRISC=0x00;       // same as above but with hex instead of binary
  PORTC=0b00000000; // clear port C (set all to logic low or 0 volts)
  
  // wait for plug
  delay_ms(3000);
  
  while (1) {
    // procedure 1
    lcd_display_out(txt1, txt2);
    procedure_loop(0b00001111, 0b11110000);

    // procedure 2
    lcd_display_out(txt1, txt2);
    procedure_loop(0b01010101, 0b10101010);

    // procedure 3
    lcd_display_out(txt1, txt3);
    procedure_loop(0125, 0252);

    // procedure 4
    lcd_display_out(txt1, txt4);
    procedure_loop(0x55, 0xAA);

    // procedure 5
    lcd_display_out(txt1, txt5);
    procedure_loop(85, 170);
    
    lcd_display_out(txt6, signature);
    display_bits(0xA5);
    display_bits(186);
    display_bits(055);
    display_bits(0xF3);
    display_bits(28);
    display_bits(0212);
    display_bits(255);
    display_bits(0252);
    display_bits(0xF1);
  }
}