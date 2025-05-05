
_main:

;logical_operators.c,14 :: 		void main() {
;logical_operators.c,15 :: 		TRISB = 0xFF; // set portB as input
	MOVLW       255
	MOVWF       TRISB+0 
;logical_operators.c,16 :: 		TRISC = 0xFF; // set portC as input
	MOVLW       255
	MOVWF       TRISC+0 
;logical_operators.c,17 :: 		TRISD = 0x00; // set portD as output
	CLRF        TRISD+0 
;logical_operators.c,18 :: 		TRISA = 0xFF; // set portA as input
	MOVLW       255
	MOVWF       TRISA+0 
;logical_operators.c,21 :: 		ANSELB = 0x00;
	CLRF        ANSELB+0 
;logical_operators.c,22 :: 		ANSELC = 0x00;
	CLRF        ANSELC+0 
;logical_operators.c,23 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;logical_operators.c,24 :: 		ANSELA = 0x00;
	CLRF        ANSELA+0 
;logical_operators.c,26 :: 		while(1) {
L_main0:
;logical_operators.c,27 :: 		if (PORTA == 0b00000001) {
	MOVF        PORTA+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main2
;logical_operators.c,28 :: 		PORTD = PORTB & PORTC;
	MOVF        PORTC+0, 0 
	ANDWF       PORTB+0, 0 
	MOVWF       PORTD+0 
;logical_operators.c,29 :: 		} else if (PORTA == 0b00000010) {
	GOTO        L_main3
L_main2:
	MOVF        PORTA+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;logical_operators.c,30 :: 		PORTD = PORTB | PORTC;
	MOVF        PORTC+0, 0 
	IORWF       PORTB+0, 0 
	MOVWF       PORTD+0 
;logical_operators.c,31 :: 		} else if (PORTA == 0b00000100) {
	GOTO        L_main5
L_main4:
	MOVF        PORTA+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
;logical_operators.c,32 :: 		PORTD = PORTB ^ PORTC;
	MOVF        PORTC+0, 0 
	XORWF       PORTB+0, 0 
	MOVWF       PORTD+0 
;logical_operators.c,33 :: 		} else if (PORTA == 0b0001000) {
	GOTO        L_main7
L_main6:
	MOVF        PORTA+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
;logical_operators.c,34 :: 		PORTD = ~PORTB;
	COMF        PORTB+0, 0 
	MOVWF       PORTD+0 
;logical_operators.c,35 :: 		} else if (PORTA == 0b00010000) {
	GOTO        L_main9
L_main8:
	MOVF        PORTA+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
;logical_operators.c,36 :: 		for (i=1; i<=8; i++) {
	MOVLW       1
	MOVWF       _i+0 
	MOVLW       0
	MOVWF       _i+1 
L_main11:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main22
	MOVF        _i+0, 0 
	SUBLW       8
L__main22:
	BTFSS       STATUS+0, 0 
	GOTO        L_main12
;logical_operators.c,37 :: 		PORTD = reference;
	MOVF        _reference+0, 0 
	MOVWF       PORTD+0 
;logical_operators.c,38 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main14:
	DECFSZ      R13, 1, 1
	BRA         L_main14
	DECFSZ      R12, 1, 1
	BRA         L_main14
	DECFSZ      R11, 1, 1
	BRA         L_main14
	NOP
	NOP
;logical_operators.c,39 :: 		reference = reference << 1;
	RLCF        _reference+0, 1 
	BCF         _reference+0, 0 
	RLCF        _reference+1, 1 
;logical_operators.c,36 :: 		for (i=1; i<=8; i++) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;logical_operators.c,40 :: 		}
	GOTO        L_main11
L_main12:
;logical_operators.c,41 :: 		reference = 0b00000001;
	MOVLW       1
	MOVWF       _reference+0 
	MOVLW       0
	MOVWF       _reference+1 
;logical_operators.c,42 :: 		} else if (PORTA == 0b00100000) {
	GOTO        L_main15
L_main10:
	MOVF        PORTA+0, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
;logical_operators.c,43 :: 		for (i=1; i<=8; i++) {
	MOVLW       1
	MOVWF       _i+0 
	MOVLW       0
	MOVWF       _i+1 
L_main17:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main23
	MOVF        _i+0, 0 
	SUBLW       8
L__main23:
	BTFSS       STATUS+0, 0 
	GOTO        L_main18
;logical_operators.c,44 :: 		PORTD = reference2;
	MOVF        _reference2+0, 0 
	MOVWF       PORTD+0 
;logical_operators.c,45 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main20:
	DECFSZ      R13, 1, 1
	BRA         L_main20
	DECFSZ      R12, 1, 1
	BRA         L_main20
	DECFSZ      R11, 1, 1
	BRA         L_main20
	NOP
	NOP
;logical_operators.c,46 :: 		reference2 = reference2 >> 1;
	RRCF        _reference2+1, 1 
	RRCF        _reference2+0, 1 
	BCF         _reference2+1, 7 
	BTFSC       _reference2+1, 6 
	BSF         _reference2+1, 7 
;logical_operators.c,43 :: 		for (i=1; i<=8; i++) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;logical_operators.c,47 :: 		}
	GOTO        L_main17
L_main18:
;logical_operators.c,48 :: 		reference2 = 0b10000000;
	MOVLW       128
	MOVWF       _reference2+0 
	MOVLW       0
	MOVWF       _reference2+1 
;logical_operators.c,49 :: 		}
L_main16:
L_main15:
L_main9:
L_main7:
L_main5:
L_main3:
;logical_operators.c,50 :: 		}
	GOTO        L_main0
;logical_operators.c,51 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
