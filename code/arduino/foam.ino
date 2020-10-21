#include "FastMap.h"
#include <SPI.h>
#include "FastGPIO.h"

#define cbi(sfr, bit) (_SFR_BYTE(sfr) &= ~_BV(bit)) // Macro to clear a bit
#define sbi(sfr, bit) (_SFR_BYTE(sfr) |= _BV(bit)) // Macro to set a bit

#define NUM_COLS 3
#define NUM_ROWS 3

FastMap mapper; // A faster map() function

const int colPins[NUM_COLS] = {2, 3, 4};
const int rowPins[NUM_ROWS] = {A0, A1, A2};

void setup() {
    for (int col=0; col<NUM_COLS; col++) {
        pinMode(colPins[col], INPUT);
    }
    for (int row=0; row<NUM_ROWS; row++) {
        pinMode(rowPins[row], INPUT);
    }
    Serial.begin(9600);
    delay(100);
    Serial.write(0);
    mapper.init(0, 1023, 1, 255);
}

void loop() {
    // Changing rows is slow, so it's the outer loop
    for (int row=0; row<NUM_ROWS; row++) {
        // Changing cols is fast, so it's the inner loop
        for (int col=0; col<NUM_COLS; col++) {
            int pin = colPins[col];
            pinMode(pin, OUTPUT);
            digitalWrite(pin, HIGH);
            Serial.write((byte)mapper.map(
                analogRead(rowPins[row])
            ));
            pinMode(pin, INPUT);
            //if (col != NUM_COLS-1) Serial.print(", ");
      }
  }
  Serial.write(0); // Mark the beginning of the next frame
}