
_interrupt:

;knight_rider.c,50 :: 		void interrupt() {
;knight_rider.c,51 :: 		LATA = 0;                             // Turn off all 7seg displays
	CLRF        LATA+0 
;knight_rider.c,52 :: 		LATD = portd_array[portd_index];      // bring appropriate value to PORTD
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
;knight_rider.c,53 :: 		LATA = shifter;                       // turn on appropriate 7seg. display
	MOVF        _shifter+0, 0 
	MOVWF       LATA+0 
;knight_rider.c,56 :: 		shifter <<= 1;
	MOVF        _shifter+0, 0 
	MOVWF       R1 
	RLCF        R1, 1 
	BCF         R1, 0 
	MOVF        R1, 0 
	MOVWF       _shifter+0 
;knight_rider.c,57 :: 		if (shifter > 8u)
	MOVF        R1, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt0
;knight_rider.c,58 :: 		shifter = 1;
	MOVLW       1
	MOVWF       _shifter+0 
L_interrupt0:
;knight_rider.c,61 :: 		portd_index++ ;
	INCF        _portd_index+0, 1 
;knight_rider.c,62 :: 		if (portd_index > 3u)
	MOVF        _portd_index+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
;knight_rider.c,63 :: 		portd_index = 0;             // turn on 1st, turn off 2nd 7seg.
	CLRF        _portd_index+0 
L_interrupt1:
;knight_rider.c,64 :: 		TMR0L  =   0;                  // reset TIMER0 value
	CLRF        TMR0L+0 
;knight_rider.c,65 :: 		TMR0IF_bit = 0;                // Clear TMR0IF
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;knight_rider.c,66 :: 		}
L_end_interrupt:
L__interrupt21:
	RETFIE      1
; end of _interrupt

_seven_seg_prep:

;knight_rider.c,68 :: 		void seven_seg_prep() {
;knight_rider.c,69 :: 		ANSELA = 0;                    // Configure PORTA pins as digital
	CLRF        ANSELA+0 
;knight_rider.c,70 :: 		ANSELD = 0;                    // Configure PORTD pins as digital
	CLRF        ANSELD+0 
;knight_rider.c,72 :: 		TRISA = 0;                     // Configure PORTA as output
	CLRF        TRISA+0 
;knight_rider.c,73 :: 		LATA  = 0;                     // Clear PORTA
	CLRF        LATA+0 
;knight_rider.c,74 :: 		TRISD = 0;                     // Configure PORTD as output
	CLRF        TRISD+0 
;knight_rider.c,75 :: 		LATD  = 0;                     // Clear PORTD
	CLRF        LATD+0 
;knight_rider.c,77 :: 		T0CON = 0xC4;                  // Set TMR0 in 8bit mode, assign prescaler to TMR0
	MOVLW       196
	MOVWF       T0CON+0 
;knight_rider.c,78 :: 		TMR0L = 0;                     // clear TMROL
	CLRF        TMR0L+0 
;knight_rider.c,79 :: 		digit = 0;
	CLRF        _digit+0 
	CLRF        _digit+1 
;knight_rider.c,80 :: 		portd_index = 0;
	CLRF        _portd_index+0 
;knight_rider.c,81 :: 		shifter = 1;
	MOVLW       1
	MOVWF       _shifter+0 
;knight_rider.c,83 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;knight_rider.c,84 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;knight_rider.c,85 :: 		}
L_end_seven_seg_prep:
	RETURN      0
; end of _seven_seg_prep

_seven_seg_out:

;knight_rider.c,87 :: 		void seven_seg_out() {
;knight_rider.c,88 :: 		digit = number / 1000u ;             // extract thousands digit
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
;knight_rider.c,89 :: 		portd_array[3] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+3 
;knight_rider.c,90 :: 		digit = (number / 100u) % 10u;       // extract hundreds digit
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
;knight_rider.c,91 :: 		portd_array[2] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+2 
;knight_rider.c,92 :: 		digit = (number / 10u) % 10u;        // extract tens digit
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
;knight_rider.c,93 :: 		portd_array[1] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+1 
;knight_rider.c,94 :: 		digit = number % 10u;                // extract ones digit
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
;knight_rider.c,95 :: 		portd_array[0] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+0 
;knight_rider.c,96 :: 		}
L_end_seven_seg_out:
	RETURN      0
; end of _seven_seg_out

_lcd_display_prep:

