# blechem

This Bluetooth Low Energy (BLE) App is responsible of gathering data values from different arduino-based sensors.
At the moment the app is designed for it to communicate with 5 types of water-sensing sensors:
```
pH Sensor
EC Sensor
Pressure Sensor
Weight Sensor
Temperature Sensor
```
All this sensors can be connected at the same time and after finishing the experiment, be sent in .csv format to any e-mail address or saved in the internal mobile phone/tablet memory.

# App Usage Instructions
When the app is opened you see an empty screen where you can search new device by clicking in the magnifying glass icon.

![Welcome](images/screen-0-small.png)

When you click the magnifying glass all the BLE available devices are shown. In this example we click on "PH" to conect to pH Sensor.

![pH Sensor Connect](images/screen-search-device-small.png)   -->   ![pH Sensor Connected](images/screen-device-conected-small.png)

_maybe device will ask a pin number if it's first time being paired. try 000000 (six times zero) or 1234 in case of weight sensor_

Once device is connected, see the data being received in Data Display:

![Data Display](images/screen-data-display-small.png)

User can just watch the real-time sensor data values or Start a New Project to save the data for a period of time. Also user can adjust the interval in which the app will record the data values and also assign a project name:

![New Project](images/screen-new-project-small.png)

When New Project's duration is over or button "Stop" is pressed, user will have the choice of sharing the data over e-mail or saving into the internal mobile memory:

![Share or Save](images/screen-save-export-small.png)

If Share is selected the app will bring up the default mail app and will compress the .csv file to be sent:

![Share](images/screen-share-small.png)

Once data is shared user will be able to see a table-formated .csv file:

![csv table](images/csv-table.png)
