sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D7_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB0_bit;
 char txt[7];
 int time,counter=0;



void i              nitialize_timer_Interrupt(void){
    TMR0IE_bit=1;       // Enable timer 0 interrupt
    GIE_bit=1;          //Enable Global Interrupt
    T0CS_bit=0;                  // Select f/4 clock for the TMR0
    PSA_bit=0;                 // Prescaler is assigned to the Timer0 module
    PS0_bit=0;                // Set pre-scaler to 32
    PS1_bit=1;                // PS2,PS1,PS0 = 100
    PS2_bit=0;
    TMR0=6;                  //counter starting value
}

void main() {
      Lcd_Init();   // Initiate the LCD
      LCD_Cmd(_LCD_CURSOR_OFF);     // Stop the cursor
      Lcd_Out(1,1,"Elapesed Time:");  // Show elapsed time message
      initialize_timer_Interrupt();   // invoke timer interrupt initialization function
      while(1){
         if(counter==500){  // check if the counter reaches 125
            counter=0;      // start counter from the beginning
            time=time++;    // increase time one second
            IntToStrWithZeros(time, txt);  // convert the number of seconds to string
            Lcd_Out(2,1,txt);              // display the number of seconds
           }
      }

}

void interrupt() {        // Interrupt handler
  if (INTCON.TMR0IF==1) {     // check for timer 0 interrupt flag
    counter++;                // increment 1 every interrupt
    INTCON.TMR0IF=0;          // reset the TMR0IF flag
    TMR0=6;                   // store 6 in the TMR0 register
  }
}