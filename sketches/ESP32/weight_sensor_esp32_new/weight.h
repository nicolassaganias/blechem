String weight, revData;

void getWeight(){
  if (Serial2.available()) {
    weight = Serial2.readStringUntil('\n');
    Serial.println(weight);
    int colonPos = weight.indexOf(":");
    weight = weight.substring(colonPos + 1);
    weight.trim();
    colonPos = weight.indexOf(" ");
    weight = weight.substring(0, colonPos);
  }
}