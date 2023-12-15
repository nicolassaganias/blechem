/************************************************************
  Calibration: connect the 3 pin wire to the ESP-32 (VCC, GND and Signal)
  without connecting the sensor to the water pipe and run the program
  for once. Mark down the LOWEST voltage value through the serial
  monitor and revise the "OffSet" value to complete the calibration.

  After the calibration the sensor is ready for measuring!
**************************************************************/

float OffSet = 0.412;  // Offset voltage for fermentador //412:12bar 391:30psi

float V, P;

// Function for getting pressure from sensor
float getPressure() {
  //Connect sensor to Analog 0
  V = analogRead(PRESSURE_SENSOR_PIN) * (3.3 / 4095.0);  //Sensor output voltage (original code)
  //V = analogRead(PRESSURE_SENSOR_PIN) * (5 / 4095.0);
  //V = analogRead(PRESSURE_SENSOR_PIN);// * 5.00 / 1024;

  P = ((V - OffSet) * 250) / 100;  // /100 for milibar                            //Calculate water pressure (original code)
  //P = (((V - OffSet) * 400) / 100);  // /100 to convert kPa to bar // *2.6 for correction

  Serial.print("Voltage:");
  Serial.print(V, 3);
  Serial.println("V");

  Serial.print(" Pressure:");
  Serial.print(P, 1);
  Serial.println(" bar");
  Serial.println();

  return P;
}
