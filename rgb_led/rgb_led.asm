
_lcd_display_prep:

;rgb_led.c,39 :: 		void lcd_display_prep() {
;rgb_led.c,40 :: 		ANSELB = 0;                        // Configure PORTB pins as digital
	CLRF        ANSELB+0 
;rgb_led.c,41 :: 		Lcd_Init();                        // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;rgb_led.c,42 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;rgb_led.c,43 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;rgb_led.c,44 :: 		}
L_end_lcd_display_prep:
	RETURN      0
; end of _lcd_display_prep

_lcd_display_out:

;rgb_led.c,47 :: 		void lcd_display_out(char first_line, char second_line) {
;rgb_led.c,48 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;rgb_led.c,49 :: 		Lcd_Out(1,1,first_line);                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_first_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;rgb_led.c,51 :: 		Lcd_Out(2,1,second_line);                 // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_second_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;rgb_led.c,52 :: 		}
L_end_lcd_display_out:
	RETURN      0
; end of _lcd_display_out

_output_to_rgb:

;rgb_led.c,55 :: 		void output_to_rgb() {
;rgb_led.c,56 :: 		if (PORTD == RED) {
	MOVLW       0
	XORWF       _RED+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__output_to_rgb21
	MOVF        _RED+0, 0 
	XORWF       PORTD+0, 0 
L__output_to_rgb21:
	BTFSS       STATUS+0, 2 
	GOTO        L_output_to_rgb0
;rgb_led.c,57 :: 		PORTC = RED;
	MOVF        _RED+0, 0 
	MOVWF       PORTC+0 
;rgb_led.c,58 :: 		} else if (PORTD == GREEN) {
	GOTO        L_output_to_rgb1
L_output_to_rgb0:
	MOVLW       0
	XORWF       _GREEN+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__output_to_rgb22
	MOVF        _GREEN+0, 0 
	XORWF       PORTD+0, 0 
L__output_to_rgb22:
	BTFSS       STATUS+0, 2 
	GOTO        L_output_to_rgb2
;rgb_led.c,59 :: 		PORTC = GREEN;
	MOVF        _GREEN+0, 0 
	MOVWF       PORTC+0 
;rgb_led.c,60 :: 		} else if (PORTD == BLUE) {
	GOTO        L_output_to_rgb3
L_output_to_rgb2:
	MOVLW       0
	XORWF       _BLUE+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__output_to_rgb23
	MOVF        _BLUE+0, 0 
	XORWF       PORTD+0, 0 
L__output_to_rgb23:
	BTFSS       STATUS+0, 2 
	GOTO        L_output_to_rgb4
;rgb_led.c,61 :: 		PORTC = BLUE;
	MOVF        _BLUE+0, 0 
	MOVWF       PORTC+0 
;rgb_led.c,62 :: 		} else {
	GOTO        L_output_to_rgb5
L_output_to_rgb4:
;rgb_led.c,63 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;rgb_led.c,64 :: 		}
L_output_to_rgb5:
L_output_to_rgb3:
L_output_to_rgb1:
;rgb_led.c,65 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_output_to_rgb6:
	DECFSZ      R13, 1, 1
	BRA         L_output_to_rgb6
	DECFSZ      R12, 1, 1
	BRA         L_output_to_rgb6
	NOP
	NOP
;rgb_led.c,66 :: 		}
L_end_output_to_rgb:
	RETURN      0
; end of _output_to_rgb

_color_cycle:

;rgb_led.c,69 :: 		void color_cycle(int delay) {
;rgb_led.c,70 :: 		PORTC = RED;
	MOVF        _RED+0, 0 
	MOVWF       PORTC+0 
;rgb_led.c,71 :: 		vdelay_ms(delay);
	MOVF        FARG_color_cycle_delay+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        FARG_color_cycle_delay+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;rgb_led.c,72 :: 		PORTC = GREEN;
	MOVF        _GREEN+0, 0 
	MOVWF       PORTC+0 
;rgb_led.c,73 :: 		vdelay_ms(delay);
	MOVF        FARG_color_cycle_delay+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        FARG_color_cycle_delay+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;rgb_led.c,74 :: 		PORTC = BLUE;
	MOVF        _BLUE+0, 0 
	MOVWF       PORTC+0 
;rgb_led.c,75 :: 		vdelay_ms(delay);
	MOVF        FARG_color_cycle_delay+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        FARG_color_cycle_delay+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;rgb_led.c,76 :: 		}
L_end_color_cycle:
	RETURN      0
; end of _color_cycle

_main:

;rgb_led.c,79 :: 		void main() {
;rgb_led.c,80 :: 		lcd_display_prep();
	CALL        _lcd_display_prep+0, 0
;rgb_led.c,81 :: 		lcd_display_out(txt1, signature);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _signature+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;rgb_led.c,83 :: 		TRISE = 0xFF; // port e set to input
	MOVLW       255
	MOVWF       TRISE+0 
;rgb_led.c,84 :: 		ANSELE = 0x00; // prep for input (TTL)
	CLRF        ANSELE+0 
;rgb_led.c,86 :: 		TRISD = 0xFF; // port d set to input
	MOVLW       255
	MOVWF       TRISD+0 
;rgb_led.c,87 :: 		ANSELD = 0x00; // prep for input (TTL)
	CLRF        ANSELD+0 
;rgb_led.c,89 :: 		TRISC = 0x00; // port c set to output
	CLRF        TRISC+0 
;rgb_led.c,90 :: 		PORTC = 0x00; // set all bits to logic low
	CLRF        PORTC+0 
;rgb_led.c,92 :: 		while(1) {
L_main7:
;rgb_led.c,93 :: 		if (PORTE == 0b00000001) {
	MOVF        PORTE+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
;rgb_led.c,94 :: 		color_cycle(1000);
	MOVLW       232
	MOVWF       FARG_color_cycle_delay+0 
	MOVLW       3
	MOVWF       FARG_color_cycle_delay+1 
	CALL        _color_cycle+0, 0
;rgb_led.c,95 :: 		} else if (PORTE == 0b00000010) {
	GOTO        L_main10
L_main9:
	MOVF        PORTE+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
;rgb_led.c,96 :: 		color_cycle(50);
	MOVLW       50
	MOVWF       FARG_color_cycle_delay+0 
	MOVLW       0
	MOVWF       FARG_color_cycle_delay+1 
	CALL        _color_cycle+0, 0
;rgb_led.c,97 :: 		} else {
	GOTO        L_main12
L_main11:
;rgb_led.c,98 :: 		PORTC = PORTD;
	MOVF        PORTD+0, 0 
	MOVWF       PORTC+0 
;rgb_led.c,100 :: 		if (PORTC == PORTD && PORTC != 0x00) {
	MOVF        PORTC+0, 0 
	XORWF       PORTD+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
	MOVF        PORTC+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
L__main17:
;rgb_led.c,101 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main16:
	DECFSZ      R13, 1, 1
	BRA         L_main16
	DECFSZ      R12, 1, 1
	BRA         L_main16
	NOP
	NOP
;rgb_led.c,102 :: 		}
L_main15:
;rgb_led.c,103 :: 		}
L_main12:
L_main10:
;rgb_led.c,104 :: 		}
	GOTO        L_main7
;rgb_led.c,105 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
