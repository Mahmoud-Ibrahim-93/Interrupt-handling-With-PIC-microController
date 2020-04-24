
_initialize_timer_Interrupt:

;Timer Interrupt.c,19 :: 		void initialize_timer_Interrupt(void){
;Timer Interrupt.c,20 :: 		TMR0IE_bit=1;       // Enable timer 0 interrupt
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;Timer Interrupt.c,21 :: 		GIE_bit=1;          //Enable Global Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;Timer Interrupt.c,22 :: 		T0CS_bit=0;                  // Select f/4 clock for the TMR0
	BCF        T0CS_bit+0, BitPos(T0CS_bit+0)
;Timer Interrupt.c,23 :: 		PSA_bit=0;                 // Prescaler is assigned to the Timer0 module
	BCF        PSA_bit+0, BitPos(PSA_bit+0)
;Timer Interrupt.c,24 :: 		PS0_bit=0;                // Set pre-scaler to 32
	BCF        PS0_bit+0, BitPos(PS0_bit+0)
;Timer Interrupt.c,25 :: 		PS1_bit=0;                // PS2,PS1,PS0 = 100
	BCF        PS1_bit+0, BitPos(PS1_bit+0)
;Timer Interrupt.c,26 :: 		PS2_bit=1;
	BSF        PS2_bit+0, BitPos(PS2_bit+0)
;Timer Interrupt.c,27 :: 		TMR0=6;                  //counter starting value
	MOVLW      6
	MOVWF      TMR0+0
;Timer Interrupt.c,28 :: 		}
L_end_initialize_timer_Interrupt:
	RETURN
; end of _initialize_timer_Interrupt

_main:

;Timer Interrupt.c,30 :: 		void main() {
;Timer Interrupt.c,31 :: 		Lcd_Init();   // Initiate the LCD
	CALL       _Lcd_Init+0
;Timer Interrupt.c,32 :: 		LCD_Cmd(_LCD_CURSOR_OFF);     // Stop the cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Timer Interrupt.c,33 :: 		Lcd_Out(1,1,"Elapesed Time:");  // Show elapsed time message
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Timer_32Interrupt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Timer Interrupt.c,34 :: 		initialize_timer_Interrupt();   // invoke timer interrupt initialization function
	CALL       _initialize_timer_Interrupt+0
;Timer Interrupt.c,35 :: 		while(1){
L_main0:
;Timer Interrupt.c,36 :: 		if(counter==125){  // check if the counter reaches 125
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main6
	MOVLW      125
	XORWF      _counter+0, 0
L__main6:
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;Timer Interrupt.c,37 :: 		counter=0;      // start counter from the beginning
	CLRF       _counter+0
	CLRF       _counter+1
;Timer Interrupt.c,38 :: 		time=time++;    // increase time one second
	INCF       _time+0, 1
	BTFSC      STATUS+0, 2
	INCF       _time+1, 1
;Timer Interrupt.c,39 :: 		IntToStrWithZeros(time, txt);  // convert the number of seconds to string
	MOVF       _time+0, 0
	MOVWF      FARG_IntToStrWithZeros_input+0
	MOVF       _time+1, 0
	MOVWF      FARG_IntToStrWithZeros_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStrWithZeros_output+0
	CALL       _IntToStrWithZeros+0
;Timer Interrupt.c,40 :: 		Lcd_Out(2,1,txt);              // display the number of seconds
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Timer Interrupt.c,41 :: 		}
L_main2:
;Timer Interrupt.c,42 :: 		}
	GOTO       L_main0
;Timer Interrupt.c,44 :: 		}
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

;Timer Interrupt.c,46 :: 		void interrupt() {        // Interrupt handler
;Timer Interrupt.c,47 :: 		if (INTCON.TMR0IF==1) {     // check for timer 0 interrupt flag
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt3
;Timer Interrupt.c,48 :: 		counter++;                // increment 1 every interrupt
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;Timer Interrupt.c,49 :: 		INTCON.TMR0IF=0;          // reset the TMR0IF flag
	BCF        INTCON+0, 2
;Timer Interrupt.c,50 :: 		TMR0=6;                   // store 6 in the TMR0 register
	MOVLW      6
	MOVWF      TMR0+0
;Timer Interrupt.c,51 :: 		}
L_interrupt3:
;Timer Interrupt.c,52 :: 		}
L_end_interrupt:
L__interrupt8:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt
