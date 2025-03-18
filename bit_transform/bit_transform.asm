
_interrupt:

;bit_transform.c,46 :: 		void interrupt() {
;bit_transform.c,47 :: 		LATA = 0;                             // Turn off all 7seg displays
	CLRF        LATA+0 
;bit_transform.c,48 :: 		LATD = portd_array[portd_index];      // bring appropriate value to PORTD
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
;bit_transform.c,49 :: 		LATA = shifter;                       // turn on appropriate 7seg. display
	MOVF        _shifter+0, 0 
	MOVWF       LATA+0 
;bit_transform.c,52 :: 		shifter <<= 1;
	MOVF        _shifter+0, 0 
	MOVWF       R1 
	RLCF        R1, 1 
	BCF         R1, 0 
	MOVF        R1, 0 
	MOVWF       _shifter+0 
;bit_transform.c,53 :: 		if (shifter > 8u)
	MOVF        R1, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt0
;bit_transform.c,54 :: 		shifter = 1;
	MOVLW       1
	MOVWF       _shifter+0 
L_interrupt0:
;bit_transform.c,57 :: 		portd_index++ ;
	INCF        _portd_index+0, 1 
;bit_transform.c,58 :: 		if (portd_index > 3u)
	MOVF        _portd_index+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
;bit_transform.c,59 :: 		portd_index = 0;             // turn on 1st, turn off 2nd 7seg.
	CLRF        _portd_index+0 
L_interrupt1:
;bit_transform.c,60 :: 		TMR0L  =   0;                  // reset TIMER0 value
	CLRF        TMR0L+0 
;bit_transform.c,61 :: 		TMR0IF_bit = 0;                // Clear TMR0IF
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;bit_transform.c,62 :: 		}
L_end_interrupt:
L__interrupt21:
	RETFIE      1
; end of _interrupt

_lcd_display_prep:

