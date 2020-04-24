#line 1 "D:/Engineering/Teaching/Second Term/Labs/Interrupt handling with PIC Microcontroller/Example 2 Timer Interrupt/Timer Interrupt.c"
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



void initialize_timer_Interrupt(void){
 TMR0IE_bit=1;
 GIE_bit=1;
 T0CS_bit=0;
 PSA_bit=0;
 PS0_bit=0;
 PS1_bit=0;
 PS2_bit=1;
 TMR0=6;
}

void main() {
 Lcd_Init();
 LCD_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"Elapesed Time:");
 initialize_timer_Interrupt();
 while(1){
 if(counter==125){
 counter=0;
 time=time++;
 IntToStrWithZeros(time, txt);
 Lcd_Out(2,1,txt);
 }
 }

}

void interrupt() {
 if (INTCON.TMR0IF==1) {
 counter++;
 INTCON.TMR0IF=0;
 TMR0=6;
 }
}
