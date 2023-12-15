#include "pressure.h"
#include "bleServer.h"

String tag = "p:"; // Tag for pressure

void setup() {
  Serial.begin(115200);
  configPressure();
  delay(1000);
}

void loop() {
  String revData = getBleData();

  // To identify the appropiate characteristic
  if(revData.indexOf(PAIR) >= 0){
    Serial.println(tag+PAIR);
  }

  else if(revData.indexOf(ENTERP) >= 0){
    // Serial.println(">>>Enter Pressure Calibration Mode<<<");
    // Serial.println(">>>Please Disconnect the Pressure Sensor from water pipe and Send calp<<<");
    Serial.println("p:1");
  }

  else if(revData.indexOf(CALP) >= 0){
    calibrate();
    // Serial.println(">>>Pressure Calibration Successful<<<");
    Serial.println("p:2");
  }

  else if(revData.indexOf(EXITP) >= 0){
    // Serial.println(">>>Exit Pressure Calibration Mode<<<");
    Serial.println("p:3");
  }

  // To check the one demand data request or continious data sneding
  else if(revData.indexOf(OD) >= 0){
    float data = getPressure();
    String sendData = tag + (String) data;
    Serial.println(sendData);
  }
}
