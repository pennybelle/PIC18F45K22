
_main:

;lab_2.c,37 :: 		void main() {     // Main Function (program core)
;lab_2.c,38 :: 		TRISC = 0x00;   // TRISC sets direction of data traffic on PORTC to Output
	CLRF        TRISC+0 
;lab_2.c,39 :: 		PORTC = 0x00;   // Set PORTC logic to low
	CLRF        PORTC+0 
;lab_2.c,40 :: 		TRISB = 0xFF;   // TRISB sets direction of data traffic on PORTB to Input
	MOVLW       255
	MOVWF       TRISB+0 
;lab_2.c,41 :: 		ANSELB = 0x00;  //
	CLRF        ANSELB+0 
;lab_2.c,44 :: 		while(1) {
L_main0:
;lab_2.c,54 :: 		if (PORTB == 0b00000001) {
	MOVF        PORTB+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main2
;lab_2.c,55 :: 		PORTC = 0x55;
	MOVLW       85
	MOVWF       PORTC+0 
;lab_2.c,56 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
;lab_2.c,57 :: 		} else {
	GOTO        L_main4
L_main2:
;lab_2.c,58 :: 		PORTC = 0xAA;
	MOVLW       170
	MOVWF       PORTC+0 
;lab_2.c,59 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
;lab_2.c,60 :: 		}
L_main4:
;lab_2.c,61 :: 		}
	GOTO        L_main0
;lab_2.c,62 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
