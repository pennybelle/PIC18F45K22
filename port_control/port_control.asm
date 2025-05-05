
_lcd_display_prep:

;port_control.c,33 :: 		void lcd_display_prep() {
;port_control.c,34 :: 		ANSELB = 0;                        // Configure PORTB pins as digital
	CLRF        ANSELB+0 
;port_control.c,35 :: 		Lcd_Init();                        // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;port_control.c,36 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;port_control.c,37 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;port_control.c,38 :: 		}
L_end_lcd_display_prep:
	RETURN      0
; end of _lcd_display_prep

_lcd_display_out:

;port_control.c,41 :: 		void lcd_display_out(char first_line, char second_line) {
;port_control.c,42 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;port_control.c,43 :: 		Lcd_Out(1,1,first_line);                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_first_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;port_control.c,45 :: 		Lcd_Out(2,1,second_line);                 // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_second_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;port_control.c,46 :: 		}
L_end_lcd_display_out:
	RETURN      0
; end of _lcd_display_out

_main:

;port_control.c,68 :: 		void main() {
;port_control.c,69 :: 		lcd_display_prep();
	CALL        _lcd_display_prep+0, 0
;port_control.c,70 :: 		lcd_display_out(txt1, signature);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _signature+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;port_control.c,73 :: 		TRISD = 0xFF;
	MOVLW       255
	MOVWF       TRISD+0 
;port_control.c,74 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;port_control.c,75 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;port_control.c,78 :: 		TRISE = 0xFF;
	MOVLW       255
	MOVWF       TRISE+0 
;port_control.c,79 :: 		ANSELE = 0x00;
	CLRF        ANSELE+0 
;port_control.c,80 :: 		PORTE = 0x00;
	CLRF        PORTE+0 
;port_control.c,83 :: 		TRISC = 0x00;
	CLRF        TRISC+0 
;port_control.c,84 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;port_control.c,87 :: 		while(1) {
L_main0:
;port_control.c,89 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;port_control.c,90 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;port_control.c,93 :: 		if (PORTE && e_state != PORTE) { // turn on port E to enable logic High
	MOVF        PORTE+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
	MOVLW       0
	XORWF       _e_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main38
	MOVF        PORTE+0, 0 
	XORWF       _e_state+0, 0 
L__main38:
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
L__main34:
;port_control.c,94 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;port_control.c,95 :: 		PORTD = 0xFF;
	MOVLW       255
	MOVWF       PORTD+0 
;port_control.c,96 :: 		logic_state = 0;
	CLRF        _logic_state+0 
	CLRF        _logic_state+1 
;port_control.c,97 :: 		lcd_display_out(txt1, txt2);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _txt2+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;port_control.c,98 :: 		e_state = PORTE;
	MOVF        PORTE+0, 0 
	MOVWF       _e_state+0 
	MOVLW       0
	MOVWF       _e_state+1 
;port_control.c,99 :: 		} else if (e_state != PORTE) { // turn off port E to enable logic Low
	GOTO        L_main5
L_main4:
	MOVLW       0
	XORWF       _e_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main39
	MOVF        PORTE+0, 0 
	XORWF       _e_state+0, 0 
L__main39:
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
;port_control.c,100 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;port_control.c,101 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;port_control.c,102 :: 		logic_state = 1;
	MOVLW       1
	MOVWF       _logic_state+0 
	MOVLW       0
	MOVWF       _logic_state+1 
;port_control.c,103 :: 		lcd_display_out(txt1, txt3);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _txt3+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;port_control.c,104 :: 		e_state = PORTE;
	MOVF        PORTE+0, 0 
	MOVWF       _e_state+0 
	MOVLW       0
	MOVWF       _e_state+1 
;port_control.c,105 :: 		}
L_main6:
L_main5:
;port_control.c,107 :: 		if (RD0_bit == logic_state) {
	CLRF        R1 
	BTFSC       RD0_bit+0, BitPos(RD0_bit+0) 
	INCF        R1, 1 
	MOVLW       0
	XORWF       _logic_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main40
	MOVF        _logic_state+0, 0 
	XORWF       R1, 0 
L__main40:
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
;port_control.c,108 :: 		PORTC = numbers[0];
	MOVF        _numbers+0, 0 
	MOVWF       PORTC+0 
;port_control.c,109 :: 		delay_ms(3000);
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	DECFSZ      R11, 1, 1
	BRA         L_main8
	NOP
;port_control.c,110 :: 		}
L_main7:
;port_control.c,112 :: 		if (RD1_bit == logic_state) {
	CLRF        R1 
	BTFSC       RD1_bit+0, BitPos(RD1_bit+0) 
	INCF        R1, 1 
	MOVLW       0
	XORWF       _logic_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main41
	MOVF        _logic_state+0, 0 
	XORWF       R1, 0 
L__main41:
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
;port_control.c,113 :: 		PORTC = numbers[1];
	MOVF        _numbers+2, 0 
	MOVWF       PORTC+0 
;port_control.c,114 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 1
	BRA         L_main10
	DECFSZ      R12, 1, 1
	BRA         L_main10
	DECFSZ      R11, 1, 1
	BRA         L_main10
	NOP
;port_control.c,115 :: 		}
L_main9:
;port_control.c,117 :: 		if (RD2_bit == logic_state) {
	CLRF        R1 
	BTFSC       RD2_bit+0, BitPos(RD2_bit+0) 
	INCF        R1, 1 
	MOVLW       0
	XORWF       _logic_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main42
	MOVF        _logic_state+0, 0 
	XORWF       R1, 0 
L__main42:
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
;port_control.c,118 :: 		PORTC = numbers[2];
	MOVF        _numbers+4, 0 
	MOVWF       PORTC+0 
;port_control.c,119 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	DECFSZ      R11, 1, 1
	BRA         L_main12
	NOP
	NOP
;port_control.c,120 :: 		PORTC = numbers[3];
	MOVF        _numbers+6, 0 
	MOVWF       PORTC+0 
;port_control.c,121 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main13:
	DECFSZ      R13, 1, 1
	BRA         L_main13
	DECFSZ      R12, 1, 1
	BRA         L_main13
	DECFSZ      R11, 1, 1
	BRA         L_main13
	NOP
	NOP
;port_control.c,122 :: 		}
L_main11:
;port_control.c,124 :: 		if (RD3_bit == logic_state) {
	CLRF        R1 
	BTFSC       RD3_bit+0, BitPos(RD3_bit+0) 
	INCF        R1, 1 
	MOVLW       0
	XORWF       _logic_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main43
	MOVF        _logic_state+0, 0 
	XORWF       R1, 0 
L__main43:
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
;port_control.c,125 :: 		PORTC = numbers[4];
	MOVF        _numbers+8, 0 
	MOVWF       PORTC+0 
;port_control.c,126 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main15:
	DECFSZ      R13, 1, 1
	BRA         L_main15
	DECFSZ      R12, 1, 1
	BRA         L_main15
	DECFSZ      R11, 1, 1
	BRA         L_main15
	NOP
	NOP
;port_control.c,128 :: 		for (i=0; i < 3; i++) {
	CLRF        _i+0 
L_main16:
	MOVLW       3
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main17
;port_control.c,129 :: 		PORTC = numbers[5];
	MOVF        _numbers+10, 0 
	MOVWF       PORTC+0 
;port_control.c,130 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main19:
	DECFSZ      R13, 1, 1
	BRA         L_main19
	DECFSZ      R12, 1, 1
	BRA         L_main19
	DECFSZ      R11, 1, 1
	BRA         L_main19
	NOP
	NOP
;port_control.c,128 :: 		for (i=0; i < 3; i++) {
	INCF        _i+0, 1 
;port_control.c,131 :: 		}
	GOTO        L_main16
L_main17:
;port_control.c,132 :: 		}
L_main14:
;port_control.c,134 :: 		if (RD4_bit == logic_state) {
	CLRF        R1 
	BTFSC       RD4_bit+0, BitPos(RD4_bit+0) 
	INCF        R1, 1 
	MOVLW       0
	XORWF       _logic_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main44
	MOVF        _logic_state+0, 0 
	XORWF       R1, 0 
L__main44:
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
;port_control.c,135 :: 		PORTC = numbers[1];
	MOVF        _numbers+2, 0 
	MOVWF       PORTC+0 
;port_control.c,136 :: 		delay_ms(250);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main21:
	DECFSZ      R13, 1, 1
	BRA         L_main21
	DECFSZ      R12, 1, 1
	BRA         L_main21
	DECFSZ      R11, 1, 1
	BRA         L_main21
	NOP
	NOP
;port_control.c,137 :: 		PORTC = numbers[0];
	MOVF        _numbers+0, 0 
	MOVWF       PORTC+0 
;port_control.c,138 :: 		delay_ms(250);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main22:
	DECFSZ      R13, 1, 1
	BRA         L_main22
	DECFSZ      R12, 1, 1
	BRA         L_main22
	DECFSZ      R11, 1, 1
	BRA         L_main22
	NOP
	NOP
;port_control.c,139 :: 		}
L_main20:
;port_control.c,141 :: 		if (RD5_bit == logic_state) {
	CLRF        R1 
	BTFSC       RD5_bit+0, BitPos(RD5_bit+0) 
	INCF        R1, 1 
	MOVLW       0
	XORWF       _logic_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main45
	MOVF        _logic_state+0, 0 
	XORWF       R1, 0 
L__main45:
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
;port_control.c,142 :: 		PORTC = numbers[6];
	MOVF        _numbers+12, 0 
	MOVWF       PORTC+0 
;port_control.c,143 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main24:
	DECFSZ      R13, 1, 1
	BRA         L_main24
	DECFSZ      R12, 1, 1
	BRA         L_main24
	DECFSZ      R11, 1, 1
	BRA         L_main24
	NOP
	NOP
;port_control.c,144 :: 		PORTC = numbers[7];
	MOVF        _numbers+14, 0 
	MOVWF       PORTC+0 
;port_control.c,145 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main25:
	DECFSZ      R13, 1, 1
	BRA         L_main25
	DECFSZ      R12, 1, 1
	BRA         L_main25
	DECFSZ      R11, 1, 1
	BRA         L_main25
	NOP
	NOP
;port_control.c,146 :: 		}
L_main23:
;port_control.c,148 :: 		if (RD6_bit == logic_state) {
	CLRF        R1 
	BTFSC       RD6_bit+0, BitPos(RD6_bit+0) 
	INCF        R1, 1 
	MOVLW       0
	XORWF       _logic_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main46
	MOVF        _logic_state+0, 0 
	XORWF       R1, 0 
L__main46:
	BTFSS       STATUS+0, 2 
	GOTO        L_main26
;port_control.c,149 :: 		PORTC = numbers[8];
	MOVF        _numbers+16, 0 
	MOVWF       PORTC+0 
;port_control.c,150 :: 		delay_ms(750);
	MOVLW       8
	MOVWF       R11, 0
	MOVLW       157
	MOVWF       R12, 0
	MOVLW       5
	MOVWF       R13, 0
L_main27:
	DECFSZ      R13, 1, 1
	BRA         L_main27
	DECFSZ      R12, 1, 1
	BRA         L_main27
	DECFSZ      R11, 1, 1
	BRA         L_main27
	NOP
	NOP
;port_control.c,151 :: 		PORTC = numbers[9];
	MOVF        _numbers+18, 0 
	MOVWF       PORTC+0 
;port_control.c,152 :: 		delay_ms(750);
	MOVLW       8
	MOVWF       R11, 0
	MOVLW       157
	MOVWF       R12, 0
	MOVLW       5
	MOVWF       R13, 0
L_main28:
	DECFSZ      R13, 1, 1
	BRA         L_main28
	DECFSZ      R12, 1, 1
	BRA         L_main28
	DECFSZ      R11, 1, 1
	BRA         L_main28
	NOP
	NOP
;port_control.c,153 :: 		}
L_main26:
;port_control.c,155 :: 		if (RD7_bit == logic_state) {
	CLRF        R1 
	BTFSC       RD7_bit+0, BitPos(RD7_bit+0) 
	INCF        R1, 1 
	MOVLW       0
	XORWF       _logic_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main47
	MOVF        _logic_state+0, 0 
	XORWF       R1, 0 
L__main47:
	BTFSS       STATUS+0, 2 
	GOTO        L_main29
;port_control.c,156 :: 		for (i=0; i < 10; i++) {
	CLRF        _i+0 
L_main30:
	MOVLW       10
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main31
;port_control.c,157 :: 		PORTC = numbers[i];
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _numbers+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_numbers+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;port_control.c,158 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main33:
	DECFSZ      R13, 1, 1
	BRA         L_main33
	DECFSZ      R12, 1, 1
	BRA         L_main33
	DECFSZ      R11, 1, 1
	BRA         L_main33
	NOP
	NOP
;port_control.c,156 :: 		for (i=0; i < 10; i++) {
	INCF        _i+0, 1 
;port_control.c,159 :: 		}
	GOTO        L_main30
L_main31:
;port_control.c,160 :: 		}
L_main29:
;port_control.c,161 :: 		}
	GOTO        L_main0
;port_control.c,162 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
