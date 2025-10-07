
_SetupClearPorts:

;lab_3.c,9 :: 		void SetupClearPorts() {
;lab_3.c,10 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;lab_3.c,11 :: 		TRISC = 0x00;
	CLRF        TRISC+0 
;lab_3.c,12 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;lab_3.c,13 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;lab_3.c,14 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;lab_3.c,15 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;lab_3.c,16 :: 		}
L_end_SetupClearPorts:
	RETURN      0
; end of _SetupClearPorts

_option1:

;lab_3.c,20 :: 		void option1() {
;lab_3.c,21 :: 		PORTB = 0xFF;
	MOVLW       255
	MOVWF       PORTB+0 
;lab_3.c,22 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_option10:
	DECFSZ      R13, 1, 1
	BRA         L_option10
	DECFSZ      R12, 1, 1
	BRA         L_option10
	DECFSZ      R11, 1, 1
	BRA         L_option10
	NOP
	NOP
;lab_3.c,23 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;lab_3.c,24 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_option11:
	DECFSZ      R13, 1, 1
	BRA         L_option11
	DECFSZ      R12, 1, 1
	BRA         L_option11
	DECFSZ      R11, 1, 1
	BRA         L_option11
	NOP
	NOP
;lab_3.c,25 :: 		}
L_end_option1:
	RETURN      0
; end of _option1

_option2:

;lab_3.c,29 :: 		void option2() {
;lab_3.c,30 :: 		PORTC = 0xFF;
	MOVLW       255
	MOVWF       PORTC+0 
;lab_3.c,31 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_option22:
	DECFSZ      R13, 1, 1
	BRA         L_option22
	DECFSZ      R12, 1, 1
	BRA         L_option22
	DECFSZ      R11, 1, 1
	BRA         L_option22
	NOP
	NOP
;lab_3.c,32 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;lab_3.c,33 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_option23:
	DECFSZ      R13, 1, 1
	BRA         L_option23
	DECFSZ      R12, 1, 1
	BRA         L_option23
	DECFSZ      R11, 1, 1
	BRA         L_option23
	NOP
	NOP
;lab_3.c,34 :: 		}
L_end_option2:
	RETURN      0
; end of _option2

_option3:

;lab_3.c,38 :: 		void option3() {
;lab_3.c,39 :: 		PORTD = 0xFF;
	MOVLW       255
	MOVWF       PORTD+0 
;lab_3.c,40 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_option34:
	DECFSZ      R13, 1, 1
	BRA         L_option34
	DECFSZ      R12, 1, 1
	BRA         L_option34
	DECFSZ      R11, 1, 1
	BRA         L_option34
	NOP
	NOP
;lab_3.c,41 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;lab_3.c,42 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_option35:
	DECFSZ      R13, 1, 1
	BRA         L_option35
	DECFSZ      R12, 1, 1
	BRA         L_option35
	DECFSZ      R11, 1, 1
	BRA         L_option35
	NOP
	NOP
;lab_3.c,43 :: 		}
L_end_option3:
	RETURN      0
; end of _option3

_option4:

;lab_3.c,47 :: 		void option4() {
;lab_3.c,48 :: 		PORTB = 0x55;
	MOVLW       85
	MOVWF       PORTB+0 
;lab_3.c,49 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_option46:
	DECFSZ      R13, 1, 1
	BRA         L_option46
	DECFSZ      R12, 1, 1
	BRA         L_option46
	DECFSZ      R11, 1, 1
	BRA         L_option46
	NOP
	NOP
;lab_3.c,50 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;lab_3.c,51 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_option47:
	DECFSZ      R13, 1, 1
	BRA         L_option47
	DECFSZ      R12, 1, 1
	BRA         L_option47
	DECFSZ      R11, 1, 1
	BRA         L_option47
	NOP
	NOP
;lab_3.c,52 :: 		}
L_end_option4:
	RETURN      0
; end of _option4

_option5:

