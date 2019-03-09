
_main:

;BlinkingLedExample.c,1 :: 		void main() {
;BlinkingLedExample.c,2 :: 		TRISB.B0=0;   //  set pin B0 as output
	BCF        TRISB+0, 0
;BlinkingLedExample.c,3 :: 		PORTB.B0=0;   //  initial output of B0 is LOGIC LOW
	BCF        PORTB+0, 0
;BlinkingLedExample.c,4 :: 		while(1){
L_main0:
;BlinkingLedExample.c,5 :: 		PORTB.B0=1;   //   output of B0 is Set
	BSF        PORTB+0, 0
;BlinkingLedExample.c,6 :: 		delay_ms(1000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
;BlinkingLedExample.c,7 :: 		PORTB.B0=0;   //   output of B0 is reset
	BCF        PORTB+0, 0
;BlinkingLedExample.c,8 :: 		delay_ms(1000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;BlinkingLedExample.c,9 :: 		}
	GOTO       L_main0
;BlinkingLedExample.c,10 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
