
_lcd_display_prep:

;if_else.c,31 :: 		void lcd_display_prep() {
;if_else.c,32 :: 		ANSELB = 0;                        // Configure PORTB pins as digital
	CLRF        ANSELB+0 
;if_else.c,33 :: 		Lcd_Init();                        // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;if_else.c,34 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;if_else.c,35 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;if_else.c,36 :: 		}
L_end_lcd_display_prep:
	RETURN      0
; end of _lcd_display_prep

_lcd_display_out:

;if_else.c,39 :: 		void lcd_display_out(char first_line, char second_line) {
;if_else.c,40 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;if_else.c,41 :: 		Lcd_Out(1,1,first_line);                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_first_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;if_else.c,43 :: 		Lcd_Out(2,1,second_line);                 // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_second_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;if_else.c,44 :: 		}
L_end_lcd_display_out:
	RETURN      0
; end of _lcd_display_out

_do_the_thing:

;if_else.c,48 :: 		void do_the_thing() {
;if_else.c,49 :: 		PORTC = 0xFF;
	MOVLW       255
	MOVWF       PORTC+0 
;if_else.c,50 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_do_the_thing0:
	DECFSZ      R13, 1, 1
	BRA         L_do_the_thing0
	DECFSZ      R12, 1, 1
	BRA         L_do_the_thing0
	DECFSZ      R11, 1, 1
	BRA         L_do_the_thing0
	NOP
	NOP
;if_else.c,51 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;if_else.c,52 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_do_the_thing1:
	DECFSZ      R13, 1, 1
	BRA         L_do_the_thing1
	DECFSZ      R12, 1, 1
	BRA         L_do_the_thing1
	DECFSZ      R11, 1, 1
	BRA         L_do_the_thing1
	NOP
	NOP
;if_else.c,53 :: 		}
L_end_do_the_thing:
	RETURN      0
; end of _do_the_thing

_main:

;if_else.c,59 :: 		void main() {
;if_else.c,60 :: 		lcd_display_prep();
	CALL        _lcd_display_prep+0, 0
;if_else.c,61 :: 		lcd_display_out(txt1, signature);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _signature+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;if_else.c,64 :: 		TRISE = 0xFF;
	MOVLW       255
	MOVWF       TRISE+0 
;if_else.c,65 :: 		ANSELE = 0x00;
	CLRF        ANSELE+0 
;if_else.c,68 :: 		TRISD = 0xFF;
	MOVLW       255
	MOVWF       TRISD+0 
;if_else.c,69 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;if_else.c,72 :: 		TRISC = 0x00;
	CLRF        TRISC+0 
;if_else.c,74 :: 		while(1) {
L_main2:
;if_else.c,75 :: 		PORTC = 0x00; // reset output each loop
	CLRF        PORTC+0 
;if_else.c,76 :: 		PORTD = 0x00; // reset each input each loop
	CLRF        PORTD+0 
;if_else.c,77 :: 		PORTE = 0x00;
	CLRF        PORTE+0 
;if_else.c,79 :: 		if (PORTE == 0b00000001 && PORTD == global_var) {
	MOVF        PORTE+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
	MOVLW       0
	XORWF       _global_var+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main39
	MOVF        _global_var+0, 0 
	XORWF       PORTD+0, 0 
L__main39:
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
L__main34:
;if_else.c,80 :: 		do_the_thing();
	CALL        _do_the_thing+0, 0
;if_else.c,81 :: 		} else if (PORTE == 0b00000010 && PORTD != global_var) {
	GOTO        L_main7
L_main6:
	MOVF        PORTE+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
	MOVLW       0
	XORWF       _global_var+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main40
	MOVF        _global_var+0, 0 
	XORWF       PORTD+0, 0 
L__main40:
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
L__main33:
;if_else.c,82 :: 		do_the_thing();
	CALL        _do_the_thing+0, 0
;if_else.c,83 :: 		} else if (PORTE == 0b00000100 && PORTD > global_var) {
	GOTO        L_main11
L_main10:
	MOVF        PORTE+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
	MOVLW       128
	XORWF       _global_var+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main41
	MOVF        PORTD+0, 0 
	SUBWF       _global_var+0, 0 
L__main41:
	BTFSC       STATUS+0, 0 
	GOTO        L_main14
L__main32:
;if_else.c,84 :: 		do_the_thing();
	CALL        _do_the_thing+0, 0
;if_else.c,85 :: 		} else if (PORTE == 0b00001000 && PORTD < global_var) {
	GOTO        L_main15
L_main14:
	MOVF        PORTE+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _global_var+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main42
	MOVF        _global_var+0, 0 
	SUBWF       PORTD+0, 0 
L__main42:
	BTFSC       STATUS+0, 0 
	GOTO        L_main18
L__main31:
;if_else.c,86 :: 		do_the_thing();
	CALL        _do_the_thing+0, 0
;if_else.c,87 :: 		} else if (PORTE == 0b00010000 && PORTD >= global_var) {
	GOTO        L_main19
L_main18:
	MOVF        PORTE+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_main22
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _global_var+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main43
	MOVF        _global_var+0, 0 
	SUBWF       PORTD+0, 0 
L__main43:
	BTFSS       STATUS+0, 0 
	GOTO        L_main22
L__main30:
;if_else.c,88 :: 		do_the_thing();
	CALL        _do_the_thing+0, 0
;if_else.c,89 :: 		} else if (PORTE == 0b00100000 && PORTD <= global_var) {
	GOTO        L_main23
L_main22:
	MOVF        PORTE+0, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_main26
	MOVLW       128
	XORWF       _global_var+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main44
	MOVF        PORTD+0, 0 
	SUBWF       _global_var+0, 0 
L__main44:
	BTFSS       STATUS+0, 0 
	GOTO        L_main26
L__main29:
;if_else.c,90 :: 		do_the_thing();
	CALL        _do_the_thing+0, 0
;if_else.c,91 :: 		} else {
	GOTO        L_main27
L_main26:
;if_else.c,92 :: 		PORTC = 0xFF;
	MOVLW       255
	MOVWF       PORTC+0 
;if_else.c,93 :: 		delay_ms(3000);
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L_main28:
	DECFSZ      R13, 1, 1
	BRA         L_main28
	DECFSZ      R12, 1, 1
	BRA         L_main28
	DECFSZ      R11, 1, 1
	BRA         L_main28
	NOP
;if_else.c,94 :: 		}
L_main27:
L_main23:
L_main19:
L_main15:
L_main11:
L_main7:
;if_else.c,95 :: 		}
	GOTO        L_main2
;if_else.c,96 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