;lab_3.c,56 :: 		void option5() {
;lab_3.c,57 :: 		PORTC = 0xAA;
	MOVLW       170
	MOVWF       PORTC+0 
;lab_3.c,58 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_option58:
	DECFSZ      R13, 1, 1
	BRA         L_option58
	DECFSZ      R12, 1, 1
	BRA         L_option58
	DECFSZ      R11, 1, 1
	BRA         L_option58
	NOP
	NOP
;lab_3.c,59 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;lab_3.c,60 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_option59:
	DECFSZ      R13, 1, 1
	BRA         L_option59
	DECFSZ      R12, 1, 1
	BRA         L_option59
	DECFSZ      R11, 1, 1
	BRA         L_option59
	NOP
	NOP
;lab_3.c,61 :: 		}
L_end_option5:
	RETURN      0
; end of _option5

_option6:

;lab_3.c,65 :: 		void option6() {
;lab_3.c,66 :: 		PORTD = 0x55;
	MOVLW       85
	MOVWF       PORTD+0 
;lab_3.c,67 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_option610:
	DECFSZ      R13, 1, 1
	BRA         L_option610
	DECFSZ      R12, 1, 1
	BRA         L_option610
	DECFSZ      R11, 1, 1
	BRA         L_option610
	NOP
	NOP
;lab_3.c,68 :: 		PORTD = 0xAA;
	MOVLW       170
	MOVWF       PORTD+0 
;lab_3.c,69 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_option611:
	DECFSZ      R13, 1, 1
	BRA         L_option611
	DECFSZ      R12, 1, 1
	BRA         L_option611
	DECFSZ      R11, 1, 1
	BRA         L_option611
	NOP
	NOP
;lab_3.c,70 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;lab_3.c,71 :: 		}
L_end_option6:
	RETURN      0
; end of _option6

_walkPORTC1:

;lab_3.c,75 :: 		void walkPORTC1() {
;lab_3.c,77 :: 		for(i=1; i<=128; i*=2) {
	MOVLW       1
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
L_walkPORTC112:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__walkPORTC138
	MOVF        R1, 0 
	SUBLW       128
L__walkPORTC138:
	BTFSS       STATUS+0, 0 
	GOTO        L_walkPORTC113
;lab_3.c,78 :: 		PORTC = i;  // set PORTC to value of iterator var
	MOVF        R1, 0 
	MOVWF       PORTC+0 
;lab_3.c,79 :: 		delay_ms(250);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_walkPORTC115:
	DECFSZ      R13, 1, 1
	BRA         L_walkPORTC115
	DECFSZ      R12, 1, 1
	BRA         L_walkPORTC115
	DECFSZ      R11, 1, 1
	BRA         L_walkPORTC115
	NOP
	NOP
;lab_3.c,77 :: 		for(i=1; i<=128; i*=2) {
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R2, 1 
;lab_3.c,80 :: 		}
	GOTO        L_walkPORTC112
L_walkPORTC113:
;lab_3.c,81 :: 		}
L_end_walkPORTC1:
	RETURN      0
; end of _walkPORTC1

_walkPORTC2:

;lab_3.c,85 :: 		void walkPORTC2() {
;lab_3.c,87 :: 		for(i=128; i>=1; i/=2) {
	MOVLW       128
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
L_walkPORTC216:
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__walkPORTC240
	MOVLW       1
	SUBWF       R1, 0 
L__walkPORTC240:
	BTFSS       STATUS+0, 0 
	GOTO        L_walkPORTC217
;lab_3.c,88 :: 		PORTC = i;  // set PORTC to value of iterator var
	MOVF        R1, 0 
	MOVWF       PORTC+0 
;lab_3.c,89 :: 		delay_ms(250);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_walkPORTC219:
	DECFSZ      R13, 1, 1
	BRA         L_walkPORTC219
	DECFSZ      R12, 1, 1
	BRA         L_walkPORTC219
	DECFSZ      R11, 1, 1
	BRA         L_walkPORTC219
	NOP
	NOP
;lab_3.c,87 :: 		for(i=128; i>=1; i/=2) {
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R2, 7 
	BTFSC       R2, 6 
	BSF         R2, 7 
	BTFSS       R2, 7 
	GOTO        L__walkPORTC241
	BTFSS       STATUS+0, 0 
	GOTO        L__walkPORTC241
	INFSNZ      R1, 1 
	INCF        R2, 1 
L__walkPORTC241:
;lab_3.c,90 :: 		}
	GOTO        L_walkPORTC216
L_walkPORTC217:
;lab_3.c,91 :: 		}
L_end_walkPORTC2:
	RETURN      0
; end of _walkPORTC2

_walkPORTD1:

;lab_3.c,95 :: 		void walkPORTD1() {
;lab_3.c,97 :: 		for(i=1; i<=128; i*=2) {
	MOVLW       1
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
L_walkPORTD120:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__walkPORTD143
	MOVF        R1, 0 
	SUBLW       128
L__walkPORTD143:
	BTFSS       STATUS+0, 0 
	GOTO        L_walkPORTD121
;lab_3.c,98 :: 		PORTD = i;  // set PORTC to value of iterator var
	MOVF        R1, 0 
	MOVWF       PORTD+0 
;lab_3.c,99 :: 		delay_ms(250);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_walkPORTD123:
	DECFSZ      R13, 1, 1
	BRA         L_walkPORTD123
	DECFSZ      R12, 1, 1
	BRA         L_walkPORTD123
	DECFSZ      R11, 1, 1
	BRA         L_walkPORTD123
	NOP
	NOP
;lab_3.c,97 :: 		for(i=1; i<=128; i*=2) {
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R2, 1 
;lab_3.c,100 :: 		}
	GOTO        L_walkPORTD120
L_walkPORTD121:
;lab_3.c,101 :: 		}
L_end_walkPORTD1:
	RETURN      0
; end of _walkPORTD1

_walkPORTD2:

;lab_3.c,105 :: 		void walkPORTD2() {
;lab_3.c,107 :: 		for(i=128; i>=1; i/=2) {
	MOVLW       128
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
L_walkPORTD224:
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__walkPORTD245
	MOVLW       1
	SUBWF       R1, 0 
L__walkPORTD245:
	BTFSS       STATUS+0, 0 
	GOTO        L_walkPORTD225
;lab_3.c,108 :: 		PORTD = i;  // set PORTC to value of iterator var
	MOVF        R1, 0 
	MOVWF       PORTD+0 
;lab_3.c,109 :: 		delay_ms(250);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_walkPORTD227:
	DECFSZ      R13, 1, 1
	BRA         L_walkPORTD227
	DECFSZ      R12, 1, 1
	BRA         L_walkPORTD227
	DECFSZ      R11, 1, 1
	BRA         L_walkPORTD227
	NOP
	NOP
;lab_3.c,107 :: 		for(i=128; i>=1; i/=2) {
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R2, 7 
	BTFSC       R2, 6 
	BSF         R2, 7 
	BTFSS       R2, 7 
	GOTO        L__walkPORTD246
	BTFSS       STATUS+0, 0 
	GOTO        L__walkPORTD246
	INFSNZ      R1, 1 
	INCF        R2, 1 
L__walkPORTD246:
;lab_3.c,110 :: 		}
	GOTO        L_walkPORTD224
L_walkPORTD225:
;lab_3.c,111 :: 		}
L_end_walkPORTD2:
	RETURN      0
; end of _walkPORTD2

_main:

;lab_3.c,114 :: 		void main() {     // Main Function (program core)
;lab_3.c,116 :: 		while(1) {
L_main28:
;lab_3.c,137 :: 		SetupClearPorts();
	CALL        _SetupClearPorts+0, 0
;lab_3.c,138 :: 		walkPORTC1();
	CALL        _walkPORTC1+0, 0
;lab_3.c,139 :: 		walkPORTC2();
	CALL        _walkPORTC2+0, 0
;lab_3.c,141 :: 		SetupClearPorts();
	CALL        _SetupClearPorts+0, 0
;lab_3.c,142 :: 		walkPORTD1();
	CALL        _walkPORTD1+0, 0
;lab_3.c,143 :: 		walkPORTD2();
	CALL        _walkPORTD2+0, 0
;lab_3.c,145 :: 		SetupClearPorts();
	CALL        _SetupClearPorts+0, 0
;lab_3.c,146 :: 		walkPORTD2();
	CALL        _walkPORTD2+0, 0
;lab_3.c,147 :: 		walkPORTD1();
	CALL        _walkPORTD1+0, 0
;lab_3.c,149 :: 		SetupClearPorts();
	CALL        _SetupClearPorts+0, 0
;lab_3.c,150 :: 		walkPORTC2();
	CALL        _walkPORTC2+0, 0
;lab_3.c,151 :: 		walkPORTC1();
	CALL        _walkPORTC1+0, 0
;lab_3.c,152 :: 		}
	GOTO        L_main28
;lab_3.c,153 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
