
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

;lab_3.c,19 :: 		void option1() {
;lab_3.c,20 :: 		PORTB = 0xFF;
	MOVLW       255
	MOVWF       PORTB+0 
;lab_3.c,21 :: 		delay_ms(1000);
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
;lab_3.c,22 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;lab_3.c,23 :: 		delay_ms(1000);
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
;lab_3.c,24 :: 		}
L_end_option1:
	RETURN      0
; end of _option1

_option2:

;lab_3.c,27 :: 		void option2() {
;lab_3.c,28 :: 		PORTC = 0xFF;
	MOVLW       255
	MOVWF       PORTC+0 
;lab_3.c,29 :: 		delay_ms(1000);
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
;lab_3.c,30 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;lab_3.c,31 :: 		delay_ms(1000);
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
;lab_3.c,32 :: 		}
L_end_option2:
	RETURN      0
; end of _option2

_option3:

;lab_3.c,35 :: 		void option3() {
;lab_3.c,36 :: 		PORTD = 0xFF;
	MOVLW       255
	MOVWF       PORTD+0 
;lab_3.c,37 :: 		delay_ms(1000);
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
;lab_3.c,38 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;lab_3.c,39 :: 		delay_ms(1000);
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
;lab_3.c,40 :: 		}
L_end_option3:
	RETURN      0
; end of _option3

_option4:

;lab_3.c,43 :: 		void option4() {
;lab_3.c,44 :: 		PORTB = 0x55;
	MOVLW       85
	MOVWF       PORTB+0 
;lab_3.c,45 :: 		delay_ms(1000);
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
;lab_3.c,46 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;lab_3.c,47 :: 		delay_ms(1000);
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
;lab_3.c,48 :: 		}
L_end_option4:
	RETURN      0
; end of _option4

_option5:

;lab_3.c,51 :: 		void option5() {
;lab_3.c,52 :: 		PORTC = 0xAA;
	MOVLW       170
	MOVWF       PORTC+0 
;lab_3.c,53 :: 		delay_ms(1000);
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
;lab_3.c,54 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;lab_3.c,55 :: 		delay_ms(1000);
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
;lab_3.c,56 :: 		}
L_end_option5:
	RETURN      0
; end of _option5

_option6:

;lab_3.c,59 :: 		void option6() {
;lab_3.c,60 :: 		PORTD = 0x55;
	MOVLW       85
	MOVWF       PORTD+0 
;lab_3.c,61 :: 		delay_ms(1000);
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
;lab_3.c,62 :: 		PORTD = 0xAA;
	MOVLW       170
	MOVWF       PORTD+0 
;lab_3.c,63 :: 		delay_ms(1000);
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
;lab_3.c,64 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;lab_3.c,65 :: 		}
L_end_option6:
	RETURN      0
; end of _option6

_main:

;lab_3.c,67 :: 		void main() {     // Main Function (program core)
;lab_3.c,68 :: 		while(1) {
L_main12:
;lab_3.c,69 :: 		SetupClearPorts();
	CALL        _SetupClearPorts+0, 0
;lab_3.c,70 :: 		option6();
	CALL        _option6+0, 0
;lab_3.c,71 :: 		option5();
	CALL        _option5+0, 0
;lab_3.c,72 :: 		option4();
	CALL        _option4+0, 0
;lab_3.c,73 :: 		option3();
	CALL        _option3+0, 0
;lab_3.c,74 :: 		option2();
	CALL        _option2+0, 0
;lab_3.c,75 :: 		option1();
	CALL        _option1+0, 0
;lab_3.c,76 :: 		}
	GOTO        L_main12
;lab_3.c,77 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