;bit_transform.c,64 :: 		void lcd_display_prep() {
;bit_transform.c,65 :: 		ANSELB = 0;                        // Configure PORTB pins as digital
	CLRF        ANSELB+0 
;bit_transform.c,66 :: 		Lcd_Init();                        // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;bit_transform.c,67 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;bit_transform.c,68 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;bit_transform.c,69 :: 		}
L_end_lcd_display_prep:
	RETURN      0
; end of _lcd_display_prep

_seven_seg_prep:

;bit_transform.c,71 :: 		void seven_seg_prep() {
;bit_transform.c,72 :: 		ANSELA = 0;                    // Configure PORTA pins as digital
	CLRF        ANSELA+0 
;bit_transform.c,73 :: 		ANSELD = 0;                    // Configure PORTD pins as digital
	CLRF        ANSELD+0 
;bit_transform.c,75 :: 		TRISA = 0;                     // Configure PORTA as output
	CLRF        TRISA+0 
;bit_transform.c,76 :: 		LATA  = 0;                     // Clear PORTA
	CLRF        LATA+0 
;bit_transform.c,77 :: 		TRISD = 0;                     // Configure PORTD as output
	CLRF        TRISD+0 
;bit_transform.c,78 :: 		LATD  = 0;                     // Clear PORTD
	CLRF        LATD+0 
;bit_transform.c,80 :: 		T0CON = 0xC4;                  // Set TMR0 in 8bit mode, assign prescaler to TMR0
	MOVLW       196
	MOVWF       T0CON+0 
;bit_transform.c,81 :: 		TMR0L = 0;                     // clear TMROL
	CLRF        TMR0L+0 
;bit_transform.c,82 :: 		digit = 0;
	CLRF        _digit+0 
	CLRF        _digit+1 
;bit_transform.c,83 :: 		portd_index = 0;
	CLRF        _portd_index+0 
;bit_transform.c,84 :: 		shifter = 1;
	MOVLW       1
	MOVWF       _shifter+0 
;bit_transform.c,86 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;bit_transform.c,87 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;bit_transform.c,88 :: 		}
L_end_seven_seg_prep:
	RETURN      0
; end of _seven_seg_prep

_bit_walk_prep:

;bit_transform.c,90 :: 		void bit_walk_prep() {
;bit_transform.c,91 :: 		TRISC = 0x00; // set direction of data traffic to output
	CLRF        TRISC+0 
;bit_transform.c,92 :: 		}
L_end_bit_walk_prep:
	RETURN      0
; end of _bit_walk_prep

_lcd_display_out:

;bit_transform.c,94 :: 		void lcd_display_out(char first_line, char second_line) {
;bit_transform.c,95 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;bit_transform.c,96 :: 		Lcd_Out(1,1,first_line);                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_first_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;bit_transform.c,98 :: 		Lcd_Out(2,1,second_line);                 // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_second_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;bit_transform.c,99 :: 		}
L_end_lcd_display_out:
	RETURN      0
; end of _lcd_display_out

_seven_seg_out:

;bit_transform.c,101 :: 		void seven_seg_out() {
;bit_transform.c,102 :: 		digit = number / 1000u ;             // extract thousands digit
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
;bit_transform.c,103 :: 		portd_array[3] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+3 
;bit_transform.c,104 :: 		digit = (number / 100u) % 10u;       // extract hundreds digit
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
;bit_transform.c,105 :: 		portd_array[2] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+2 
;bit_transform.c,106 :: 		digit = (number / 10u) % 10u;        // extract tens digit
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
;bit_transform.c,107 :: 		portd_array[1] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+1 
;bit_transform.c,108 :: 		digit = number % 10u;                // extract ones digit
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
;bit_transform.c,109 :: 		portd_array[0] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+0 
;bit_transform.c,110 :: 		}
L_end_seven_seg_out:
	RETURN      0
; end of _seven_seg_out

_bit_walk:

;bit_transform.c,112 :: 		void bit_walk(int delay_time) {
;bit_transform.c,113 :: 		PORTC = number; // set PORTA to number, initually 1 or 0b00000001
	MOVF        _number+0, 0 
	MOVWF       PORTC+0 
;bit_transform.c,114 :: 		vdelay_ms(delay_time);
	MOVF        FARG_bit_walk_delay_time+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        FARG_bit_walk_delay_time+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;bit_transform.c,115 :: 		number *= 2; // multiply decimal by 2 to move bit left one character
	RLCF        _number+0, 1 
	BCF         _number+0, 0 
	RLCF        _number+1, 1 
;bit_transform.c,119 :: 		}
L_end_bit_walk:
	RETURN      0
; end of _bit_walk

_reverse_bit_walk:

;bit_transform.c,121 :: 		void reverse_bit_walk(int delay_time) {
;bit_transform.c,123 :: 		PORTC = number; // set PORTA to number, initually 1 or 0b00000001
	MOVF        _number+0, 0 
	MOVWF       PORTC+0 
;bit_transform.c,124 :: 		vdelay_ms(delay_time);
	MOVF        FARG_reverse_bit_walk_delay_time+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        FARG_reverse_bit_walk_delay_time+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;bit_transform.c,125 :: 		number /= 2; // multiply decimal by 2 to move bit left one character
	RRCF        _number+1, 1 
	RRCF        _number+0, 1 
	BCF         _number+1, 7 
	BTFSC       _number+1, 6 
	BSF         _number+1, 7 
	BTFSS       _number+1, 7 
	GOTO        L__reverse_bit_walk29
	BTFSS       STATUS+0, 0 
	GOTO        L__reverse_bit_walk29
	INFSNZ      _number+0, 1 
	INCF        _number+1, 1 
L__reverse_bit_walk29:
;bit_transform.c,129 :: 		}
L_end_reverse_bit_walk:
	RETURN      0
; end of _reverse_bit_walk

_bit_climb:

;bit_transform.c,131 :: 		void bit_climb(int delay_time) {
;bit_transform.c,133 :: 		PORTC = number; // set PORTA to number, initually 1 or 0b00000001
	MOVF        _number+0, 0 
	MOVWF       PORTC+0 
;bit_transform.c,134 :: 		vdelay_ms(delay_time);
	MOVF        FARG_bit_climb_delay_time+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        FARG_bit_climb_delay_time+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;bit_transform.c,135 :: 		number += 1; // add 1 to decimal value to show binary value climb
	INFSNZ      _number+0, 1 
	INCF        _number+1, 1 
;bit_transform.c,139 :: 		}
L_end_bit_climb:
	RETURN      0
; end of _bit_climb

_reset_prog:

;bit_transform.c,141 :: 		void reset_prog() {
;bit_transform.c,142 :: 		number = 1;
	MOVLW       1
	MOVWF       _number+0 
	MOVLW       0
	MOVWF       _number+1 
;bit_transform.c,143 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_reset_prog2:
	DECFSZ      R13, 1, 1
	BRA         L_reset_prog2
	DECFSZ      R12, 1, 1
	BRA         L_reset_prog2
	DECFSZ      R11, 1, 1
	BRA         L_reset_prog2
	NOP
;bit_transform.c,144 :: 		}
L_end_reset_prog:
	RETURN      0
; end of _reset_prog

_number_check:

;bit_transform.c,146 :: 		void number_check(int n) {
;bit_transform.c,147 :: 		if ( number != n ) {
	MOVF        _number+1, 0 
	XORWF       FARG_number_check_n+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__number_check33
	MOVF        FARG_number_check_n+0, 0 
	XORWF       _number+0, 0 
L__number_check33:
	BTFSC       STATUS+0, 2 
	GOTO        L_number_check3
;bit_transform.c,148 :: 		number = n;
	MOVF        FARG_number_check_n+0, 0 
	MOVWF       _number+0 
	MOVF        FARG_number_check_n+1, 0 
	MOVWF       _number+1 
;bit_transform.c,149 :: 		}
L_number_check3:
;bit_transform.c,150 :: 		}
L_end_number_check:
	RETURN      0
; end of _number_check

_main:

;bit_transform.c,152 :: 		int main() {
;bit_transform.c,153 :: 		lcd_display_prep();
	CALL        _lcd_display_prep+0, 0
;bit_transform.c,154 :: 		seven_seg_prep();
	CALL        _seven_seg_prep+0, 0
;bit_transform.c,155 :: 		bit_walk_prep();
	CALL        _bit_walk_prep+0, 0
;bit_transform.c,157 :: 		while(1){
L_main4:
;bit_transform.c,159 :: 		number_check(1);
	MOVLW       1
	MOVWF       FARG_number_check_n+0 
	MOVLW       0
	MOVWF       FARG_number_check_n+1 
	CALL        _number_check+0, 0
;bit_transform.c,160 :: 		lcd_display_out(txt1, empty_txt);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _empty_txt+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;bit_transform.c,161 :: 		while(number <= 128) {
L_main6:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _number+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main35
	MOVF        _number+0, 0 
	SUBLW       128
L__main35:
	BTFSS       STATUS+0, 0 
	GOTO        L_main7
;bit_transform.c,162 :: 		seven_seg_out();
	CALL        _seven_seg_out+0, 0
;bit_transform.c,163 :: 		bit_walk(750); // parameter is delay in milliseconds
	MOVLW       238
	MOVWF       FARG_bit_walk_delay_time+0 
	MOVLW       2
	MOVWF       FARG_bit_walk_delay_time+1 
	CALL        _bit_walk+0, 0
;bit_transform.c,164 :: 		}
	GOTO        L_main6
L_main7:
;bit_transform.c,165 :: 		delay_ms(2000); // dont reset to 1, instead walk bit back
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	DECFSZ      R11, 1, 1
	BRA         L_main8
	NOP
;bit_transform.c,168 :: 		number_check(128);
	MOVLW       128
	MOVWF       FARG_number_check_n+0 
	MOVLW       0
	MOVWF       FARG_number_check_n+1 
	CALL        _number_check+0, 0
;bit_transform.c,169 :: 		lcd_display_out(txt3, empty_txt);
	MOVLW       _txt3+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _empty_txt+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;bit_transform.c,170 :: 		while(number >= 1) {
L_main9:
	MOVLW       128
	XORWF       _number+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main36
	MOVLW       1
	SUBWF       _number+0, 0 
L__main36:
	BTFSS       STATUS+0, 0 
	GOTO        L_main10
;bit_transform.c,171 :: 		seven_seg_out();
	CALL        _seven_seg_out+0, 0
;bit_transform.c,172 :: 		reverse_bit_walk(750);
	MOVLW       238
	MOVWF       FARG_reverse_bit_walk_delay_time+0 
	MOVLW       2
	MOVWF       FARG_reverse_bit_walk_delay_time+1 
	CALL        _reverse_bit_walk+0, 0
;bit_transform.c,173 :: 		}
	GOTO        L_main9
L_main10:
;bit_transform.c,174 :: 		reset_prog();
	CALL        _reset_prog+0, 0
;bit_transform.c,177 :: 		lcd_display_out(txt4, empty_txt);
	MOVLW       _txt4+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _empty_txt+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;bit_transform.c,178 :: 		while (iteration_count > 0) {
L_main11:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _iteration_count+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main37
	MOVF        _iteration_count+0, 0 
	SUBLW       0
L__main37:
	BTFSC       STATUS+0, 0 
	GOTO        L_main12
;bit_transform.c,179 :: 		number_check(1);
	MOVLW       1
	MOVWF       FARG_number_check_n+0 
	MOVLW       0
	MOVWF       FARG_number_check_n+1 
	CALL        _number_check+0, 0
;bit_transform.c,180 :: 		while(number <= 128) {
L_main13:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _number+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main38
	MOVF        _number+0, 0 
	SUBLW       128
L__main38:
	BTFSS       STATUS+0, 0 
	GOTO        L_main14
;bit_transform.c,181 :: 		seven_seg_out();
	CALL        _seven_seg_out+0, 0
;bit_transform.c,182 :: 		bit_walk(new_delay); // parameter is delay in milliseconds
	MOVF        _new_delay+0, 0 
	MOVWF       FARG_bit_walk_delay_time+0 
	MOVF        _new_delay+1, 0 
	MOVWF       FARG_bit_walk_delay_time+1 
	CALL        _bit_walk+0, 0
;bit_transform.c,183 :: 		}
	GOTO        L_main13
L_main14:
;bit_transform.c,189 :: 		if (new_delay >= 100) {
	MOVLW       128
	XORWF       _new_delay+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main39
	MOVLW       100
	SUBWF       _new_delay+0, 0 
L__main39:
	BTFSS       STATUS+0, 0 
	GOTO        L_main15
;bit_transform.c,190 :: 		new_delay = new_delay - 100;
	MOVLW       100
	SUBWF       _new_delay+0, 1 
	MOVLW       0
	SUBWFB      _new_delay+1, 1 
;bit_transform.c,191 :: 		} else if (new_delay < 100) {
	GOTO        L_main16
L_main15:
	MOVLW       128
	XORWF       _new_delay+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main40
	MOVLW       100
	SUBWF       _new_delay+0, 0 
L__main40:
	BTFSC       STATUS+0, 0 
	GOTO        L_main17
;bit_transform.c,192 :: 		new_delay = 0;
	CLRF        _new_delay+0 
	CLRF        _new_delay+1 
;bit_transform.c,193 :: 		}
L_main17:
L_main16:
;bit_transform.c,194 :: 		iteration_count--;
	MOVLW       1
	SUBWF       _iteration_count+0, 1 
	MOVLW       0
	SUBWFB      _iteration_count+1, 1 
;bit_transform.c,195 :: 		}
	GOTO        L_main11
L_main12:
;bit_transform.c,196 :: 		new_delay = 500;
	MOVLW       244
	MOVWF       _new_delay+0 
	MOVLW       1
	MOVWF       _new_delay+1 
;bit_transform.c,197 :: 		iteration_count = 1000;
	MOVLW       232
	MOVWF       _iteration_count+0 
	MOVLW       3
	MOVWF       _iteration_count+1 
;bit_transform.c,198 :: 		reset_prog();
	CALL        _reset_prog+0, 0
;bit_transform.c,201 :: 		number_check(1);
	MOVLW       1
	MOVWF       FARG_number_check_n+0 
	MOVLW       0
	MOVWF       FARG_number_check_n+1 
	CALL        _number_check+0, 0
;bit_transform.c,202 :: 		lcd_display_out(txt2, empty_txt);
	MOVLW       _txt2+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _empty_txt+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;bit_transform.c,203 :: 		while (number < 256 ) {
L_main18:
	MOVLW       128
	XORWF       _number+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main41
	MOVLW       0
	SUBWF       _number+0, 0 
L__main41:
	BTFSC       STATUS+0, 0 
	GOTO        L_main19
;bit_transform.c,204 :: 		bit_climb(50); // parameter is delay in milliseconds
	MOVLW       50
	MOVWF       FARG_bit_climb_delay_time+0 
	MOVLW       0
	MOVWF       FARG_bit_climb_delay_time+1 
	CALL        _bit_climb+0, 0
;bit_transform.c,205 :: 		seven_seg_out();
	CALL        _seven_seg_out+0, 0
;bit_transform.c,206 :: 		}
	GOTO        L_main18
L_main19:
;bit_transform.c,207 :: 		reset_prog();
	CALL        _reset_prog+0, 0
;bit_transform.c,208 :: 		}
	GOTO        L_main4
;bit_transform.c,210 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
