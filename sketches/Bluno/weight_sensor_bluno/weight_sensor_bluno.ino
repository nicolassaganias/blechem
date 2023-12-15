#include <SoftwareSerial.h>

#define txPin 3 // TX pin of HC-06
#define rxPin 4 // RX pin of HC-06

String weight, revData;

SoftwareSerial mySerial(txPin, rxPin); //Rx,Tx

void setup() {
Serial.begin(9600); // Initialize the Bluno BLE Serial
mySerial.begin(9600); // Initialize the HC-06 BT Serial
}


void loop() {
// Capture the HC-06 BT Serial data
if (mySerial.available()) {
weight = mySerial.readStringUntil('\n');
int colonPos = weight.indexOf(":");
weight = weight.substring(colonPos+1);
weight.trim();
colonPos = weight.indexOf(" ");
weight = weight.substring(0,colonPos);
}

// Capture the Bluno BLE data
if (Serial.available()) {
revData = Serial.readStringUntil('\n');
}

// Pairing checking
if (revData.indexOf("pair") >= 0) {
revData = "";
Serial.println("w:pair");
}

// Serve the data on demand
else if (revData.indexOf("od") >= 0) {
revData = "";
Serial.println("w:"+weight);
}

}