
_lcd_display_prep:

;case_statements.c,31 :: 		void lcd_display_prep() {
;case_statements.c,32 :: 		ANSELB = 0;                        // Configure PORTB pins as digital
	CLRF        ANSELB+0 
;case_statements.c,33 :: 		Lcd_Init();                        // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;case_statements.c,34 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;case_statements.c,35 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;case_statements.c,36 :: 		}
L_end_lcd_display_prep:
	RETURN      0
; end of _lcd_display_prep

_lcd_display_out:

;case_statements.c,39 :: 		void lcd_display_out(char first_line, char second_line) {
;case_statements.c,40 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;case_statements.c,41 :: 		Lcd_Out(1,1,first_line);                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_first_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;case_statements.c,43 :: 		Lcd_Out(2,1,second_line);                 // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_second_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;case_statements.c,44 :: 		}
L_end_lcd_display_out:
	RETURN      0
; end of _lcd_display_out

_first_thing:

;case_statements.c,52 :: 		void first_thing(int hex_num, int timer) {
;case_statements.c,53 :: 		PORTC = hex_num;
	MOVF        FARG_first_thing_hex_num+0, 0 
	MOVWF       PORTC+0 
;case_statements.c,54 :: 		vdelay_ms(timer);
	MOVF        FARG_first_thing_timer+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        FARG_first_thing_timer+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;case_statements.c,55 :: 		}
L_end_first_thing:
	RETURN      0
; end of _first_thing

_second_thing:

;case_statements.c,59 :: 		void second_thing(int hex_num1, int hex_num2) {
;case_statements.c,60 :: 		PORTC = hex_num1;
	MOVF        FARG_second_thing_hex_num1+0, 0 
	MOVWF       PORTC+0 
;case_statements.c,61 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_second_thing0:
	DECFSZ      R13, 1, 1
	BRA         L_second_thing0
	DECFSZ      R12, 1, 1
	BRA         L_second_thing0
	DECFSZ      R11, 1, 1
	BRA         L_second_thing0
	NOP
	NOP
;case_statements.c,62 :: 		PORTC = hex_num2;
	MOVF        FARG_second_thing_hex_num2+0, 0 
	MOVWF       PORTC+0 
;case_statements.c,63 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_second_thing1:
	DECFSZ      R13, 1, 1
	BRA         L_second_thing1
	DECFSZ      R12, 1, 1
	BRA         L_second_thing1
	DECFSZ      R11, 1, 1
	BRA         L_second_thing1
	NOP
	NOP
;case_statements.c,64 :: 		}
L_end_second_thing:
	RETURN      0
; end of _second_thing

_main:

;case_statements.c,78 :: 		void main() {
;case_statements.c,79 :: 		lcd_display_prep();
	CALL        _lcd_display_prep+0, 0
;case_statements.c,80 :: 		lcd_display_out(txt1, signature);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _signature+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;case_statements.c,83 :: 		TRISD = 0xFF;
	MOVLW       255
	MOVWF       TRISD+0 
;case_statements.c,84 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;case_statements.c,85 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;case_statements.c,88 :: 		TRISC = 0x00;
	CLRF        TRISC+0 
;case_statements.c,89 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;case_statements.c,91 :: 		while(1) {
L_main2:
;case_statements.c,92 :: 		switch(PORTD) {
	GOTO        L_main4
;case_statements.c,93 :: 		case 1: // if PORTD switch is in position 0b00000001
L_main6:
;case_statements.c,94 :: 		first_thing(0x55, 3000);
	MOVLW       85
	MOVWF       FARG_first_thing_hex_num+0 
	MOVLW       0
	MOVWF       FARG_first_thing_hex_num+1 
	MOVLW       184
	MOVWF       FARG_first_thing_timer+0 
	MOVLW       11
	MOVWF       FARG_first_thing_timer+1 
	CALL        _first_thing+0, 0
;case_statements.c,95 :: 		break;
	GOTO        L_main5
;case_statements.c,97 :: 		case 2: // PORTD == 0b00000010
L_main7:
;case_statements.c,98 :: 		first_thing(0xAA, 3000);
	MOVLW       170
	MOVWF       FARG_first_thing_hex_num+0 
	MOVLW       0
	MOVWF       FARG_first_thing_hex_num+1 
	MOVLW       184
	MOVWF       FARG_first_thing_timer+0 
	MOVLW       11
	MOVWF       FARG_first_thing_timer+1 
	CALL        _first_thing+0, 0
;case_statements.c,99 :: 		break;
	GOTO        L_main5
;case_statements.c,101 :: 		case 4: // PORTD == 0b00000100
L_main8:
;case_statements.c,102 :: 		first_thing(0xF0, 2000);
	MOVLW       240
	MOVWF       FARG_first_thing_hex_num+0 
	MOVLW       0
	MOVWF       FARG_first_thing_hex_num+1 
	MOVLW       208
	MOVWF       FARG_first_thing_timer+0 
	MOVLW       7
	MOVWF       FARG_first_thing_timer+1 
	CALL        _first_thing+0, 0
;case_statements.c,103 :: 		break;
	GOTO        L_main5
;case_statements.c,105 :: 		case 8: // PORTD == 0b00001000
L_main9:
;case_statements.c,106 :: 		second_thing(0xFF, 0x00);
	MOVLW       255
	MOVWF       FARG_second_thing_hex_num1+0 
	MOVLW       0
	MOVWF       FARG_second_thing_hex_num1+1 
	CLRF        FARG_second_thing_hex_num2+0 
	CLRF        FARG_second_thing_hex_num2+1 
	CALL        _second_thing+0, 0
;case_statements.c,107 :: 		break;
	GOTO        L_main5
;case_statements.c,109 :: 		case 16: // PORTD == 0b00010000
L_main10:
;case_statements.c,110 :: 		second_thing(0xAA, 0x55);
	MOVLW       170
	MOVWF       FARG_second_thing_hex_num1+0 
	MOVLW       0
	MOVWF       FARG_second_thing_hex_num1+1 
	MOVLW       85
	MOVWF       FARG_second_thing_hex_num2+0 
	MOVLW       0
	MOVWF       FARG_second_thing_hex_num2+1 
	CALL        _second_thing+0, 0
;case_statements.c,111 :: 		break;
	GOTO        L_main5
;case_statements.c,113 :: 		case 32: // PORTD == 0b00100000
L_main11:
;case_statements.c,114 :: 		second_thing(0xF0, 0x0F);
	MOVLW       240
	MOVWF       FARG_second_thing_hex_num1+0 
	MOVLW       0
	MOVWF       FARG_second_thing_hex_num1+1 
	MOVLW       15
	MOVWF       FARG_second_thing_hex_num2+0 
	MOVLW       0
	MOVWF       FARG_second_thing_hex_num2+1 
	CALL        _second_thing+0, 0
;case_statements.c,115 :: 		break;
	GOTO        L_main5
;case_statements.c,117 :: 		case 64: // PORTD == 0b01000000
L_main12:
;case_statements.c,118 :: 		PORTC = 0x81;
	MOVLW       129
	MOVWF       PORTC+0 
;case_statements.c,119 :: 		delay_ms(3000);
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L_main13:
	DECFSZ      R13, 1, 1
	BRA         L_main13
	DECFSZ      R12, 1, 1
	BRA         L_main13
	DECFSZ      R11, 1, 1
	BRA         L_main13
	NOP
;case_statements.c,120 :: 		break;
	GOTO        L_main5
;case_statements.c,122 :: 		case 128: // PORTD == 0b10000000
L_main14:
;case_statements.c,123 :: 		for (i = 0; i < 0xFF; i++) {
	CLRF        _i+0 
L_main15:
	MOVLW       255
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main16
;case_statements.c,124 :: 		PORTC = i;
	MOVF        _i+0, 0 
	MOVWF       PORTC+0 
;case_statements.c,125 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main18:
	DECFSZ      R13, 1, 1
	BRA         L_main18
	DECFSZ      R12, 1, 1
	BRA         L_main18
	DECFSZ      R11, 1, 1
	BRA         L_main18
	NOP
	NOP
;case_statements.c,123 :: 		for (i = 0; i < 0xFF; i++) {
	INCF        _i+0, 1 
;case_statements.c,126 :: 		}
	GOTO        L_main15
L_main16:
;case_statements.c,127 :: 		break;
	GOTO        L_main5
;case_statements.c,129 :: 		default:
L_main19:
;case_statements.c,130 :: 		PORTC = 0x00; // clear PORTC each loop
	CLRF        PORTC+0 
;case_statements.c,131 :: 		}
	GOTO        L_main5
L_main4:
	MOVF        PORTD+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
	MOVF        PORTD+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
	MOVF        PORTD+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
	MOVF        PORTD+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_main9
	MOVF        PORTD+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVF        PORTD+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVF        PORTD+0, 0 
	XORLW       64
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
	MOVF        PORTD+0, 0 
	XORLW       128
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
	GOTO        L_main19
L_main5:
;case_statements.c,132 :: 		}
	GOTO        L_main2
;case_statements.c,133 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
