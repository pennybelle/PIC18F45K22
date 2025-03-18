
_interrupt:

;numbering_systems.c,42 :: 		void interrupt() {
;numbering_systems.c,43 :: 		LATA = 0;                             // Turn off all 7seg displays
	CLRF        LATA+0 
;numbering_systems.c,44 :: 		LATD = portd_array[portd_index];      // bring appropriate value to PORTD
	MOVLW       _portd_array+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_portd_array+0)
	MOVWF       FSR0L+1 
	MOVF        _portd_index+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       LATD+0 
;numbering_systems.c,45 :: 		LATA = shifter;                       // turn on appropriate 7seg. display
	MOVF        _shifter+0, 0 
	MOVWF       LATA+0 
;numbering_systems.c,48 :: 		shifter <<= 1;
	MOVF        _shifter+0, 0 
	MOVWF       R1 
	RLCF        R1, 1 
	BCF         R1, 0 
	MOVF        R1, 0 
	MOVWF       _shifter+0 
;numbering_systems.c,49 :: 		if (shifter > 8u)
	MOVF        R1, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt0
;numbering_systems.c,50 :: 		shifter = 1;
	MOVLW       1
	MOVWF       _shifter+0 
L_interrupt0:
;numbering_systems.c,53 :: 		portd_index++ ;
	INCF        _portd_index+0, 1 
;numbering_systems.c,54 :: 		if (portd_index > 3u)
	MOVF        _portd_index+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
;numbering_systems.c,55 :: 		portd_index = 0;             // turn on 1st, turn off 2nd 7seg.
	CLRF        _portd_index+0 
L_interrupt1:
;numbering_systems.c,56 :: 		TMR0L  =   0;                  // reset TIMER0 value
	CLRF        TMR0L+0 
;numbering_systems.c,57 :: 		TMR0IF_bit = 0;                // Clear TMR0IF
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;numbering_systems.c,58 :: 		}
L_end_interrupt:
L__interrupt11:
	RETFIE      1
; end of _interrupt

_seven_seg_prep:

;numbering_systems.c,60 :: 		void seven_seg_prep() {
;numbering_systems.c,61 :: 		ANSELA = 0;                    // Configure PORTA pins as digital
	CLRF        ANSELA+0 
;numbering_systems.c,62 :: 		ANSELD = 0;                    // Configure PORTD pins as digital
	CLRF        ANSELD+0 
;numbering_systems.c,64 :: 		TRISA = 0;                     // Configure PORTA as output
	CLRF        TRISA+0 
;numbering_systems.c,65 :: 		LATA  = 0;                     // Clear PORTA
	CLRF        LATA+0 
;numbering_systems.c,66 :: 		TRISD = 0;                     // Configure PORTD as output
	CLRF        TRISD+0 
;numbering_systems.c,67 :: 		LATD  = 0;                     // Clear PORTD
	CLRF        LATD+0 
;numbering_systems.c,69 :: 		T0CON = 0xC4;                  // Set TMR0 in 8bit mode, assign prescaler to TMR0
	MOVLW       196
	MOVWF       T0CON+0 
;numbering_systems.c,70 :: 		TMR0L = 0;                     // clear TMROL
	CLRF        TMR0L+0 
;numbering_systems.c,71 :: 		digit = 0;
	CLRF        _digit+0 
	CLRF        _digit+1 
;numbering_systems.c,72 :: 		portd_index = 0;
	CLRF        _portd_index+0 
;numbering_systems.c,73 :: 		shifter = 1;
	MOVLW       1
	MOVWF       _shifter+0 
;numbering_systems.c,75 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;numbering_systems.c,76 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;numbering_systems.c,77 :: 		}
L_end_seven_seg_prep:
	RETURN      0
; end of _seven_seg_prep

_bit_walk_prep:

;numbering_systems.c,79 :: 		void bit_walk_prep() {
;numbering_systems.c,80 :: 		TRISC = 0x00; // set direction of data traffic to output
	CLRF        TRISC+0 
;numbering_systems.c,81 :: 		}
L_end_bit_walk_prep:
	RETURN      0
; end of _bit_walk_prep

_seven_seg_out:

;numbering_systems.c,83 :: 		void seven_seg_out() {
;numbering_systems.c,84 :: 		digit = number / 1000u ;             // extract thousands digit
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _number+0, 0 
	MOVWF       R0 
	MOVF        _number+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _digit+0 
	MOVF        R1, 0 
	MOVWF       _digit+1 
;numbering_systems.c,85 :: 		portd_array[3] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+3 
;numbering_systems.c,86 :: 		digit = (number / 100u) % 10u;       // extract hundreds digit
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _number+0, 0 
	MOVWF       R0 
	MOVF        _number+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _digit+0 
	MOVF        R1, 0 
	MOVWF       _digit+1 
;numbering_systems.c,87 :: 		portd_array[2] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+2 
;numbering_systems.c,88 :: 		digit = (number / 10u) % 10u;        // extract tens digit
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _number+0, 0 
	MOVWF       R0 
	MOVF        _number+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _digit+0 
	MOVF        R1, 0 
	MOVWF       _digit+1 
;numbering_systems.c,89 :: 		portd_array[1] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+1 
;numbering_systems.c,90 :: 		digit = number % 10u;                // extract ones digit
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _number+0, 0 
	MOVWF       R0 
	MOVF        _number+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _digit+0 
	MOVF        R1, 0 
	MOVWF       _digit+1 
;numbering_systems.c,91 :: 		portd_array[0] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+0 
;numbering_systems.c,92 :: 		}
L_end_seven_seg_out:
	RETURN      0
