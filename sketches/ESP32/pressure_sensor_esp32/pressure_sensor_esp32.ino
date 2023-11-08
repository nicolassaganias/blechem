// Define the MAC address of the receiver ESP32 
//uint8_t mainBoardMacAddress[] = { 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF };
#define PRESSURE_SENSOR_PIN 13    // Output pin of pressure sensor
#include "local_store.h"
#include "pressure.h"
#include "ble_server.h"



void setup() {
  Serial.begin(115200);

  configBLE();

  //OffSet = getOffset(); // for manual Calibration
  Serial.print("Stored Offset value: ");
  Serial.println(OffSet);

}

void loop() {
  delay(100);
}
