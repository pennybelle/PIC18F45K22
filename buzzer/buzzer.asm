
_main:

;buzzer.c,9 :: 		void main() {
;buzzer.c,10 :: 		TRISB = 0x0F; // set first four bits on B as inputs
	MOVLW       15
	MOVWF       TRISB+0 
;buzzer.c,11 :: 		ANSELB = 0x00; // set as digital inputs
	CLRF        ANSELB+0 
;buzzer.c,12 :: 		PORTB = 0x00; // clear, set to logic low
	CLRF        PORTB+0 
;buzzer.c,14 :: 		TRISC = 0x00; // set C as output
	CLRF        TRISC+0 
;buzzer.c,15 :: 		PORTC = 0x00; // clear, set to logic low
	CLRF        PORTC+0 
;buzzer.c,17 :: 		while(1) {
L_main0:
;buzzer.c,20 :: 		PORTC = 0x00; // set to low each loop start
	CLRF        PORTC+0 
;buzzer.c,22 :: 		a = RB0_bit; // set each var to a bit on port B
	MOVLW       0
	BTFSC       RB0_bit+0, BitPos(RB0_bit+0) 
	MOVLW       1
	MOVWF       R4 
	CLRF        R5 
;buzzer.c,23 :: 		b = RB1_bit;
	MOVLW       0
	BTFSC       RB1_bit+0, BitPos(RB1_bit+0) 
	MOVLW       1
	MOVWF       R6 
	CLRF        R7 
;buzzer.c,24 :: 		c = RB2_bit;
	MOVLW       0
	BTFSC       RB2_bit+0, BitPos(RB2_bit+0) 
	MOVLW       1
	MOVWF       R8 
	CLRF        R9 
;buzzer.c,25 :: 		d = RB3_bit;
	MOVLW       0
	BTFSC       RB3_bit+0, BitPos(RB3_bit+0) 
	MOVLW       1
	MOVWF       R14 
	CLRF        R15 
;buzzer.c,27 :: 		x = a & b | b & c & d | a & c; // bitwise statement to determine logic out
	MOVF        R6, 0 
	ANDWF       R4, 0 
	MOVWF       R2 
	MOVF        R5, 0 
	ANDWF       R7, 0 
	MOVWF       R3 
	MOVF        R8, 0 
	ANDWF       R6, 0 
	MOVWF       R0 
	MOVF        R7, 0 
	ANDWF       R9, 0 
	MOVWF       R1 
	MOVF        R14, 0 
	ANDWF       R0, 1 
	MOVF        R15, 0 
	ANDWF       R1, 1 
	MOVF        R0, 0 
	IORWF       R2, 1 
	MOVF        R1, 0 
	IORWF       R3, 1 
	MOVF        R8, 0 
	ANDWF       R4, 0 
	MOVWF       R0 
	MOVF        R5, 0 
	ANDWF       R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	IORWF       R2, 1 
	MOVF        R1, 0 
	IORWF       R3, 1 
;buzzer.c,29 :: 		if (x==1) {
	MOVLW       0
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main5
	MOVLW       1
	XORWF       R2, 0 
L__main5:
	BTFSS       STATUS+0, 2 
	GOTO        L_main2
;buzzer.c,30 :: 		PORTC = 0x01;
	MOVLW       1
	MOVWF       PORTC+0 
;buzzer.c,31 :: 		delay_ms(1000);
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
;buzzer.c,32 :: 		}
L_main2:
;buzzer.c,33 :: 		}
	GOTO        L_main0
;buzzer.c,34 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
