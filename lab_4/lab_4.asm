
_c_chord:

;lab_4.c,18 :: 		void c_chord(int duration) {
;lab_4.c,19 :: 		Sound_Play(130.81, duration);  // chord C freq 130.81Hz duration 500ms
	MOVLW       130
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVF        FARG_c_chord_duration+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        FARG_c_chord_duration+1, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;lab_4.c,20 :: 		}
L_end_c_chord:
	RETURN      0
; end of _c_chord

_d_chord:

;lab_4.c,23 :: 		void d_chord(int duration) {
;lab_4.c,24 :: 		Sound_Play(146.83, duration);  // chord D freq 146.83Hz duration 500ms
	MOVLW       146
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVF        FARG_d_chord_duration+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        FARG_d_chord_duration+1, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;lab_4.c,25 :: 		}
L_end_d_chord:
	RETURN      0
; end of _d_chord

_e_chord:

;lab_4.c,28 :: 		void e_chord(int duration) {
;lab_4.c,29 :: 		Sound_Play(164.81, duration);  // chord E freq 164.81Hz duration 500ms
	MOVLW       164
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVF        FARG_e_chord_duration+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        FARG_e_chord_duration+1, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;lab_4.c,30 :: 		}
L_end_e_chord:
	RETURN      0
; end of _e_chord

_f_chord:

;lab_4.c,33 :: 		void f_chord(int duration) {
;lab_4.c,34 :: 		Sound_Play(174.61, duration);  // chord F freq 174.61Hz duration 500ms
	MOVLW       174
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVF        FARG_f_chord_duration+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        FARG_f_chord_duration+1, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;lab_4.c,35 :: 		}
L_end_f_chord:
	RETURN      0
; end of _f_chord

_g_chord:

;lab_4.c,38 :: 		void g_chord(int duration) {
;lab_4.c,39 :: 		Sound_Play(196.00, duration);  // chord G freq 196.00Hz duration 500ms
	MOVLW       196
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVF        FARG_g_chord_duration+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        FARG_g_chord_duration+1, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;lab_4.c,40 :: 		}
L_end_g_chord:
	RETURN      0
; end of _g_chord

_h_chord:

;lab_4.c,43 :: 		void h_chord(int duration) {
;lab_4.c,44 :: 		Sound_Play(220.00, duration);  // chord H freq 220.00Hz duration 500ms
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVF        FARG_h_chord_duration+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        FARG_h_chord_duration+1, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;lab_4.c,45 :: 		}
L_end_h_chord:
	RETURN      0
; end of _h_chord

_i_chord:

;lab_4.c,48 :: 		void i_chord(int duration) {
;lab_4.c,49 :: 		Sound_Play(246.94, duration);  // chord I freq 246.94Hz duration 500ms
	MOVLW       246
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVF        FARG_i_chord_duration+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        FARG_i_chord_duration+1, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;lab_4.c,50 :: 		}
L_end_i_chord:
	RETURN      0
; end of _i_chord

_j_chord:

;lab_4.c,53 :: 		void j_chord(int duration) {
;lab_4.c,54 :: 		Sound_Play(261.63, duration);  // chord J freq 261.63Hz duration 500ms
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVF        FARG_j_chord_duration+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        FARG_j_chord_duration+1, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;lab_4.c,55 :: 		}
L_end_j_chord:
	RETURN      0
; end of _j_chord

_main:

