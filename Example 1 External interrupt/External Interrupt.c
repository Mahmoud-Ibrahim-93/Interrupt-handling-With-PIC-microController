void main() {
  TRISB.B0=1;   //  set pin B0 as input
  TRISD.B0=0;   //  set pin D0 as output
  PORTD.B0=0;   //  initial output of D0 is LOGIC LOW
  GIE_bit=1;    // This bit Enables Global Interrupts
  INTE_bit=1;   // This bit enables the external interrupt
}
void interrupt(void){

   if(INTF_bit==1){
    INTF_bit=0;   // To stop recursive interrupt execution
    PORTD.B0=~PORTD.B0;  // Toggle execution
  }
}