;knight_rider.c,98 :: 		void lcd_display_prep() {
;knight_rider.c,99 :: 		ANSELB = 0;                        // Configure PORTB pins as digital
	CLRF        ANSELB+0 
;knight_rider.c,100 :: 		Lcd_Init();                        // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;knight_rider.c,101 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;knight_rider.c,102 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;knight_rider.c,103 :: 		}
L_end_lcd_display_prep:
	RETURN      0
; end of _lcd_display_prep

_lcd_display_out:

;knight_rider.c,105 :: 		void lcd_display_out(char first_line, char second_line) {
;knight_rider.c,106 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;knight_rider.c,107 :: 		Lcd_Out(1,1,first_line);                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_first_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;knight_rider.c,109 :: 		Lcd_Out(2,1,second_line);                 // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_second_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;knight_rider.c,110 :: 		}
L_end_lcd_display_out:
	RETURN      0
; end of _lcd_display_out

_bit_walk:

;knight_rider.c,112 :: 		void bit_walk(int delay) {
;knight_rider.c,113 :: 		PORTC = number; // set PORTA to number
	MOVF        _number+0, 0 
	MOVWF       PORTC+0 
;knight_rider.c,114 :: 		vdelay_ms(delay);
	MOVF        FARG_bit_walk_delay+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        FARG_bit_walk_delay+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;knight_rider.c,115 :: 		number *= 2; // multiply decimal by 2 to move bit left one character
	RLCF        _number+0, 1 
	BCF         _number+0, 0 
	RLCF        _number+1, 1 
;knight_rider.c,116 :: 		}
L_end_bit_walk:
	RETURN      0
; end of _bit_walk

_reverse_bit_walk:

;knight_rider.c,118 :: 		void reverse_bit_walk(int delay) {
;knight_rider.c,119 :: 		PORTC = number; // set PORTA to number
	MOVF        _number+0, 0 
	MOVWF       PORTC+0 
;knight_rider.c,120 :: 		vdelay_ms(delay);
	MOVF        FARG_reverse_bit_walk_delay+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        FARG_reverse_bit_walk_delay+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;knight_rider.c,121 :: 		number /= 2; // multiply decimal by 2 to move bit left one character
	RRCF        _number+1, 1 
	RRCF        _number+0, 1 
	BCF         _number+1, 7 
	BTFSC       _number+1, 6 
	BSF         _number+1, 7 
	BTFSS       _number+1, 7 
	GOTO        L__reverse_bit_walk28
	BTFSS       STATUS+0, 0 
	GOTO        L__reverse_bit_walk28
	INFSNZ      _number+0, 1 
	INCF        _number+1, 1 
L__reverse_bit_walk28:
;knight_rider.c,122 :: 		}
L_end_reverse_bit_walk:
	RETURN      0
; end of _reverse_bit_walk

_knight_rider:

;knight_rider.c,124 :: 		void knight_rider(int delay, bool is_variable) {
;knight_rider.c,125 :: 		iteration = 0;
	CLRF        _iteration+0 
	CLRF        _iteration+1 
;knight_rider.c,126 :: 		if (is_variable) {
	MOVF        FARG_knight_rider_is_variable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_knight_rider2
;knight_rider.c,127 :: 		max_iterations = 10000;  // increase iterations for variable run
	MOVLW       16
	MOVWF       _max_iterations+0 
	MOVLW       39
	MOVWF       _max_iterations+1 
;knight_rider.c,128 :: 		} else {
	GOTO        L_knight_rider3
L_knight_rider2:
;knight_rider.c,129 :: 		max_iterations = 15;
	MOVLW       15
	MOVWF       _max_iterations+0 
	MOVLW       0
	MOVWF       _max_iterations+1 
;knight_rider.c,130 :: 		}
L_knight_rider3:
;knight_rider.c,133 :: 		while (iteration <= max_iterations) {
L_knight_rider4:
	MOVF        _iteration+1, 0 
	SUBWF       _max_iterations+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__knight_rider30
	MOVF        _iteration+0, 0 
	SUBWF       _max_iterations+0, 0 
L__knight_rider30:
	BTFSS       STATUS+0, 0 
	GOTO        L_knight_rider5
;knight_rider.c,135 :: 		while (number != 128) {
L_knight_rider6:
	MOVLW       0
	XORWF       _number+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__knight_rider31
	MOVLW       128
	XORWF       _number+0, 0 
L__knight_rider31:
	BTFSC       STATUS+0, 2 
	GOTO        L_knight_rider7
;knight_rider.c,136 :: 		if (is_variable && delay >= 20) {
	MOVF        FARG_knight_rider_is_variable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_knight_rider10
	MOVLW       128
	XORWF       FARG_knight_rider_delay+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__knight_rider32
	MOVLW       20
	SUBWF       FARG_knight_rider_delay+0, 0 
L__knight_rider32:
	BTFSS       STATUS+0, 0 
	GOTO        L_knight_rider10
L__knight_rider19:
;knight_rider.c,137 :: 		delay -= 20;
	MOVLW       20
	SUBWF       FARG_knight_rider_delay+0, 1 
	MOVLW       0
	SUBWFB      FARG_knight_rider_delay+1, 1 
;knight_rider.c,138 :: 		}
L_knight_rider10:
;knight_rider.c,139 :: 		seven_seg_out();
	CALL        _seven_seg_out+0, 0
;knight_rider.c,140 :: 		bit_walk(delay);
	MOVF        FARG_knight_rider_delay+0, 0 
	MOVWF       FARG_bit_walk_delay+0 
	MOVF        FARG_knight_rider_delay+1, 0 
	MOVWF       FARG_bit_walk_delay+1 
	CALL        _bit_walk+0, 0
;knight_rider.c,141 :: 		iteration++;
	INFSNZ      _iteration+0, 1 
	INCF        _iteration+1, 1 
;knight_rider.c,142 :: 		}
	GOTO        L_knight_rider6
L_knight_rider7:
;knight_rider.c,145 :: 		while (number != 1) {
L_knight_rider11:
	MOVLW       0
	XORWF       _number+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__knight_rider33
	MOVLW       1
	XORWF       _number+0, 0 
L__knight_rider33:
	BTFSC       STATUS+0, 2 
	GOTO        L_knight_rider12
;knight_rider.c,146 :: 		if (is_variable && delay >= 20) {
	MOVF        FARG_knight_rider_is_variable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_knight_rider15
	MOVLW       128
	XORWF       FARG_knight_rider_delay+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__knight_rider34
	MOVLW       20
	SUBWF       FARG_knight_rider_delay+0, 0 
L__knight_rider34:
	BTFSS       STATUS+0, 0 
	GOTO        L_knight_rider15
L__knight_rider18:
;knight_rider.c,147 :: 		delay -= 20;
	MOVLW       20
	SUBWF       FARG_knight_rider_delay+0, 1 
	MOVLW       0
	SUBWFB      FARG_knight_rider_delay+1, 1 
;knight_rider.c,148 :: 		}
L_knight_rider15:
;knight_rider.c,149 :: 		seven_seg_out();
	CALL        _seven_seg_out+0, 0
;knight_rider.c,150 :: 		reverse_bit_walk(delay);
	MOVF        FARG_knight_rider_delay+0, 0 
	MOVWF       FARG_reverse_bit_walk_delay+0 
	MOVF        FARG_knight_rider_delay+1, 0 
	MOVWF       FARG_reverse_bit_walk_delay+1 
	CALL        _reverse_bit_walk+0, 0
;knight_rider.c,151 :: 		iteration++;
	INFSNZ      _iteration+0, 1 
	INCF        _iteration+1, 1 
;knight_rider.c,152 :: 		}
	GOTO        L_knight_rider11
L_knight_rider12:
;knight_rider.c,153 :: 		}
	GOTO        L_knight_rider4
L_knight_rider5:
;knight_rider.c,154 :: 		}
L_end_knight_rider:
	RETURN      0
; end of _knight_rider

_main:

;knight_rider.c,156 :: 		void main() {
;knight_rider.c,157 :: 		lcd_display_prep();
	CALL        _lcd_display_prep+0, 0
;knight_rider.c,158 :: 		seven_seg_prep();
	CALL        _seven_seg_prep+0, 0
;knight_rider.c,159 :: 		lcd_display_out(txt1, signature);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _signature+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;knight_rider.c,162 :: 		TRISC=0x00;       // same as above but with hex instead of binary
	CLRF        TRISC+0 
;knight_rider.c,163 :: 		PORTC=0b00000000; // clear port C (set all to logic low or 0 volts)
	CLRF        PORTC+0 
;knight_rider.c,168 :: 		while (1) {
L_main16:
;knight_rider.c,170 :: 		knight_rider(1, false);
	MOVLW       1
	MOVWF       FARG_knight_rider_delay+0 
	MOVLW       0
	MOVWF       FARG_knight_rider_delay+1 
	CLRF        FARG_knight_rider_is_variable+0 
	CALL        _knight_rider+0, 0
;knight_rider.c,182 :: 		}
	GOTO        L_main16
;knight_rider.c,183 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
