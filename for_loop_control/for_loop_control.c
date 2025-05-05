/* File Name: for_loop_control.c (LAB 12)
   Developed By: Penny Belle
   Submission To: AECT/AET Dept.
   Development Date: 2024-04-08
   Description: Control output with for loops and conditionals.
/* ************************************************************************** */


/* ******************* BOILER PLATE ********************* */
// Lcd module prep
char i; // Loop variable
char txt1[] = "For Loops!!!";
char txt2[] = "Default Pattern";
char txt3[] = "Binary Up";
char txt4[] = "Binary Down";
char txt5[] = "Knight Rider";
char txt6[] = "Only Evens";
char txt7[] = "Only Odds";
char signature[] = "By Penny Belle";

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
// End Lcd module prep


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
/* ***************** END BOILER PLATE ******************** */


// global counter
int j;


void default_pattern() {
  for (j = 1; j <= 128; j = j+2) {
    PORTC = j;
    delay_ms(500);
  }

  for (j = 128; j >= 1; j= j/2) {
    PORTC = j;
    delay_ms(500);
  }
}


void binary_count_up() {
  for (j = 1; j <= 128; j = j++) {
    PORTC = j;
    delay_ms(469);  // close as i can get to the cycle being exactly 60s
  }
}


void binary_count_down() {
  for (j = 128; j >= 1; j= j--) {
    PORTC = j;
    delay_ms(469);
  }
}


void knight_rider() {
  for (j = 1; j <= 128; j = j*2) {
    PORTC = j;
    delay_ms(8);
  }

  for (j = 128; j >= 1; j= j/2) {
    PORTC = j;
    delay_ms(8);
  }
}


void only_evens() {
  for (j = 2; j <= 128; j = j+2) {
    PORTC = j;
    delay_ms(500);
  }

  for (j = 128; j >= 2; j= j-2) {
    PORTC = j;
    delay_ms(500);
  }
}


void only_odds() {
  // not done
  for (j = 1; j <= 127; j = j+2) {
    PORTC = j;
    delay_ms(500);
  }

  for (j = 127; j >= 1; j= j-2) {
    PORTC = j;
    delay_ms(500);
  }
}


void main() {
  lcd_display_prep();
  lcd_display_out(txt1, signature);

  // prep port C for output
  TRISC = 0x00;
  PORTC = 0x00;
  
  delay_ms(2000); // wait for plug

  while(1) {
    PORTC = 0x00; // reset output each loop

    lcd_display_out(txt1, txt2);
    default_pattern();
    PORTC = 0x00;
    delay_ms(2000);

    lcd_display_out(txt1, txt3);
    binary_count_up();
    delay_ms(2000);

    lcd_display_out(txt1, txt4);
    binary_count_down();
    delay_ms(2000);

    lcd_display_out(txt1, txt5);
    knight_rider();
    delay_ms(2000);

    lcd_display_out(txt1, txt6);
    only_evens();
    delay_ms(2000);

    lcd_display_out(txt1, txt7);
    only_odds();
    delay_ms(2000);
  }
}