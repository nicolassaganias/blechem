#define PAIR "pair"
#define OD "od"
#define ENTEREC "enterec"
#define CALEC "calec"
#define EXITEC "exitec"


// Function for get data from BLE
String getBleData() {
  String msg = "";
  if (Serial.available() > 0) {
      msg = Serial.readString();  // Receive response from Bluno
    }
  msg.trim();
  
  return msg;
}