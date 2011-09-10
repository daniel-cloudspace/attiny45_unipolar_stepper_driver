// in reference to the pdf http://www.atmel.com/dyn/resources/prod_documents/doc2586.pdf
//
// Output pins:
//   5, 6, 2, 3
//
// Interrupt pin:
//   7 (INT0)
// 
// Direction (input) pin:
//   1

int motorPins[] = { 1, 0, 4, 3 };
int states[][4] = {
  { HIGH, HIGH, LOW, LOW },
  { LOW, HIGH, HIGH, LOW },
  { LOW, LOW, HIGH, HIGH },
  { HIGH, LOW, LOW, HIGH } 
};
volatile int count = 0;
int delayTime = 20;

int count2; 

void setup() {
  for (count = 0; count < 4; count++) {
    pinMode(motorPins[count], OUTPUT);
  }
  
  attachInterrupt(0, pulseTrain, RISING);
}

void moveForward() {
  if ((count2 == 0) || (count2 == 1)) {
    count2 = 16;
  }
  count2>>=1;
  for (count = 3; count >= 0; count--) {
    digitalWrite(motorPins[count], count2>>count&0x01);
  }
  delay(delayTime);
}

void moveBackward() {
  if ((count2 == 0) || (count2 == 1)) {
    count2 = 16;
  }
  count2>>=1;
  for (count = 3; count >= 0; count--) {
    digitalWrite(motorPins[3 - count], count2>>count&0x01);
  }
  delay(delayTime);
}

void loop() {
  //moveForward();
}

void pulseTrain() {
  digitalWrite(motorPins[0], states[count][0]);
  digitalWrite(motorPins[1], states[count][1]);
  digitalWrite(motorPins[2], states[count][2]);
  digitalWrite(motorPins[3], states[count][3]);
  
  count = (count + (digitalRead(5) ? 3 : 1)) % 4;
}
