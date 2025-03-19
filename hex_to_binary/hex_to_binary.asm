
_interrupt:

;hex_to_binary.c,58 :: 		void interrupt() {
;hex_to_binary.c,59 :: 		LATA = 0;                             // Turn off all 7seg displays
	CLRF        LATA+0 
;hex_to_binary.c,60 :: 		LATD = portd_array[portd_index];      // bring appropriate value to PORTD
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
;hex_to_binary.c,61 :: 		LATA = shifter;                       // turn on appropriate 7seg. display
	MOVF        _shifter+0, 0 
	MOVWF       LATA+0 
;hex_to_binary.c,64 :: 		shifter <<= 1;
	MOVF        _shifter+0, 0 
	MOVWF       R1 
	RLCF        R1, 1 
	BCF         R1, 0 
	MOVF        R1, 0 
	MOVWF       _shifter+0 
;hex_to_binary.c,65 :: 		if (shifter > 8u)
	MOVF        R1, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt0
;hex_to_binary.c,66 :: 		shifter = 1;
	MOVLW       1
	MOVWF       _shifter+0 
L_interrupt0:
;hex_to_binary.c,69 :: 		portd_index++ ;
	INCF        _portd_index+0, 1 
;hex_to_binary.c,70 :: 		if (portd_index > 3u)
	MOVF        _portd_index+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
;hex_to_binary.c,71 :: 		portd_index = 0;             // turn on 1st, turn off 2nd 7seg.
	CLRF        _portd_index+0 
L_interrupt1:
;hex_to_binary.c,72 :: 		TMR0L  =   0;                  // reset TIMER0 value
	CLRF        TMR0L+0 
;hex_to_binary.c,73 :: 		TMR0IF_bit = 0;                // Clear TMR0IF
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;hex_to_binary.c,74 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_seven_seg_prep:

;hex_to_binary.c,76 :: 		void seven_seg_prep() {
;hex_to_binary.c,77 :: 		ANSELA = 0;                    // Configure PORTA pins as digital
	CLRF        ANSELA+0 
;hex_to_binary.c,78 :: 		ANSELD = 0;                    // Configure PORTD pins as digital
	CLRF        ANSELD+0 
;hex_to_binary.c,80 :: 		TRISA = 0;                     // Configure PORTA as output
	CLRF        TRISA+0 
;hex_to_binary.c,81 :: 		LATA  = 0;                     // Clear PORTA
	CLRF        LATA+0 
;hex_to_binary.c,82 :: 		TRISD = 0;                     // Configure PORTD as output
	CLRF        TRISD+0 
;hex_to_binary.c,83 :: 		LATD  = 0;                     // Clear PORTD
	CLRF        LATD+0 
;hex_to_binary.c,85 :: 		T0CON = 0xC4;                  // Set TMR0 in 8bit mode, assign prescaler to TMR0
	MOVLW       196
	MOVWF       T0CON+0 
;hex_to_binary.c,86 :: 		TMR0L = 0;                     // clear TMROL
	CLRF        TMR0L+0 
;hex_to_binary.c,87 :: 		digit = 0;
	CLRF        _digit+0 
	CLRF        _digit+1 
;hex_to_binary.c,88 :: 		portd_index = 0;
	CLRF        _portd_index+0 
;hex_to_binary.c,89 :: 		shifter = 1;
	MOVLW       1
	MOVWF       _shifter+0 
;hex_to_binary.c,91 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;hex_to_binary.c,92 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;hex_to_binary.c,93 :: 		}
L_end_seven_seg_prep:
	RETURN      0
; end of _seven_seg_prep

_seven_seg_out:

;hex_to_binary.c,95 :: 		void seven_seg_out() {
;hex_to_binary.c,96 :: 		digit = number / 1000u ;             // extract thousands digit
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
;hex_to_binary.c,97 :: 		portd_array[3] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+3 
;hex_to_binary.c,98 :: 		digit = (number / 100u) % 10u;       // extract hundreds digit
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
;hex_to_binary.c,99 :: 		portd_array[2] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+2 
;hex_to_binary.c,100 :: 		digit = (number / 10u) % 10u;        // extract tens digit
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
;hex_to_binary.c,101 :: 		portd_array[1] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+1 
;hex_to_binary.c,102 :: 		digit = number % 10u;                // extract ones digit
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
;hex_to_binary.c,103 :: 		portd_array[0] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+0 
;hex_to_binary.c,104 :: 		}
L_end_seven_seg_out:
	RETURN      0
; end of _seven_seg_out

_lcd_display_prep:

;hex_to_binary.c,106 :: 		void lcd_display_prep() {
;hex_to_binary.c,107 :: 		ANSELB = 0;                        // Configure PORTB pins as digital
	CLRF        ANSELB+0 
;hex_to_binary.c,108 :: 		Lcd_Init();                        // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;hex_to_binary.c,109 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;hex_to_binary.c,110 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;hex_to_binary.c,111 :: 		}
L_end_lcd_display_prep:
	RETURN      0
; end of _lcd_display_prep

_lcd_display_out:

;hex_to_binary.c,113 :: 		void lcd_display_out(char first_line, char second_line) {
;hex_to_binary.c,114 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;hex_to_binary.c,115 :: 		Lcd_Out(1,1,first_line);                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_first_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;hex_to_binary.c,117 :: 		Lcd_Out(2,1,second_line);                 // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_second_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;hex_to_binary.c,118 :: 		}
L_end_lcd_display_out:
	RETURN      0
; end of _lcd_display_out

_do_the_thing:

;hex_to_binary.c,120 :: 		void do_the_thing(int i) {
;hex_to_binary.c,121 :: 		number = i;
	MOVF        FARG_do_the_thing_i+0, 0 
	MOVWF       _number+0 
	MOVF        FARG_do_the_thing_i+1, 0 
	MOVWF       _number+1 
;hex_to_binary.c,122 :: 		PORTC = number;
	MOVF        FARG_do_the_thing_i+0, 0 
	MOVWF       PORTC+0 
;hex_to_binary.c,123 :: 		seven_seg_out();
	CALL        _seven_seg_out+0, 0
;hex_to_binary.c,124 :: 		vdelay_ms(delay);
	MOVF        _delay+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        _delay+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;hex_to_binary.c,125 :: 		}
L_end_do_the_thing:
	RETURN      0
; end of _do_the_thing

_main:

;hex_to_binary.c,127 :: 		void main() {
;hex_to_binary.c,128 :: 		lcd_display_prep();
	CALL        _lcd_display_prep+0, 0
;hex_to_binary.c,129 :: 		seven_seg_prep();
	CALL        _seven_seg_prep+0, 0
;hex_to_binary.c,130 :: 		lcd_display_out(txt1, signature);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _signature+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;hex_to_binary.c,132 :: 		TRISC = 0x00; // set port C as output
	CLRF        TRISC+0 
;hex_to_binary.c,133 :: 		PORTC = 0x00; // set all bits in port C to 0
	CLRF        PORTC+0 
;hex_to_binary.c,135 :: 		while (1) {
L_main2:
;hex_to_binary.c,136 :: 		do_the_thing(dec1);
	MOVF        _dec1+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _dec1+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,137 :: 		do_the_thing(dec2);
	MOVF        _dec2+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _dec2+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,138 :: 		do_the_thing(dec3);
	MOVF        _dec3+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _dec3+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,139 :: 		do_the_thing(dec4);
	MOVF        _dec4+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _dec4+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,140 :: 		do_the_thing(dec5);
	MOVF        _dec5+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _dec5+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,142 :: 		do_the_thing(bin1);
	MOVF        _bin1+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _bin1+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,143 :: 		do_the_thing(bin2);
	MOVF        _bin2+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _bin2+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,144 :: 		do_the_thing(bin3);
	MOVF        _bin3+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _bin3+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,145 :: 		do_the_thing(bin4);
	MOVF        _bin4+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _bin4+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,146 :: 		do_the_thing(bin5);
	MOVF        _bin5+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _bin5+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,148 :: 		do_the_thing(hex1);
	MOVF        _hex1+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _hex1+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,149 :: 		do_the_thing(hex2);
	MOVF        _hex2+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _hex2+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,150 :: 		do_the_thing(hex3);
	MOVF        _hex3+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _hex3+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,151 :: 		do_the_thing(hex4);
	MOVF        _hex4+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _hex4+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,152 :: 		do_the_thing(hex5);
	MOVF        _hex5+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        _hex5+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;hex_to_binary.c,153 :: 		}
	GOTO        L_main2
;hex_to_binary.c,154 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
