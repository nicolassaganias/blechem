#include "weight.h"
#include "ble_server.h"

// #include <SoftwareSerial.h>

// #define txPin 3 // TX pin of HC-06
// #define rxPin 4 // RX pin of HC-06



// SoftwareSerial Serial2(txPin, rxPin); //Rx,Tx

void setup() {
  Serial.begin(9600);   // Initialize the Bluno BLE Serial
  Serial2.begin(9600);  // Initialize the HC-06 BT Serial
  configBLE();
}


void loop() {
  // Capture the HC-06 BT Serial data
  delay(100);
}

