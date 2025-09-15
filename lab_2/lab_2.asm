
_main:

;lab_2.c,11 :: 		void main() {     // Main Function (program core)
;lab_2.c,12 :: 		TRISC = 0x00;   // TRISC sets direction of data traffic on PORTC to Output
	CLRF        TRISC+0 
;lab_2.c,13 :: 		PORTC = 0x00;   // Set PORTC logic to low
	CLRF        PORTC+0 
;lab_2.c,14 :: 		TRISB = 0xFF;   // TRISB sets direction of data traffic on PORTB to Input
	MOVLW       255
	MOVWF       TRISB+0 
;lab_2.c,15 :: 		ANSELB = 0x00;
	CLRF        ANSELB+0 
;lab_2.c,17 :: 		while(1) {
L_main0:
;lab_2.c,62 :: 		int var1 = 0b10101010;
	MOVLW       170
	MOVWF       main_var1_L1+0 
	MOVLW       0
	MOVWF       main_var1_L1+1 
	MOVLW       85
	MOVWF       main_var2_L1+0 
	MOVLW       0
	MOVWF       main_var2_L1+1 
	MOVLW       15
	MOVWF       main_var3_L1+0 
	MOVLW       0
	MOVWF       main_var3_L1+1 
;lab_2.c,66 :: 		PORTC = var1 & var2;
	MOVF        main_var2_L1+0, 0 
	ANDWF       main_var1_L1+0, 0 
	MOVWF       PORTC+0 
;lab_2.c,67 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;lab_2.c,68 :: 		PORTC = var1 | var2;
	MOVF        main_var2_L1+0, 0 
	IORWF       main_var1_L1+0, 0 
	MOVWF       PORTC+0 
;lab_2.c,69 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;lab_2.c,70 :: 		PORTC = var1 ^ var2;
	MOVF        main_var2_L1+0, 0 
	XORWF       main_var1_L1+0, 0 
	MOVWF       PORTC+0 
;lab_2.c,71 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
	NOP
;lab_2.c,73 :: 		PORTC = ~var3;
	COMF        main_var3_L1+0, 0 
	MOVWF       PORTC+0 
;lab_2.c,74 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
	NOP
;lab_2.c,75 :: 		}
	GOTO        L_main0
;lab_2.c,76 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
