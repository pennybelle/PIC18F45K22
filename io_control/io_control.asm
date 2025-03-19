
_lcd_display_prep:

;io_control.c,65 :: 		void lcd_display_prep() {
;io_control.c,66 :: 		ANSELB = 0;                        // Configure PORTB pins as digital
	CLRF        ANSELB+0 
;io_control.c,67 :: 		Lcd_Init();                        // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;io_control.c,68 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;io_control.c,69 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;io_control.c,70 :: 		}
L_end_lcd_display_prep:
	RETURN      0
; end of _lcd_display_prep

_lcd_display_out:

;io_control.c,72 :: 		void lcd_display_out(char first_line, char second_line) {
;io_control.c,73 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;io_control.c,74 :: 		Lcd_Out(1,1,first_line);                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_first_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;io_control.c,76 :: 		Lcd_Out(2,1,second_line);                 // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_second_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;io_control.c,77 :: 		}
L_end_lcd_display_out:
	RETURN      0
; end of _lcd_display_out

_lcd_update:

;io_control.c,79 :: 		void lcd_update(char i) {
;io_control.c,80 :: 		if (i != input) {
	MOVF        FARG_lcd_update_i+0, 0 
	XORWF       _input+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_lcd_update0
;io_control.c,81 :: 		input = i;
	MOVF        FARG_lcd_update_i+0, 0 
	MOVWF       _input+0 
;io_control.c,82 :: 		lcd_display_out(txt1, i);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVF        FARG_lcd_update_i+0, 0 
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;io_control.c,83 :: 		}
L_lcd_update0:
;io_control.c,84 :: 		}
L_end_lcd_update:
	RETURN      0
; end of _lcd_update

_main:

;io_control.c,86 :: 		void main() {
;io_control.c,87 :: 		lcd_display_prep();
	CALL        _lcd_display_prep+0, 0
;io_control.c,88 :: 		lcd_display_out(txt1, signature);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _signature+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;io_control.c,89 :: 		input = signature;
	MOVLW       _signature+0
	MOVWF       _input+0 
;io_control.c,91 :: 		TRISE = 0xFF; // set port E as input (im using this to toggle bit inversion)
	MOVLW       255
	MOVWF       TRISE+0 
;io_control.c,92 :: 		TRISD = 0xFF; // set port D as input (this is the input data that gets output)
	MOVLW       255
	MOVWF       TRISD+0 
;io_control.c,93 :: 		TRISC = 0x00; // set port C as output
	CLRF        TRISC+0 
;io_control.c,94 :: 		PORTC = 0x00; // set all bits in port C to 0
	CLRF        PORTC+0 
;io_control.c,95 :: 		ANSELD = 0x00; // turn off ADC latches to accept TTL inputs
	CLRF        ANSELD+0 
;io_control.c,96 :: 		ANSELE = 0x00;
	CLRF        ANSELE+0 
;io_control.c,98 :: 		delay_ms(3000); // wait for plug
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
	NOP
;io_control.c,100 :: 		while (1) {
L_main2:
;io_control.c,101 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;io_control.c,106 :: 		if (PORTE) {
	MOVF        PORTE+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
;io_control.c,107 :: 		if (PORTD == 0b00000101) {
	MOVF        PORTD+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;io_control.c,108 :: 		lcd_update(txt4);
	MOVLW       _txt4+0
	MOVWF       FARG_lcd_update_i+0 
	CALL        _lcd_update+0, 0
;io_control.c,109 :: 		PORTC = 0xFF;
	MOVLW       255
	MOVWF       PORTC+0 
;io_control.c,110 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
	NOP
;io_control.c,111 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;io_control.c,112 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
	NOP
	NOP
;io_control.c,113 :: 		} else {
	GOTO        L_main8
L_main5:
;io_control.c,114 :: 		lcd_update(txt2);
	MOVLW       _txt2+0
	MOVWF       FARG_lcd_update_i+0 
	CALL        _lcd_update+0, 0
;io_control.c,115 :: 		PORTC = PORTD;
	MOVF        PORTD+0, 0 
	MOVWF       PORTC+0 
;io_control.c,116 :: 		}
L_main8:
;io_control.c,117 :: 		} else {
	GOTO        L_main9
L_main4:
;io_control.c,118 :: 		lcd_update(txt3);
	MOVLW       _txt3+0
	MOVWF       FARG_lcd_update_i+0 
	CALL        _lcd_update+0, 0
;io_control.c,119 :: 		PORTC = ~PORTD;
	COMF        PORTD+0, 0 
	MOVWF       PORTC+0 
;io_control.c,120 :: 		}
L_main9:
;io_control.c,121 :: 		}
	GOTO        L_main2
;io_control.c,122 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
