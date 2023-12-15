#include "ph.h"
#include "bleServer.h"

String tag = "ph:";  // Tag for ph sensor

void setup() {
  Serial.begin(115200);
  configPH();
  delay(1000);
}

void loop() {
  String revData = getBleData();

  // To identify the appropiate characteristic
  if (revData.indexOf(PAIR) >= 0) {
    Serial.println(tag + PAIR);
  }

  else if (revData.indexOf(ENTERPH) >= 0) {
    voltage = analogRead(PH_PIN) / 1024.0 * 5000;  // read the voltage
    ph.calibration(voltage, temperature, ENTERPH);
  }

  else if (revData.indexOf(CALPH) >= 0) {
    int colonPos = revData.indexOf(":");
    String temparatureString = revData.substring(colonPos + 1);
    temperature = temparatureString.toFloat();
    //Serial.println(temperature);
    voltage = analogRead(PH_PIN) / 1024.0 * 5000;  // read the voltage
    ph.calibration(voltage, temperature, CALPH);
  }

  else if (revData.indexOf(EXITPH) >= 0) {
    voltage = analogRead(PH_PIN) / 1024.0 * 5000;  // read the voltage
    ph.calibration(voltage, temperature, EXITPH);
  }

  // To check the one demand data request or continious data sneding
  else if (revData.indexOf(OD) >= 0) {
    float data = getPH();
    String sendData = tag + (String)data;
    Serial.println(sendData);
  }
}
