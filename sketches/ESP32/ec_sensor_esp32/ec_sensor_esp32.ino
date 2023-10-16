#define EC_SENSOR_PIN 13  

#define ESPADC 4096.0    // the esp Analog Digital Convertion value
#define ESPVOLTAGE 3300  // the esp voltage supply value

#include "ec.h"
#include "ble_server.h"

void setup() {
  Serial.begin(115200);

  configBLE();
  configEC();

}

void loop() {
  delay(100);
}
