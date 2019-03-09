#line 1 "D:/Engineering/Teaching/Second Term/Labs/Interrupt handling with PIC Microcontroller/Example 0 Blinking LED/BlinkingLedExample.c"
void main() {
 TRISB.B0=0;
 PORTB.B0=0;
 while(1){
 PORTB.B0=1;
 delay_ms(1000);
 PORTB.B0=0;
 delay_ms(1000);
 }
}
