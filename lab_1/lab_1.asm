
_knight_rider:

;lab_1.c,9 :: 		void knight_rider() {
;lab_1.c,10 :: 		int number = 1;  // bit used to walk via knight_rider()
	MOVLW       1
	MOVWF       knight_rider_number_L0+0 
	MOVLW       0
	MOVWF       knight_rider_number_L0+1 
;lab_1.c,11 :: 		PORTD = ~0x00;  // refresh portd (uses compliment of 0 for anode LEDs)
	MOVLW       255
	MOVWF       PORTD+0 
;lab_1.c,14 :: 		while (number <= 128) {  // once bit reaches 256 it leaves the loop
L_knight_rider0:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       knight_rider_number_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__knight_rider9
	MOVF        knight_rider_number_L0+0, 0 
	SUBLW       128
L__knight_rider9:
	BTFSS       STATUS+0, 0 
	GOTO        L_knight_rider1
;lab_1.c,15 :: 		PORTC = number;  // set portc to value of bit
	MOVF        knight_rider_number_L0+0, 0 
	MOVWF       PORTC+0 
;lab_1.c,16 :: 		delay_ms(1000);  // delay 250ms
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_knight_rider2:
	DECFSZ      R13, 1, 1
	BRA         L_knight_rider2
	DECFSZ      R12, 1, 1
	BRA         L_knight_rider2
	DECFSZ      R11, 1, 1
	BRA         L_knight_rider2
	NOP
	NOP
;lab_1.c,17 :: 		number *= 2;  // multiply bit by 2 to walk bit forward across LEDs
	RLCF        knight_rider_number_L0+0, 1 
	BCF         knight_rider_number_L0+0, 0 
	RLCF        knight_rider_number_L0+1, 1 
;lab_1.c,18 :: 		}
	GOTO        L_knight_rider0
L_knight_rider1:
;lab_1.c,20 :: 		number = 1;  // bring back bit to 1
	MOVLW       1
	MOVWF       knight_rider_number_L0+0 
	MOVLW       0
	MOVWF       knight_rider_number_L0+1 
;lab_1.c,21 :: 		PORTC = 0x00;  // refresh portc
	CLRF        PORTC+0 
;lab_1.c,24 :: 		while (number <= 128) {  // once bit reaches 256 it leaves the loop
L_knight_rider3:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       knight_rider_number_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__knight_rider10
	MOVF        knight_rider_number_L0+0, 0 
	SUBLW       128
L__knight_rider10:
	BTFSS       STATUS+0, 0 
	GOTO        L_knight_rider4
;lab_1.c,25 :: 		PORTD = ~number;  // set portd to value of bit
	COMF        knight_rider_number_L0+0, 0 
	MOVWF       PORTD+0 
;lab_1.c,26 :: 		delay_ms(1000);  // delay 250ms
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_knight_rider5:
	DECFSZ      R13, 1, 1
	BRA         L_knight_rider5
	DECFSZ      R12, 1, 1
	BRA         L_knight_rider5
	DECFSZ      R11, 1, 1
	BRA         L_knight_rider5
	NOP
	NOP
;lab_1.c,27 :: 		number *= 2;  // multiply bit by 2 to walk bit forward across LEDs
	RLCF        knight_rider_number_L0+0, 1 
	BCF         knight_rider_number_L0+0, 0 
	RLCF        knight_rider_number_L0+1, 1 
;lab_1.c,28 :: 		}
	GOTO        L_knight_rider3
L_knight_rider4:
;lab_1.c,29 :: 		}
L_end_knight_rider:
	RETURN      0
; end of _knight_rider

_main:

;lab_1.c,32 :: 		void main() {    // Main Function (program core)
;lab_1.c,33 :: 		TRISA = 0x00;  // TRISA sets direction of data traffic on PORTA to Output
	CLRF        TRISA+0 
;lab_1.c,34 :: 		TRISB = 0x00;  // TRISB sets direction of data traffic on PORTB to Output
	CLRF        TRISB+0 
;lab_1.c,35 :: 		TRISC = 0x00;  // TRISC sets direction of data traffic on PORTC to Output
	CLRF        TRISC+0 
;lab_1.c,36 :: 		TRISD = 0x00;  // TRISD sets direction of data traffic on PORTD to Output
	CLRF        TRISD+0 
;lab_1.c,38 :: 		while(1) {
L_main6:
;lab_1.c,39 :: 		knight_rider();
	CALL        _knight_rider+0, 0
;lab_1.c,40 :: 		}
	GOTO        L_main6
;lab_1.c,41 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
