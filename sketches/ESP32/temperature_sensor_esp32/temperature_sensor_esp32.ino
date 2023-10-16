// Define the MAC address of the receiver ESP32 
//uint8_t mainBoardMacAddress[] = { 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF };
#define TEMPERATURE_SENSOR_PIN 13  // Temperature sensor data pin

#include "temperature.h"
#include "ble_server.h"

void setup() {
  Serial.begin(115200);

  configBLE();

  
}

void loop() {
  delay(100);
}
