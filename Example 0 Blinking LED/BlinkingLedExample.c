void main() {
     TRISB.B0=0;   //  set pin B0 as output
     PORTB.B0=0;   //  initial output of B0 is LOGIC LOW
     INTE_bit=1;
     while(1){
     PORTB.B0=1;   //   output of B0 is Set
     delay_ms(1000);
     PORTB.B0=0;   //   output of B0 is reset
     delay_ms(1000);
     }
}