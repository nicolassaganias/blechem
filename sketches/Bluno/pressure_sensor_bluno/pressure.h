#include <EEPROM.h>
#define PRESSURE_SENSOR_PIN A5  // Connect the pressure sensor with Bluno A5 pin

// Choose an EEPROM address to store the data
const int dataAddress = 1;

float OffSet = 0.483;  // Change this Offset voltage from calibration result

float V, P;

// Function for configure pressure sensor
void configPressure() {
  EEPROM.get(dataAddress, OffSet);
}

// Function for calibrate the pressure sensor
void calibrate() {
  OffSet = analogRead(PRESSURE_SENSOR_PIN) * 5.00 / 1024;  //Sensor output voltage
  for (int i = 0; i < 50; i++) {
    V = analogRead(PRESSURE_SENSOR_PIN) * 5.00 / 1024;  //Sensor output voltage
    if (OffSet > V) {
      OffSet = V;
    }
  }
  EEPROM.put(dataAddress, OffSet);
  // Serial.print("Set Offset value: ");
  // Serial.println(OffSet);
  delay(500);
}

// Function for getting pressure from sensor
float getPressure() {
  V = analogRead(PRESSURE_SENSOR_PIN) * 5.00 / 1024;  //Sensor output voltage
  P = (V - OffSet) * 250;                             //Calculate water pressure
  return P;
}
