#include <avr/interrupt.h>

int motorPins[] = {8, 9, 10, 11};
int directionPin = 0;
int count = 0;
int count2 = 0;
int delayTime = 500;
int val = 0;

void setup() {
  for (count = 0; count < 4; count++) {
    pinMode(motorPins[count], OUTPUT);
  }
  
  pinMode(directionPin, INPUT);
  
  PCMSK |= (1<<PIND2);             // Set Pin 6 (PD2) as the pin to use for this example
  MCUCR = (1<<ISC01) | (1<<ISC00); // interrupt on INT0 pin falling edge (sensor triggered) 
  GIMSK  |= (1<<INT0);             // turn on interrupts!
}

void moveForward() {
  if ((count2 == 0) || (count2 == 1)) {
    count2 = 16;
  }
  count2>>=1;
  for (count = 3; count >= 0; count--) {
    digitalWrite(motorPins[count], count2>>count&0x01);
  }
}

void moveBackward() {
  if ((count2 == 0) || (count2 == 1)) {
    count2 = 16;
  }
  count2>>=1;
  for (count = 3; count >= 0; count--) {
    digitalWrite(motorPins[3 - count], count2>>count&0x01);
  }
}

void loop() {

}


SIGNAL (SIG_INT0) {
  digitalRead(directionPin) ? moveForward() : moveBackward();
}

