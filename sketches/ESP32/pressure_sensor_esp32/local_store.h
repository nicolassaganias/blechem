#include <Preferences.h>

Preferences preferences;

float getOffset() {

  preferences.begin("myApp", false);

  // Retrieve the float value
  float retrievedValue = preferences.getFloat("offset", 0.0); // 0.0 is the default value if "myFloatKey" is not found
  Serial.print("Retrieved Value: ");
  Serial.println(retrievedValue);

  preferences.end();

  return retrievedValue;
}

void putOffset(float offsetValue) {
  preferences.begin("myApp", false);
  preferences.putFloat("offset", offsetValue);
  preferences.end();
}
