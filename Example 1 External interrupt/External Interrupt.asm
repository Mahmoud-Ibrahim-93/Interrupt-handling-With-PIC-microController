
_main:

;External Interrupt.c,1 :: 		void main() {
;External Interrupt.c,2 :: 		TRISB.B0=1;   //  set pin B0 as input
	BSF        TRISB+0, 0
;External Interrupt.c,3 :: 		TRISD.B0=0;   //  set pin D0 as output
	BCF        TRISD+0, 0
;External Interrupt.c,4 :: 		PORTD.B0=0;   //  initial output of D0 is LOGIC LOW
	BCF        PORTD+0, 0
;External Interrupt.c,5 :: 		GIE_bit=1;    // This bit Enables Global Interrupts
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;External Interrupt.c,6 :: 		INTE_bit=1;   // This bit enables the external interrupt
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;External Interrupt.c,7 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;External Interrupt.c,8 :: 		void interrupt(void){
;External Interrupt.c,10 :: 		if(INTF_bit==1){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;External Interrupt.c,11 :: 		INTF_bit=0;   // To stop recursive interrupt execution
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;External Interrupt.c,12 :: 		PORTD.B0=~PORTD.B0;  // Toggle execution
	MOVLW      1
	XORWF      PORTD+0, 1
;External Interrupt.c,13 :: 		}
L_interrupt0:
;External Interrupt.c,14 :: 		}
L_end_interrupt:
L__interrupt3:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt
