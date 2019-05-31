#include <Time.h>
//#define DEBUG
//#define DEBUG_BUTTON
time_t t;
int oldduration = 0;

volatile int pwm_value = 0;
unsigned long duration = 0;
int pin = 7;//pulse wave input
const int buttonPin1 = 8;
const int buttonPin2 = 9;
float multiplier = 0.0;
int buttonState1 = 0;
int buttonState2 = 0;
int finalstate = 0;
int curState1 = -1;
int curState2 = -1;
bool held1, held2 = false;
float result = 0;
// dedda
int potpin = 0;
int val;
unsigned char inByte;
unsigned char count;
unsigned char GATE;
unsigned char frequency;
unsigned char STATUS;
unsigned char STATE;
unsigned char time_delay;
unsigned char F;
unsigned int TIMER_1_DELAY, TIMER_1_BUF_DELAY;
unsigned int TIMER_1_IMPULSE, TIMER_1_BUF_IMPULSE;
unsigned int VARIABLE;
void setup() {
  //added
  pinMode(buttonPin1, INPUT);
  pinMode(buttonPin2, INPUT);
  pinMode(pin, INPUT);
  //dedda
  pinMode(2, OUTPUT);  // DIMMER VCC
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);  // DIMMER GND
  digitalWrite(2, HIGH); // DIMMER VCC
  digitalWrite(4, LOW);
  digitalWrite(5, LOW); // DIMMER GND
  TCCR2A=0x00;
  TCCR2B=0x07;   // Prescaller 1024
  TCNT2=0x15;    // Timer2 interrupt 15.04 ms
  OCR2A=0x00;
  OCR2B=0x00;  
  TCCR1A=0x00;
  TCCR1B=0x00;
  TCNT1H=0x00;
  TCNT1L=0x00;
  ICR1H=0x00;
  ICR1L=0x00;
  OCR1AH=0x00;
  OCR1AL=0x00;
  OCR1BH=0x00;
  OCR1BL=0x00;
  TIMSK1=0x01;
  TIMSK2=0x01;
  attachInterrupt(1, zero_crosss_int, RISING);
  Serial.begin(115200); // UART SPEED
  t = time(NULL);
}
void zero_crosss_int()  {
 
 if (STATUS && STATE)
 {
  TIMER_1_DELAY = TIMER_1_BUF_DELAY; 
  
  TCNT1H=TIMER_1_DELAY >> 8;
  TCNT1L=TIMER_1_DELAY & 0xff;
  
  TCCR1B=0x02;
//  Serial.println("Zero cross!");
 }
 
 frequency=TCNT2;
 
 TCNT2=0x00; 
 
 if (frequency>147 && frequency<163) {
  F=100; 
  STATUS=1;
  #ifdef DEBUG
  //Serial.println("AC Line detected?");
  #endif
  }  
 if (frequency>122 && frequency<137) {
  F=83;  
  STATUS=1;
  #ifdef DEBUG
  //Serial.println("AC Line detected?");
  #endif
 }
  
}
ISR(TIMER1_OVF_vect) {
 TIMER_1_IMPULSE = TIMER_1_BUF_IMPULSE; 
 TCNT1H=TIMER_1_IMPULSE >> 8;
 TCNT1L=TIMER_1_IMPULSE & 0xff;
 digitalWrite(4, HIGH);
 time_delay++;
  if (time_delay==2)
  {
    digitalWrite(4, LOW);
    time_delay=0;
    TCCR1B=0x00;    
  }
}
ISR(TIMER2_OVF_vect) {
 TCNT0=0x15;  // every 15.04 ms
 
 digitalWrite(4, LOW);  
 
 STATUS=0;
 
 TCCR1B=0x00;
 
 count++;
 
 if(count==133) 
  { 
    count=0;
    Serial.println("AC LINE IS NOT DETECTED. PLEASE CHECK WIRING. ");
  }
      
}

