#line 1 "D:/Engineering/Teaching/Second Term/Labs/Interrupt handling with PIC Microcontroller/Example 1 External interrupt/External Interrupt.c"
void main() {
 TRISB.B0=1;
 TRISD.B0=0;
 PORTD.B0=0;
 GIE_bit=1;
 INTE_bit=1;
}
void interrupt(void){

 if(INTF_bit==1){
 INTF_bit=0;
 PORTD.B0=~PORTD.B0;
 }
}
