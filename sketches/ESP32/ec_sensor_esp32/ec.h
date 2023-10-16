/*
 * You can send commands in the serial monitor to execute the calibration.
 * Serial Commands:
 *   enterec -> enter the calibration mode
 *   calec   -> calibrate with the standard buffer solution, two buffer solutions(1413us/cm and 12.88ms/cm) will be automaticlly recognized
 *   exitec  -> save the calibrated parameters and exit from calibration mode
 */

#include "Arduino.h"  // Required Library
//#include "Adafruit_ADS1015.h" // Required Library when use external ADC
#include "DFRobot_ESP_EC.h"  // Required Library
#include "EEPROM.h"          // Required Library

#define EC_PIN EC_SENSOR_PIN  // Define the EC Sensor output pin

DFRobot_ESP_EC ec;  // EC object creation
//Adafruit_ADS1115 ads;  // Required when use external ADC

float voltage, ecValue, temperature = 25;


// Function for configuring EC Sensor
void configEC() {
  EEPROM.begin(32);  //needed EEPROM.begin to store calibration k in eeprom
  ec.begin();        //by default lib store calibration k since 10 change it by set ec.begin(30); to start from 30
                     //ads.setGain(GAIN_ONE);  // Required when use external ADC
                     //ads.begin();  // Required when use external ADC
}


// Function for getting EC value from sensor
float getEC() {
  static unsigned long timepoint = millis();
  if (millis() - timepoint > 1000U)  //time interval: 1s
  {

    timepoint = millis();
    //voltage = ads.readADC_SingleEnded(0) / 10;
    voltage = analogRead(EC_PIN) / ESPADC * ESPVOLTAGE;  // read the voltage
    Serial.print("voltage:");
    Serial.println(voltage, 4);

    //temperature = readTemperature();  // read your temperature sensor to execute temperature compensation
    Serial.print("temperature:");
    Serial.print(temperature, 1);
    Serial.println("^C");

    ecValue = ec.readEC(voltage, temperature);  // convert voltage to EC with temperature compensation
    Serial.print("EC:");
    Serial.print(ecValue, 4);
    Serial.println("ms/cm");
  }
  //ec.calibration(voltage, temperature);  // calibration process by Serail CMD
  return ecValue;
}


