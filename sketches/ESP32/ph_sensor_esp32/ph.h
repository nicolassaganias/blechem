/*
 * You can send commands in the serial monitor to execute the calibration.
 * Serial Commands:
 *   enterph -> enter the calibration mode
 *   calph   -> calibrate with the standard buffer solution, two buffer solutions(4.0 and 7.0) will be automaticlly recognized
 *   exitph  -> save the calibrated parameters and exit from calibration mode
 */

#include "DFRobot_ESP_PH.h"  // Required Library
#include "EEPROM.h"          // Required Library

#define ENTERPH "enterph"

DFRobot_ESP_PH ph;  // pH Object creation

#define PH_PIN pH_SENSOR_PIN

float phvoltage, phValue, phtemperature = 25;

// Function for configure pH Sensor
void configPH() {
  EEPROM.begin(32);  //needed to permit storage of calibration value in eeprom
  ph.begin();
}


// Function for get pH value from sensor
float getPH() {
  static unsigned long timepoint1 = millis();
  if (millis() - timepoint1 > 1000U)  //time interval: 1s
  {
    timepoint1 = millis();
    phvoltage = analogRead(PH_PIN) / ESPADC * ESPVOLTAGE;  // read the voltage
    Serial.print("voltage:");
    Serial.println(phvoltage, 4);

    //temperature = readTemperature();  // read your temperature sensor to execute temperature compensation
    Serial.print("temperature:");
    Serial.print(phtemperature, 1);
    Serial.println("^C");

    phValue = ph.readPH(phvoltage, phtemperature);  // convert voltage to pH with temperature compensation
    Serial.print("pH:");
    Serial.println(phValue, 4);
  }
  ph.calibration(phvoltage, phtemperature);  // calibration process by Serail CMD
  return phValue;
}