; end of _seven_seg_out

_lcd_display_prep:

;numbering_systems.c,94 :: 		void lcd_display_prep() {
;numbering_systems.c,95 :: 		ANSELB = 0;                        // Configure PORTB pins as digital
	CLRF        ANSELB+0 
;numbering_systems.c,96 :: 		Lcd_Init();                        // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;numbering_systems.c,97 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;numbering_systems.c,98 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;numbering_systems.c,99 :: 		}
L_end_lcd_display_prep:
	RETURN      0
; end of _lcd_display_prep

_lcd_display_out:

;numbering_systems.c,101 :: 		void lcd_display_out(char first_line, char second_line) {
;numbering_systems.c,102 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;numbering_systems.c,103 :: 		Lcd_Out(1,1,first_line);                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_first_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;numbering_systems.c,105 :: 		Lcd_Out(2,1,second_line);                 // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_second_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;numbering_systems.c,106 :: 		}
L_end_lcd_display_out:
	RETURN      0
; end of _lcd_display_out

_do_the_thing:

;numbering_systems.c,108 :: 		void do_the_thing(int i) {
;numbering_systems.c,109 :: 		number = i;
	MOVF        FARG_do_the_thing_i+0, 0 
	MOVWF       _number+0 
	MOVF        FARG_do_the_thing_i+1, 0 
	MOVWF       _number+1 
;numbering_systems.c,110 :: 		seven_seg_out();
	CALL        _seven_seg_out+0, 0
;numbering_systems.c,111 :: 		PORTC = number;
	MOVF        _number+0, 0 
	MOVWF       PORTC+0 
;numbering_systems.c,112 :: 		vdelay_ms(delay_in_ms);
	MOVF        _delay_in_ms+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        _delay_in_ms+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;numbering_systems.c,113 :: 		}
L_end_do_the_thing:
	RETURN      0
; end of _do_the_thing

_main:

;numbering_systems.c,115 :: 		void main() {
;numbering_systems.c,116 :: 		lcd_display_prep();
	CALL        _lcd_display_prep+0, 0
;numbering_systems.c,117 :: 		seven_seg_prep();
	CALL        _seven_seg_prep+0, 0
;numbering_systems.c,118 :: 		lcd_display_out(txt1, signature);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _signature+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;numbering_systems.c,120 :: 		TRISC=0b00000000; // set port C as output for all bits
	CLRF        TRISC+0 
;numbering_systems.c,121 :: 		TRISC=0x00;       // same as above but with hex instead of binary
	CLRF        TRISC+0 
;numbering_systems.c,122 :: 		PORTC=0b00000000; // clear port C (set all to logic low or 0 volts)
	CLRF        PORTC+0 
;numbering_systems.c,124 :: 		while (1) {
L_main2:
;numbering_systems.c,126 :: 		for (i = 0; i < 5; i++) {
	CLRF        _i+0 
L_main4:
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main5
;numbering_systems.c,127 :: 		do_the_thing(0b00001111);
	MOVLW       15
	MOVWF       FARG_do_the_thing_i+0 
	MOVLW       0
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;numbering_systems.c,128 :: 		do_the_thing(0b11110000);
	MOVLW       240
	MOVWF       FARG_do_the_thing_i+0 
	MOVLW       0
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;numbering_systems.c,126 :: 		for (i = 0; i < 5; i++) {
	INCF        _i+0, 1 
;numbering_systems.c,129 :: 		}
	GOTO        L_main4
L_main5:
;numbering_systems.c,132 :: 		for (i = 0; i < 5; i++) {
	CLRF        _i+0 
L_main7:
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main8
;numbering_systems.c,133 :: 		do_the_thing(0b01010101);
	MOVLW       85
	MOVWF       FARG_do_the_thing_i+0 
	MOVLW       0
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;numbering_systems.c,134 :: 		do_the_thing(0b10101010);
	MOVLW       170
	MOVWF       FARG_do_the_thing_i+0 
	MOVLW       0
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;numbering_systems.c,132 :: 		for (i = 0; i < 5; i++) {
	INCF        _i+0, 1 
;numbering_systems.c,135 :: 		}
	GOTO        L_main7
L_main8:
;numbering_systems.c,136 :: 		}
	GOTO        L_main2
;numbering_systems.c,137 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
