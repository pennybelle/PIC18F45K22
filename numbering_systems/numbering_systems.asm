
_interrupt:

;numbering_systems.c,47 :: 		void interrupt() {
;numbering_systems.c,48 :: 		LATA = 0;                             // Turn off all 7seg displays
	CLRF        LATA+0 
;numbering_systems.c,49 :: 		LATD = portd_array[portd_index];      // bring appropriate value to PORTD
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
;numbering_systems.c,50 :: 		LATA = shifter;                       // turn on appropriate 7seg. display
	MOVF        _shifter+0, 0 
	MOVWF       LATA+0 
;numbering_systems.c,53 :: 		shifter <<= 1;
	MOVF        _shifter+0, 0 
	MOVWF       R1 
	RLCF        R1, 1 
	BCF         R1, 0 
	MOVF        R1, 0 
	MOVWF       _shifter+0 
;numbering_systems.c,54 :: 		if (shifter > 8u)
	MOVF        R1, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt0
;numbering_systems.c,55 :: 		shifter = 1;
	MOVLW       1
	MOVWF       _shifter+0 
L_interrupt0:
;numbering_systems.c,58 :: 		portd_index++ ;
	INCF        _portd_index+0, 1 
;numbering_systems.c,59 :: 		if (portd_index > 3u)
	MOVF        _portd_index+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
;numbering_systems.c,60 :: 		portd_index = 0;             // turn on 1st, turn off 2nd 7seg.
	CLRF        _portd_index+0 
L_interrupt1:
;numbering_systems.c,61 :: 		TMR0L  =   0;                  // reset TIMER0 value
	CLRF        TMR0L+0 
;numbering_systems.c,62 :: 		TMR0IF_bit = 0;                // Clear TMR0IF
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;numbering_systems.c,63 :: 		}
L_end_interrupt:
L__interrupt11:
	RETFIE      1
; end of _interrupt

_seven_seg_prep:

;numbering_systems.c,65 :: 		void seven_seg_prep() {
;numbering_systems.c,66 :: 		ANSELA = 0;                    // Configure PORTA pins as digital
	CLRF        ANSELA+0 
;numbering_systems.c,67 :: 		ANSELD = 0;                    // Configure PORTD pins as digital
	CLRF        ANSELD+0 
;numbering_systems.c,69 :: 		TRISA = 0;                     // Configure PORTA as output
	CLRF        TRISA+0 
;numbering_systems.c,70 :: 		LATA  = 0;                     // Clear PORTA
	CLRF        LATA+0 
;numbering_systems.c,71 :: 		TRISD = 0;                     // Configure PORTD as output
	CLRF        TRISD+0 
;numbering_systems.c,72 :: 		LATD  = 0;                     // Clear PORTD
	CLRF        LATD+0 
;numbering_systems.c,74 :: 		T0CON = 0xC4;                  // Set TMR0 in 8bit mode, assign prescaler to TMR0
	MOVLW       196
	MOVWF       T0CON+0 
;numbering_systems.c,75 :: 		TMR0L = 0;                     // clear TMROL
	CLRF        TMR0L+0 
;numbering_systems.c,76 :: 		digit = 0;
	CLRF        _digit+0 
	CLRF        _digit+1 
;numbering_systems.c,77 :: 		portd_index = 0;
	CLRF        _portd_index+0 
;numbering_systems.c,78 :: 		shifter = 1;
	MOVLW       1
	MOVWF       _shifter+0 
;numbering_systems.c,80 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;numbering_systems.c,81 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;numbering_systems.c,82 :: 		}
L_end_seven_seg_prep:
	RETURN      0
; end of _seven_seg_prep

_bit_walk_prep:

;numbering_systems.c,84 :: 		void bit_walk_prep() {
;numbering_systems.c,85 :: 		TRISC = 0x00; // set direction of data traffic to output
	CLRF        TRISC+0 
;numbering_systems.c,86 :: 		}
L_end_bit_walk_prep:
	RETURN      0
; end of _bit_walk_prep

_seven_seg_out:

