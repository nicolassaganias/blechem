#include "ec.h"
#include "bleServer.h"
#include <string.h>

String tag = "ec:"; // Tag for ec sensor


void setup() {
  Serial.begin(115200);
  configEC();
  delay(1000);
}

void loop() {
  
  String revData = getBleData();

  // To identify the appropiate characteristic
  if(revData.indexOf(PAIR) >= 0){
    Serial.println(tag+PAIR);
  }

  // To check the one demand data request or continious data sneding
  else if(revData.indexOf(OD) >= 0){
    float data = getEC();
    String sendData = tag + (String) data;
    Serial.println(sendData);
  }
  
  else if (revData.indexOf(ENTEREC) >= 0) {
    voltage = analogRead(EC_PIN) / 1024.0 * 5000;  // read the voltage
    ec.calibration(voltage, temperature, "ENTEREC");
  }

  else if (revData.indexOf(CALEC) >= 0) {
    int colonPos = revData.indexOf(":");
    String temparatureString = revData.substring(colonPos + 1);
    temperature = temparatureString.toFloat();
    // Serial.println(temperature);
    voltage = analogRead(EC_PIN) / 1024.0 * 5000;  // read the voltage
    ec.calibration(voltage, temperature, "CALEC");
  }

  else if (revData.indexOf(EXITEC) >= 0) {
    voltage = analogRead(EC_PIN) / 1024.0 * 5000;  // read the voltage
    ec.calibration(voltage, temperature, "EXITEC");
  }
}