int medianValue(void) {
  int a, b, c, middle;
  a = pulseIn(pin, HIGH);
  delayMicroseconds(100);
  b = pulseIn(pin, HIGH);
  delayMicroseconds(100);
  c = pulseIn(pin, HIGH);
  if ((a <= b) && (a <= c)) {
    middle = (b <= c) ? b : c;
  } else if ((b <= a) && (b <= c)) {
    middle = (a <= c) ? a : c;
  } else {
    middle = (a <= b) ? a : b;
  }
  return middle;
}


void loop() {
  // added
  buttoncheck();
  int average = 0;
  // sampling 30 times.
  // averaging the last five reads 
  int median = 0;
  for(int i = 0; i < 30; i++) {
    median = medianValue();
    average += median;
  }
  duration = average / 30;
  
  #ifdef DEBUG 
  Serial.print("Average duration result: ");
  Serial.println(duration);
  #endif

//
//  if(duration > 375) {
//    duration = 375;
//  } else if(duration <= 375 && duration > 325) {
//    duration = 350;
//  } else if(duration <= 325 && duration > 275) {
//    duration = 300;
//  } else if(duration <= 275 && duration > 225) {
//    duration = 250;
//  } else if(duration <= 225 && duration > 175) {
//    duration = 200;
//  } else if(duration <= 175 && duration > 125) {
//    duration = 150;
//  } else if(duration <= 125 && duration > 75) {
//    duration = 100;
//  } else {
//    duration = 50;
//  }
//  }
  if(duration > 375) {
    duration = 375;
  }
  else if(duration < 50) {
    duration = 50;
  }
  
  duration = map(duration, 50, 375, 100, 1000);

  result = ((duration) / 1000.0) * multiplier * 255.0;
  if(finalstate == 2){
    result = 255.0;
    #ifdef DEBUG_BUTTON
    Serial.println("I should be printing!!");
    #endif
  }
  else if(finalstate == 3 && result < 70) {
    result = 70;
  }
  #ifdef DEBUG 
  Serial.print("Result of measurement is: ");
  Serial.println(result);
  Serial.print("Duration is: ");
  Serial.println(duration); 
  #endif  
 
  inByte = result;
  if(inByte >= 0) {
    if(STATUS == 1) {
      if(inByte != 0) {
        #ifdef DEBUG
        Serial.print("DIMMER OUTPUT LEVEL - ");
        Serial.println(inByte, DEC);
        #endif
      }
    }
    if(STATUS == 0){
      #ifdef DEBUG
      Serial.println("");
      Serial.println("CAN'T SET OUTPUT LEVEL, BECAUSE AC LINE IS NOT DETECTED");
      Serial.println("");   
      #endif  
    
      }
    }
  
  // dedda
  if (inByte>245) {inByte=245;}
    if (inByte<5) {inByte=5;}
    
    inByte = 256 - inByte;
    if (inByte==251) 
   { 
    STATE=0;  
    TCCR1B=0x00;
    digitalWrite(4, LOW);  
    Serial.println("DIMMER IS POWERED OFF");
   }
    else
    {
     STATE=1;
          
     VARIABLE = ((((inByte*F)/256)*100)-1);  
     VARIABLE = VARIABLE*2;
     
     TIMER_1_BUF_DELAY = 65535 - VARIABLE;  
     TIMER_1_BUF_IMPULSE = 65535 - ((F*100)-(VARIABLE/2));  
    } 
}
// adjusted this. may have to debug first
void buttoncheck() {
  buttonState1 = digitalRead(buttonPin1);
  buttonState2 = digitalRead(buttonPin2);
  // state 1 
  // nothing outputs for the dim switch
  if(buttonState1 == LOW && buttonState2 == LOW) {
    finalstate = 1;
    multiplier = 0;
  }
  // state 2
  // 1st gain value
  // ignores duty cycle
  // full power regardless of duty cycle
  else if(buttonState1 == LOW && buttonState2 == HIGH) {
    finalstate = 4;    
    multiplier = 1;  
    
  }
  // state 3
  // 2nd gain value
  else if(buttonState1 == HIGH && buttonState2 == LOW) {    
    finalstate = 3;    
    multiplier = .75;    
    // min 50 // max 80
  }
  // state 4
  // output is unhindered. 
  else{    
    finalstate = 2;    
    multiplier = 1;    
  }
}