;numbering_systems.c,88 :: 		void seven_seg_out() {
;numbering_systems.c,89 :: 		digit = number / 1000u ;             // extract thousands digit
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
;numbering_systems.c,90 :: 		portd_array[3] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+3 
;numbering_systems.c,91 :: 		digit = (number / 100u) % 10u;       // extract hundreds digit
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
;numbering_systems.c,92 :: 		portd_array[2] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+2 
;numbering_systems.c,93 :: 		digit = (number / 10u) % 10u;        // extract tens digit
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
;numbering_systems.c,94 :: 		portd_array[1] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+1 
;numbering_systems.c,95 :: 		digit = number % 10u;                // extract ones digit
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
;numbering_systems.c,96 :: 		portd_array[0] = mask(digit);        // and store it to PORTD array
	MOVF        R0, 0 
	MOVWF       FARG_mask_num+0 
	CALL        _mask+0, 0
	MOVF        R0, 0 
	MOVWF       _portd_array+0 
;numbering_systems.c,97 :: 		}
L_end_seven_seg_out:
	RETURN      0
; end of _seven_seg_out

_lcd_display_prep:

;numbering_systems.c,99 :: 		void lcd_display_prep() {
;numbering_systems.c,100 :: 		ANSELB = 0;                        // Configure PORTB pins as digital
	CLRF        ANSELB+0 
;numbering_systems.c,101 :: 		Lcd_Init();                        // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;numbering_systems.c,102 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;numbering_systems.c,103 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;numbering_systems.c,104 :: 		}
L_end_lcd_display_prep:
	RETURN      0
; end of _lcd_display_prep

_lcd_display_out:

;numbering_systems.c,106 :: 		void lcd_display_out(char first_line, char second_line) {
;numbering_systems.c,107 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;numbering_systems.c,108 :: 		Lcd_Out(1,1,first_line);                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_first_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;numbering_systems.c,110 :: 		Lcd_Out(2,1,second_line);                 // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_lcd_display_out_second_line+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;numbering_systems.c,111 :: 		}
L_end_lcd_display_out:
	RETURN      0
; end of _lcd_display_out

_do_the_thing:

;numbering_systems.c,113 :: 		void do_the_thing(int i) {
;numbering_systems.c,114 :: 		number = i;
	MOVF        FARG_do_the_thing_i+0, 0 
	MOVWF       _number+0 
	MOVF        FARG_do_the_thing_i+1, 0 
	MOVWF       _number+1 
;numbering_systems.c,115 :: 		seven_seg_out();
	CALL        _seven_seg_out+0, 0
;numbering_systems.c,116 :: 		PORTC = number;
	MOVF        _number+0, 0 
	MOVWF       PORTC+0 
;numbering_systems.c,117 :: 		vdelay_ms(delay_in_ms);
	MOVF        _delay_in_ms+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        _delay_in_ms+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;numbering_systems.c,118 :: 		}
L_end_do_the_thing:
	RETURN      0
; end of _do_the_thing

_procedure_loop:

;numbering_systems.c,120 :: 		void procedure_loop(int number_1, int number_2) {
;numbering_systems.c,121 :: 		for (i = 0; i < 5; i++) {
	CLRF        _i+0 
L_procedure_loop2:
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_procedure_loop3
;numbering_systems.c,122 :: 		do_the_thing(number_1);
	MOVF        FARG_procedure_loop_number_1+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        FARG_procedure_loop_number_1+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;numbering_systems.c,123 :: 		do_the_thing(number_2);
	MOVF        FARG_procedure_loop_number_2+0, 0 
	MOVWF       FARG_do_the_thing_i+0 
	MOVF        FARG_procedure_loop_number_2+1, 0 
	MOVWF       FARG_do_the_thing_i+1 
	CALL        _do_the_thing+0, 0
;numbering_systems.c,121 :: 		for (i = 0; i < 5; i++) {
	INCF        _i+0, 1 
;numbering_systems.c,124 :: 		}
	GOTO        L_procedure_loop2
L_procedure_loop3:
;numbering_systems.c,125 :: 		delay_ms(1500);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_procedure_loop5:
	DECFSZ      R13, 1, 1
	BRA         L_procedure_loop5
	DECFSZ      R12, 1, 1
	BRA         L_procedure_loop5
	DECFSZ      R11, 1, 1
	BRA         L_procedure_loop5
	NOP
	NOP
;numbering_systems.c,126 :: 		LATD  = 0; // clear seven seg display
	CLRF        LATD+0 
;numbering_systems.c,127 :: 		}
L_end_procedure_loop:
	RETURN      0
; end of _procedure_loop

_display_bits:

;numbering_systems.c,140 :: 		display_bits(int i) {
;numbering_systems.c,141 :: 		number = i;
	MOVF        FARG_display_bits_i+0, 0 
	MOVWF       _number+0 
	MOVF        FARG_display_bits_i+1, 0 
	MOVWF       _number+1 
;numbering_systems.c,142 :: 		seven_seg_out();
	CALL        _seven_seg_out+0, 0
;numbering_systems.c,143 :: 		PORTC = number;
	MOVF        _number+0, 0 
	MOVWF       PORTC+0 
;numbering_systems.c,144 :: 		delay_ms(10000);
	MOVLW       102
	MOVWF       R11, 0
	MOVLW       118
	MOVWF       R12, 0
	MOVLW       193
	MOVWF       R13, 0
L_display_bits6:
	DECFSZ      R13, 1, 1
	BRA         L_display_bits6
	DECFSZ      R12, 1, 1
	BRA         L_display_bits6
	DECFSZ      R11, 1, 1
	BRA         L_display_bits6
;numbering_systems.c,145 :: 		}
L_end_display_bits:
	RETURN      0
; end of _display_bits

_main:

;numbering_systems.c,147 :: 		void main() {
;numbering_systems.c,148 :: 		lcd_display_prep();
	CALL        _lcd_display_prep+0, 0
;numbering_systems.c,149 :: 		seven_seg_prep();
	CALL        _seven_seg_prep+0, 0
;numbering_systems.c,150 :: 		lcd_display_out(txt1, signature);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _signature+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;numbering_systems.c,152 :: 		TRISC=0b00000000; // set port C as output for all bits
	CLRF        TRISC+0 
;numbering_systems.c,153 :: 		TRISC=0x00;       // same as above but with hex instead of binary
	CLRF        TRISC+0 
;numbering_systems.c,154 :: 		PORTC=0b00000000; // clear port C (set all to logic low or 0 volts)
	CLRF        PORTC+0 
;numbering_systems.c,157 :: 		delay_ms(3000);
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
	NOP
;numbering_systems.c,159 :: 		while (1) {
L_main8:
;numbering_systems.c,161 :: 		lcd_display_out(txt1, txt2);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _txt2+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;numbering_systems.c,162 :: 		procedure_loop(0b00001111, 0b11110000);
	MOVLW       15
	MOVWF       FARG_procedure_loop_number_1+0 
	MOVLW       0
	MOVWF       FARG_procedure_loop_number_1+1 
	MOVLW       240
	MOVWF       FARG_procedure_loop_number_2+0 
	MOVLW       0
	MOVWF       FARG_procedure_loop_number_2+1 
	CALL        _procedure_loop+0, 0
;numbering_systems.c,165 :: 		lcd_display_out(txt1, txt2);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _txt2+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;numbering_systems.c,166 :: 		procedure_loop(0b01010101, 0b10101010);
	MOVLW       85
	MOVWF       FARG_procedure_loop_number_1+0 
	MOVLW       0
	MOVWF       FARG_procedure_loop_number_1+1 
	MOVLW       170
	MOVWF       FARG_procedure_loop_number_2+0 
	MOVLW       0
	MOVWF       FARG_procedure_loop_number_2+1 
	CALL        _procedure_loop+0, 0
;numbering_systems.c,169 :: 		lcd_display_out(txt1, txt3);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _txt3+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;numbering_systems.c,170 :: 		procedure_loop(0125, 0252);
	MOVLW       85
	MOVWF       FARG_procedure_loop_number_1+0 
	MOVLW       0
	MOVWF       FARG_procedure_loop_number_1+1 
	MOVLW       170
	MOVWF       FARG_procedure_loop_number_2+0 
	MOVLW       0
	MOVWF       FARG_procedure_loop_number_2+1 
	CALL        _procedure_loop+0, 0
;numbering_systems.c,173 :: 		lcd_display_out(txt1, txt4);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _txt4+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;numbering_systems.c,174 :: 		procedure_loop(0x55, 0xAA);
	MOVLW       85
	MOVWF       FARG_procedure_loop_number_1+0 
	MOVLW       0
	MOVWF       FARG_procedure_loop_number_1+1 
	MOVLW       170
	MOVWF       FARG_procedure_loop_number_2+0 
	MOVLW       0
	MOVWF       FARG_procedure_loop_number_2+1 
	CALL        _procedure_loop+0, 0
;numbering_systems.c,177 :: 		lcd_display_out(txt1, txt5);
	MOVLW       _txt1+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _txt5+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;numbering_systems.c,178 :: 		procedure_loop(85, 170);
	MOVLW       85
	MOVWF       FARG_procedure_loop_number_1+0 
	MOVLW       0
	MOVWF       FARG_procedure_loop_number_1+1 
	MOVLW       170
	MOVWF       FARG_procedure_loop_number_2+0 
	MOVLW       0
	MOVWF       FARG_procedure_loop_number_2+1 
	CALL        _procedure_loop+0, 0
;numbering_systems.c,180 :: 		lcd_display_out(txt6, signature);
	MOVLW       _txt6+0
	MOVWF       FARG_lcd_display_out_first_line+0 
	MOVLW       _signature+0
	MOVWF       FARG_lcd_display_out_second_line+0 
	CALL        _lcd_display_out+0, 0
;numbering_systems.c,181 :: 		display_bits(0xA5);
	MOVLW       165
	MOVWF       FARG_display_bits_i+0 
	MOVLW       0
	MOVWF       FARG_display_bits_i+1 
	CALL        _display_bits+0, 0
;numbering_systems.c,182 :: 		display_bits(186);
	MOVLW       186
	MOVWF       FARG_display_bits_i+0 
	MOVLW       0
	MOVWF       FARG_display_bits_i+1 
	CALL        _display_bits+0, 0
;numbering_systems.c,183 :: 		display_bits(055);
	MOVLW       45
	MOVWF       FARG_display_bits_i+0 
	MOVLW       0
	MOVWF       FARG_display_bits_i+1 
	CALL        _display_bits+0, 0
;numbering_systems.c,184 :: 		display_bits(0xF3);
	MOVLW       243
	MOVWF       FARG_display_bits_i+0 
	MOVLW       0
	MOVWF       FARG_display_bits_i+1 
	CALL        _display_bits+0, 0
;numbering_systems.c,185 :: 		display_bits(28);
	MOVLW       28
	MOVWF       FARG_display_bits_i+0 
	MOVLW       0
	MOVWF       FARG_display_bits_i+1 
	CALL        _display_bits+0, 0
;numbering_systems.c,186 :: 		display_bits(0212);
	MOVLW       138
	MOVWF       FARG_display_bits_i+0 
	MOVLW       0
	MOVWF       FARG_display_bits_i+1 
	CALL        _display_bits+0, 0
;numbering_systems.c,187 :: 		display_bits(255);
	MOVLW       255
	MOVWF       FARG_display_bits_i+0 
	MOVLW       0
	MOVWF       FARG_display_bits_i+1 
	CALL        _display_bits+0, 0
;numbering_systems.c,188 :: 		display_bits(0252);
	MOVLW       170
	MOVWF       FARG_display_bits_i+0 
	MOVLW       0
	MOVWF       FARG_display_bits_i+1 
	CALL        _display_bits+0, 0
;numbering_systems.c,189 :: 		display_bits(0xF1);
	MOVLW       241
	MOVWF       FARG_display_bits_i+0 
	MOVLW       0
	MOVWF       FARG_display_bits_i+1 
	CALL        _display_bits+0, 0
;numbering_systems.c,190 :: 		}
	GOTO        L_main8
;numbering_systems.c,191 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
