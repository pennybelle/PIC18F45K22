
_lcd_display_prep:

;for_loop_control.c,37 :: 		void lcd_display_prep() {
;for_loop_control.c,38 :: 		ANSELB = 0;                        // Configure PORTB pins as digital
	CLRF        ANSELB+0 
;for_loop_control.c,39 :: 		Lcd_Init();                        // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;for_loop_control.c,40 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;for_loop_control.c,41 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;for_loop_control.c,42 :: 		}
L_end_lcd_display_prep:
	RETURN      0
; end of _lcd_display_prep

_lcd_display_out:

;for_loop_control.c,45 :: 		void lcd_display_out(char first_line, char second_line) {
;for_loop_control.c,46 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;for_loop_control.c,47 :: 		Lcd_Out(1,1,first_line);                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_first_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;for_loop_control.c,49 :: 		Lcd_Out(2,1,second_line);                 // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_second_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;for_loop_control.c,50 :: 		}
L_end_lcd_display_out:
	RETURN      0
; end of _lcd_display_out

_default_pattern:

;for_loop_control.c,58 :: 		void default_pattern() {
;for_loop_control.c,59 :: 		for (j = 1; j <= 128; j = j+2) {
	MOVLW       1
	MOVWF       _j+0 
	MOVLW       0
	MOVWF       _j+1 
L_default_pattern0:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _j+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__default_pattern52
	MOVF        _j+0, 0 
	SUBLW       128
L__default_pattern52:
	BTFSS       STATUS+0, 0 
	GOTO        L_default_pattern1
;for_loop_control.c,60 :: 		PORTC = j;
	MOVF        _j+0, 0 
	MOVWF       PORTC+0 
;for_loop_control.c,61 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_default_pattern3:
	DECFSZ      R13, 1, 1
	BRA         L_default_pattern3
	DECFSZ      R12, 1, 1
	BRA         L_default_pattern3
	DECFSZ      R11, 1, 1
	BRA         L_default_pattern3
	NOP
	NOP
;for_loop_control.c,59 :: 		for (j = 1; j <= 128; j = j+2) {
	MOVLW       2
	ADDWF       _j+0, 1 
	MOVLW       0
	ADDWFC      _j+1, 1 
;for_loop_control.c,62 :: 		}
	GOTO        L_default_pattern0
L_default_pattern1:
;for_loop_control.c,64 :: 		for (j = 128; j >= 1; j= j/2) {
	MOVLW       128
	MOVWF       _j+0 
	MOVLW       0
	MOVWF       _j+1 
L_default_pattern4:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__default_pattern53
	MOVLW       1
	SUBWF       _j+0, 0 
L__default_pattern53:
	BTFSS       STATUS+0, 0 
	GOTO        L_default_pattern5
;for_loop_control.c,65 :: 		PORTC = j;
	MOVF        _j+0, 0 
	MOVWF       PORTC+0 
;for_loop_control.c,66 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_default_pattern7:
	DECFSZ      R13, 1, 1
	BRA         L_default_pattern7
	DECFSZ      R12, 1, 1
	BRA         L_default_pattern7
	DECFSZ      R11, 1, 1
	BRA         L_default_pattern7
	NOP
	NOP
;for_loop_control.c,64 :: 		for (j = 128; j >= 1; j= j/2) {
	RRCF        _j+1, 1 
	RRCF        _j+0, 1 
	BCF         _j+1, 7 
	BTFSC       _j+1, 6 
	BSF         _j+1, 7 
	BTFSS       _j+1, 7 
	GOTO        L__default_pattern54
	BTFSS       STATUS+0, 0 
	GOTO        L__default_pattern54
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
L__default_pattern54:
;for_loop_control.c,67 :: 		}
	GOTO        L_default_pattern4
L_default_pattern5:
;for_loop_control.c,68 :: 		}
L_end_default_pattern:
	RETURN      0
; end of _default_pattern

_binary_count_up:

;for_loop_control.c,71 :: 		void binary_count_up() {
;for_loop_control.c,72 :: 		for (j = 1; j <= 128; j = j++) {
	MOVLW       1
	MOVWF       _j+0 
	MOVLW       0
	MOVWF       _j+1 
L_binary_count_up8:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _j+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__binary_count_up56
	MOVF        _j+0, 0 
	SUBLW       128
L__binary_count_up56:
	BTFSS       STATUS+0, 0 
	GOTO        L_binary_count_up9
;for_loop_control.c,73 :: 		PORTC = j;
	MOVF        _j+0, 0 
	MOVWF       PORTC+0 
;for_loop_control.c,74 :: 		delay_ms(469);  // close as i can get to the cycle being exactly 60s
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       195
	MOVWF       R12, 0
	MOVLW       41
	MOVWF       R13, 0
L_binary_count_up11:
	DECFSZ      R13, 1, 1
	BRA         L_binary_count_up11
	DECFSZ      R12, 1, 1
	BRA         L_binary_count_up11
	DECFSZ      R11, 1, 1
	BRA         L_binary_count_up11
;for_loop_control.c,72 :: 		for (j = 1; j <= 128; j = j++) {
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;for_loop_control.c,75 :: 		}
	GOTO        L_binary_count_up8
L_binary_count_up9:
;for_loop_control.c,76 :: 		}
L_end_binary_count_up:
	RETURN      0
; end of _binary_count_up

_binary_count_down:

;for_loop_control.c,79 :: 		void binary_count_down() {
;for_loop_control.c,80 :: 		for (j = 128; j >= 1; j= j--) {
	MOVLW       128
	MOVWF       _j+0 
	MOVLW       0
	MOVWF       _j+1 
L_binary_count_down12:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__binary_count_down58
	MOVLW       1
	SUBWF       _j+0, 0 
L__binary_count_down58:
	BTFSS       STATUS+0, 0 
	GOTO        L_binary_count_down13
;for_loop_control.c,81 :: 		PORTC = j;
	MOVF        _j+0, 0 
	MOVWF       PORTC+0 
;for_loop_control.c,82 :: 		delay_ms(469);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       195
	MOVWF       R12, 0
	MOVLW       41
	MOVWF       R13, 0
L_binary_count_down15:
	DECFSZ      R13, 1, 1
	BRA         L_binary_count_down15
	DECFSZ      R12, 1, 1
	BRA         L_binary_count_down15
	DECFSZ      R11, 1, 1
	BRA         L_binary_count_down15
;for_loop_control.c,80 :: 		for (j = 128; j >= 1; j= j--) {
	MOVLW       1
	SUBWF       _j+0, 1 
	MOVLW       0
	SUBWFB      _j+1, 1 
;for_loop_control.c,83 :: 		}
	GOTO        L_binary_count_down12
L_binary_count_down13:
;for_loop_control.c,84 :: 		}
L_end_binary_count_down:
	RETURN      0
; end of _binary_count_down

_knight_rider:

;for_loop_control.c,87 :: 		void knight_rider() {
;for_loop_control.c,88 :: 		for (j = 1; j <= 128; j = j*2) {
	MOVLW       1
	MOVWF       _j+0 
	MOVLW       0
	MOVWF       _j+1 
L_knight_rider16:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _j+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__knight_rider60
	MOVF        _j+0, 0 
	SUBLW       128
L__knight_rider60:
	BTFSS       STATUS+0, 0 
	GOTO        L_knight_rider17
;for_loop_control.c,89 :: 		PORTC = j;
	MOVF        _j+0, 0 
	MOVWF       PORTC+0 
;for_loop_control.c,90 :: 		delay_ms(8);
	MOVLW       21
	MOVWF       R12, 0
	MOVLW       198
	MOVWF       R13, 0
L_knight_rider19:
	DECFSZ      R13, 1, 1
	BRA         L_knight_rider19
	DECFSZ      R12, 1, 1
	BRA         L_knight_rider19
	NOP
;for_loop_control.c,88 :: 		for (j = 1; j <= 128; j = j*2) {
	RLCF        _j+0, 1 
	BCF         _j+0, 0 
	RLCF        _j+1, 1 
;for_loop_control.c,91 :: 		}
	GOTO        L_knight_rider16
L_knight_rider17:
;for_loop_control.c,93 :: 		for (j = 128; j >= 1; j= j/2) {
	MOVLW       128
	MOVWF       _j+0 
	MOVLW       0
	MOVWF       _j+1 
L_knight_rider20:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__knight_rider61
	MOVLW       1
	SUBWF       _j+0, 0 
L__knight_rider61:
	BTFSS       STATUS+0, 0 
	GOTO        L_knight_rider21
;for_loop_control.c,94 :: 		PORTC = j;
	MOVF        _j+0, 0 
	MOVWF       PORTC+0 
;for_loop_control.c,95 :: 		delay_ms(8);
	MOVLW       21
	MOVWF       R12, 0
	MOVLW       198
	MOVWF       R13, 0
L_knight_rider23:
	DECFSZ      R13, 1, 1
	BRA         L_knight_rider23
	DECFSZ      R12, 1, 1
	BRA         L_knight_rider23
	NOP
;for_loop_control.c,93 :: 		for (j = 128; j >= 1; j= j/2) {
	RRCF        _j+1, 1 
	RRCF        _j+0, 1 
	BCF         _j+1, 7 
	BTFSC       _j+1, 6 
	BSF         _j+1, 7 
	BTFSS       _j+1, 7 
	GOTO        L__knight_rider62
	BTFSS       STATUS+0, 0 
	GOTO        L__knight_rider62
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
L__knight_rider62:
;for_loop_control.c,96 :: 		}
	GOTO        L_knight_rider20
L_knight_rider21:
;for_loop_control.c,97 :: 		}
L_end_knight_rider:
	RETURN      0
; end of _knight_rider

_only_evens:

;for_loop_control.c,100 :: 		void only_evens() {
;for_loop_control.c,101 :: 		for (j = 2; j <= 128; j = j+2) {
	MOVLW       2
	MOVWF       _j+0 
	MOVLW       0
	MOVWF       _j+1 
L_only_evens24:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _j+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__only_evens64
	MOVF        _j+0, 0 
	SUBLW       128
L__only_evens64:
	BTFSS       STATUS+0, 0 
	GOTO        L_only_evens25
;for_loop_control.c,102 :: 		PORTC = j;
	MOVF        _j+0, 0 
	MOVWF       PORTC+0 
;for_loop_control.c,103 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_only_evens27:
	DECFSZ      R13, 1, 1
	BRA         L_only_evens27
	DECFSZ      R12, 1, 1
	BRA         L_only_evens27
	DECFSZ      R11, 1, 1
	BRA         L_only_evens27
	NOP
	NOP
;for_loop_control.c,101 :: 		for (j = 2; j <= 128; j = j+2) {
	MOVLW       2
	ADDWF       _j+0, 1 
	MOVLW       0
	ADDWFC      _j+1, 1 
;for_loop_control.c,104 :: 		}
	GOTO        L_only_evens24
L_only_evens25:
;for_loop_control.c,106 :: 		for (j = 128; j >= 2; j= j-2) {
	MOVLW       128
	MOVWF       _j+0 
	MOVLW       0
	MOVWF       _j+1 
L_only_evens28:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__only_evens65
	MOVLW       2
	SUBWF       _j+0, 0 
L__only_evens65:
	BTFSS       STATUS+0, 0 
	GOTO        L_only_evens29
;for_loop_control.c,107 :: 		PORTC = j;
	MOVF        _j+0, 0 
	MOVWF       PORTC+0 
;for_loop_control.c,108 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_only_evens31:
	DECFSZ      R13, 1, 1
	BRA         L_only_evens31
	DECFSZ      R12, 1, 1
	BRA         L_only_evens31
	DECFSZ      R11, 1, 1
	BRA         L_only_evens31
	NOP
	NOP
;for_loop_control.c,106 :: 		for (j = 128; j >= 2; j= j-2) {
	MOVLW       2
	SUBWF       _j+0, 1 
	MOVLW       0
	SUBWFB      _j+1, 1 
;for_loop_control.c,109 :: 		}
	GOTO        L_only_evens28
L_only_evens29:
;for_loop_control.c,110 :: 		}
L_end_only_evens:
	RETURN      0
; end of _only_evens

_only_odds:

;for_loop_control.c,113 :: 		void only_odds() {
;for_loop_control.c,115 :: 		for (j = 1; j <= 127; j = j+2) {
	MOVLW       1
	MOVWF       _j+0 
	MOVLW       0
	MOVWF       _j+1 
L_only_odds32:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _j+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__only_odds67
	MOVF        _j+0, 0 
	SUBLW       127
L__only_odds67:
	BTFSS       STATUS+0, 0 
	GOTO        L_only_odds33
;for_loop_control.c,116 :: 		PORTC = j;
	MOVF        _j+0, 0 
	MOVWF       PORTC+0 
;for_loop_control.c,117 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_only_odds35:
	DECFSZ      R13, 1, 1
	BRA         L_only_odds35
	DECFSZ      R12, 1, 1
	BRA         L_only_odds35
	DECFSZ      R11, 1, 1
	BRA         L_only_odds35
	NOP
	NOP
;for_loop_control.c,115 :: 		for (j = 1; j <= 127; j = j+2) {
	MOVLW       2
	ADDWF       _j+0, 1 
	MOVLW       0
	ADDWFC      _j+1, 1 
;for_loop_control.c,118 :: 		}
	GOTO        L_only_odds32
L_only_odds33:
;for_loop_control.c,120 :: 		for (j = 127; j >= 1; j= j-2) {
	MOVLW       127
	MOVWF       _j+0 
	MOVLW       0
	MOVWF       _j+1 
L_only_odds36:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__only_odds68
	MOVLW       1
	SUBWF       _j+0, 0 
L__only_odds68:
	BTFSS       STATUS+0, 0 
	GOTO        L_only_odds37
;for_loop_control.c,121 :: 		PORTC = j;
	MOVF        _j+0, 0 
	MOVWF       PORTC+0 
;for_loop_control.c,122 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_only_odds39:
	DECFSZ      R13, 1, 1
	BRA         L_only_odds39
	DECFSZ      R12, 1, 1
	BRA         L_only_odds39
	DECFSZ      R11, 1, 1
	BRA         L_only_odds39
	NOP
	NOP
;for_loop_control.c,120 :: 		for (j = 127; j >= 1; j= j-2) {
	MOVLW       2
	SUBWF       _j+0, 1 
	MOVLW       0
	SUBWFB      _j+1, 1 
;for_loop_control.c,123 :: 		}
	GOTO        L_only_odds36
L_only_odds37:
;for_loop_control.c,124 :: 		}
L_end_only_odds:
	RETURN      0
; end of _only_odds

_main:

;for_loop_control.c,127 :: 		void main() {
;for_loop_control.c,128 :: 		lcd_display_prep();
	CALL        _lcd_display_prep+0, 0
;for_loop_control.c,129 :: 		lcd_display_out(txt1, signature);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _signature+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;for_loop_control.c,132 :: 		TRISC = 0x00;
	CLRF        TRISC+0 
;for_loop_control.c,133 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;for_loop_control.c,135 :: 		delay_ms(2000); // wait for plug
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main40:
	DECFSZ      R13, 1, 1
	BRA         L_main40
	DECFSZ      R12, 1, 1
	BRA         L_main40
	DECFSZ      R11, 1, 1
	BRA         L_main40
	NOP
;for_loop_control.c,137 :: 		while(1) {
L_main41:
;for_loop_control.c,138 :: 		PORTC = 0x00; // reset output each loop
	CLRF        PORTC+0 
;for_loop_control.c,140 :: 		lcd_display_out(txt1, txt2);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _txt2+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;for_loop_control.c,141 :: 		default_pattern();
	CALL        _default_pattern+0, 0
;for_loop_control.c,142 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;for_loop_control.c,143 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main43:
	DECFSZ      R13, 1, 1
	BRA         L_main43
	DECFSZ      R12, 1, 1
	BRA         L_main43
	DECFSZ      R11, 1, 1
	BRA         L_main43
	NOP
;for_loop_control.c,145 :: 		lcd_display_out(txt1, txt3);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _txt3+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;for_loop_control.c,146 :: 		binary_count_up();
	CALL        _binary_count_up+0, 0
;for_loop_control.c,147 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main44:
	DECFSZ      R13, 1, 1
	BRA         L_main44
	DECFSZ      R12, 1, 1
	BRA         L_main44
	DECFSZ      R11, 1, 1
	BRA         L_main44
	NOP
;for_loop_control.c,149 :: 		lcd_display_out(txt1, txt4);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _txt4+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;for_loop_control.c,150 :: 		binary_count_down();
	CALL        _binary_count_down+0, 0
;for_loop_control.c,151 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main45:
	DECFSZ      R13, 1, 1
	BRA         L_main45
	DECFSZ      R12, 1, 1
	BRA         L_main45
	DECFSZ      R11, 1, 1
	BRA         L_main45
	NOP
;for_loop_control.c,153 :: 		lcd_display_out(txt1, txt5);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _txt5+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;for_loop_control.c,154 :: 		knight_rider();
	CALL        _knight_rider+0, 0
;for_loop_control.c,155 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main46:
	DECFSZ      R13, 1, 1
	BRA         L_main46
	DECFSZ      R12, 1, 1
	BRA         L_main46
	DECFSZ      R11, 1, 1
	BRA         L_main46
	NOP
;for_loop_control.c,157 :: 		lcd_display_out(txt1, txt6);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _txt6+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;for_loop_control.c,158 :: 		only_evens();
	CALL        _only_evens+0, 0
;for_loop_control.c,159 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main47:
	DECFSZ      R13, 1, 1
	BRA         L_main47
	DECFSZ      R12, 1, 1
	BRA         L_main47
	DECFSZ      R11, 1, 1
	BRA         L_main47
	NOP
;for_loop_control.c,161 :: 		lcd_display_out(txt1, txt7);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _txt7+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;for_loop_control.c,162 :: 		only_odds();
	CALL        _only_odds+0, 0
;for_loop_control.c,163 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main48:
	DECFSZ      R13, 1, 1
	BRA         L_main48
	DECFSZ      R12, 1, 1
	BRA         L_main48
	DECFSZ      R11, 1, 1
	BRA         L_main48
	NOP
;for_loop_control.c,164 :: 		}
	GOTO        L_main41
;for_loop_control.c,165 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