;lab_4.c,58 :: 		void main() {     // Main Function (program core)
;lab_4.c,60 :: 		TRISB = 0xFF;           // PORTB as INPUT
	MOVLW       255
	MOVWF       TRISB+0 
;lab_4.c,61 :: 		ANSELB = 0x00;          // PORTB as digital
	CLRF        ANSELB+0 
;lab_4.c,62 :: 		PORTB = 0x00;           // clear PORTB
	CLRF        PORTB+0 
;lab_4.c,63 :: 		C1ON_bit=0;
	BCF         C1ON_bit+0, BitPos(C1ON_bit+0) 
;lab_4.c,64 :: 		C2ON_bit=0;
	BCF         C2ON_bit+0, BitPos(C2ON_bit+0) 
;lab_4.c,69 :: 		Sound_Init(&PORTE, 1);  // init Piezo on PORTE bit 1
	MOVLW       PORTE+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	MOVLW       1
	MOVWF       FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;lab_4.c,72 :: 		while(1) {
L_main0:
;lab_4.c,73 :: 		PORTB = 0x00;  // clear on each pass
	CLRF        PORTB+0 
;lab_4.c,76 :: 		if (Button(&PORTB,1,1,1)) {
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       1
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;lab_4.c,77 :: 		c_chord(50);
	MOVLW       50
	MOVWF       FARG_c_chord_duration+0 
	MOVLW       0
	MOVWF       FARG_c_chord_duration+1 
	CALL        _c_chord+0, 0
;lab_4.c,78 :: 		while(RB0_bit);
L_main3:
	BTFSS       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_main4
	GOTO        L_main3
L_main4:
;lab_4.c,79 :: 		}
L_main2:
;lab_4.c,81 :: 		if (Button(&PORTB,2,1,1)) {
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
;lab_4.c,82 :: 		d_chord(50);
	MOVLW       50
	MOVWF       FARG_d_chord_duration+0 
	MOVLW       0
	MOVWF       FARG_d_chord_duration+1 
	CALL        _d_chord+0, 0
;lab_4.c,83 :: 		while(RB1_bit);
L_main6:
	BTFSS       RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L_main7
	GOTO        L_main6
L_main7:
;lab_4.c,84 :: 		}
L_main5:
;lab_4.c,86 :: 		if (Button(&PORTB,3,1,1)) {
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       3
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
;lab_4.c,87 :: 		e_chord(50);
	MOVLW       50
	MOVWF       FARG_e_chord_duration+0 
	MOVLW       0
	MOVWF       FARG_e_chord_duration+1 
	CALL        _e_chord+0, 0
;lab_4.c,88 :: 		while(RB2_bit);
L_main9:
	BTFSS       RB2_bit+0, BitPos(RB2_bit+0) 
	GOTO        L_main10
	GOTO        L_main9
L_main10:
;lab_4.c,89 :: 		}
L_main8:
;lab_4.c,91 :: 		if (Button(&PORTB,4,1,1)) {
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       4
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
;lab_4.c,92 :: 		f_chord(50);
	MOVLW       50
	MOVWF       FARG_f_chord_duration+0 
	MOVLW       0
	MOVWF       FARG_f_chord_duration+1 
	CALL        _f_chord+0, 0
;lab_4.c,93 :: 		while(RB3_bit);
L_main12:
	BTFSS       RB3_bit+0, BitPos(RB3_bit+0) 
	GOTO        L_main13
	GOTO        L_main12
L_main13:
;lab_4.c,94 :: 		}
L_main11:
;lab_4.c,96 :: 		if (Button(&PORTB,5,1,1)) {
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       5
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
;lab_4.c,97 :: 		g_chord(50);
	MOVLW       50
	MOVWF       FARG_g_chord_duration+0 
	MOVLW       0
	MOVWF       FARG_g_chord_duration+1 
	CALL        _g_chord+0, 0
;lab_4.c,98 :: 		while(RB4_bit);
L_main15:
	BTFSS       RB4_bit+0, BitPos(RB4_bit+0) 
	GOTO        L_main16
	GOTO        L_main15
L_main16:
;lab_4.c,99 :: 		}
L_main14:
;lab_4.c,101 :: 		if (Button(&PORTB,6,1,1)) {
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       6
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
;lab_4.c,102 :: 		h_chord(50);
	MOVLW       50
	MOVWF       FARG_h_chord_duration+0 
	MOVLW       0
	MOVWF       FARG_h_chord_duration+1 
	CALL        _h_chord+0, 0
;lab_4.c,103 :: 		while(RB5_bit);
L_main18:
	BTFSS       RB5_bit+0, BitPos(RB5_bit+0) 
	GOTO        L_main19
	GOTO        L_main18
L_main19:
;lab_4.c,104 :: 		}
L_main17:
;lab_4.c,106 :: 		if (Button(&PORTB,7,1,1)) {
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       7
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main20
;lab_4.c,107 :: 		i_chord(50);
	MOVLW       50
	MOVWF       FARG_i_chord_duration+0 
	MOVLW       0
	MOVWF       FARG_i_chord_duration+1 
	CALL        _i_chord+0, 0
;lab_4.c,108 :: 		while(RB6_bit);
L_main21:
	BTFSS       RB6_bit+0, BitPos(RB6_bit+0) 
	GOTO        L_main22
	GOTO        L_main21
L_main22:
;lab_4.c,109 :: 		}
L_main20:
;lab_4.c,111 :: 		if (Button(&PORTB,8,1,1)) {
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       8
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main23
;lab_4.c,112 :: 		j_chord(50);
	MOVLW       50
	MOVWF       FARG_j_chord_duration+0 
	MOVLW       0
	MOVWF       FARG_j_chord_duration+1 
	CALL        _j_chord+0, 0
;lab_4.c,113 :: 		while(RB7_bit);
L_main24:
	BTFSS       RB7_bit+0, BitPos(RB7_bit+0) 
	GOTO        L_main25
	GOTO        L_main24
L_main25:
;lab_4.c,114 :: 		}
L_main23:
;lab_4.c,115 :: 		}
	GOTO        L_main0
;lab_4.c,116 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
