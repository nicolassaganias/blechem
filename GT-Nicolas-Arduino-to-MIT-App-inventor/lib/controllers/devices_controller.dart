import 'dart:async';
import 'dart:convert' show utf8;

import 'package:blechem/utils/Logger.dart';
import 'package:blechem/widgets/save_export.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import '../model/Listener.dart';

class DevicesController extends GetxController {
  RxList<BluetoothDevice> connectedDevices = <BluetoothDevice>[].obs;
  RxList<ScanResult> scanResults = <ScanResult>[].obs;

  RxList<String> temp = <String>[].obs;
  RxList<String> pH = <String>[].obs;
  RxList<String> eC = <String>[].obs;
  RxList<String> p = <String>[].obs;
  RxList<String> w = <String>[].obs;

  RxList<List<String>> csv = <List<String>>[[]].obs;

  BluetoothCharacteristic? _temperatureCharacteristic;
  BluetoothCharacteristic? _phCharacteristic;
  BluetoothCharacteristic? _ecCharacteristic;
  BluetoothCharacteristic? _atmCharacteristic;
  BluetoothCharacteristic? _wgtCharacteristic;

  StreamSubscription<List<int>>? _temperatureSubscription;
  StreamSubscription<List<int>>? _phSubscription;
  StreamSubscription<List<int>>? _ecSubscription;
  StreamSubscription<List<int>>? _atmSubscription;
  StreamSubscription<List<int>>? _wgtSubscription;

  var temperature = '0.0'.obs;
  var ph = '0.0'.obs;
  var ec = '0.0'.obs;
  var atm = '0.0'.obs;
  var wgt = '0.0'.obs;
  var calph = 'Calibrate'.obs;
  var calec = 'Calibrate'.obs;
  var calp = 'Calibrate'.obs;
  RxBool isStart = false.obs;
  RxBool isCalibrationOn= false.obs;

  late Timer tP;
  late Timer tN;
  late Timer timerAutoRefresh;
  
  @override
  void onInit() {
    super.onInit();

    FlutterBluePlus.connectedSystemDevices.then((value) {
      for (var device in value) {
        detectDeviceAndConnect(device);
      }
    });

    Stream.periodic(const Duration(seconds: 2))
        .asyncMap((_) => FlutterBluePlus.connectedSystemDevices)
        .listen((event) {
      connectedDevices.value = event;
    });

    FlutterBluePlus.scanResults.listen((event) {
      scanResults.value = event;
    });
    timerAutoRefresh=Timer.periodic(const Duration(seconds: 1), (timer) async {
      if(!isCalibrationOn.value){
      await sendCommand('od', 't');
      await sendCommand('od', 'ph');
      await sendCommand('od', 'ec');
      await sendCommand('od', 'p');
      await sendCommand('od', 'w');
     }
  }
  );
  }

  // Scan result is passed to this function after checking the read and write capability of the result.
  // The characteristics is then passed to Listener model class
  detectDeviceAndConnect(dynamic result) async {
    Logger.log('calling detectDeviceAndConnect');
    var characteristicsUUIDs = <BluetoothCharacteristic>[];

    if (result is ScanResult) {
      result.device.connect().then((value) async {
        Logger.log('device connected from scan result');
        var services = await result.device.discoverServices();
        for (var x in services) {
          for (var y in x.characteristics) {
            characteristicsUUIDs.add(y);
            Logger.log(y.uuid.toString());
          }
        }
        for (var x in characteristicsUUIDs) {
          if (!x.properties.write) {
            Logger.log('skipped ${x.uuid.toString()}');
            continue;
          }
          try {
            Logger.log('writeable ${x.uuid.toString()}');
            x.setNotifyValue(true);
            Listener(x, this);
            await x.write(utf8.encode('pair'));
            updateScanResult(result);
          } catch (e) {
            Logger.log('failed ${x.uuid.toString()}');
          }
        }
      });
    } else {
      Logger.log('Using already connected device');
      var services = await result.discoverServices();
      for (var x in services) {
        for (var y in x.characteristics) {
          characteristicsUUIDs.add(y);
          Logger.log(y.uuid.toString());
        }
      }
      for (var x in characteristicsUUIDs) {
        if (!x.properties.write) {
          Logger.log('skipped ${x.uuid.toString()}');
          continue;
        }
        try {
          Logger.log('writeable ${x.uuid.toString()}');
          x.setNotifyValue(true);
          Listener(x, this);
          await x.write(utf8.encode('pair'));
        } catch (e) {
          Logger.log('failed ${x.uuid.toString()}');
        }
      }
    }
  }

  deviceDisconnect(BluetoothDevice device) async {
    Logger.log('Disconnecting');
    await device.disconnect();
    Logger.log('Disconnected');
  }

  // The initiate" " functions are responsible for listening to the data that are sended by the devices

  initiateTemperatureRead(BluetoothCharacteristic characteristic) async {
    _temperatureCharacteristic = characteristic;
    _temperatureCharacteristic!.setNotifyValue(true);
    if (_temperatureSubscription != null) _temperatureSubscription!.cancel();
    _temperatureSubscription =
        _temperatureCharacteristic!.lastValueStream.listen((event) {
      if (utf8.decode(event).trim().contains('t:')) {
        temperature.value = utf8.decode(event).split(':')[1];
      }

      Logger.log(utf8.decode(event));
    });
       await sendCommand('od', 't'); 
  }

  initiatePhRead(BluetoothCharacteristic characteristic) async {
    _phCharacteristic = characteristic;
    _phCharacteristic!.setNotifyValue(true);
    if (_phSubscription != null) _phSubscription!.cancel();
    _phSubscription = _phCharacteristic!.lastValueStream.listen((event) {
      if (utf8.decode(event).trim().contains('ph:')) {
        ph.value = utf8.decode(event).split(':')[1];
      } else {
        if (utf8.decode(event) == '\n') {
          calph.value = 'Calibration...';
        } else {
          calph.value += utf8.decode(event).trim();
        }
      }
      Logger.log(utf8.decode(event));
    });
    await sendCommand('od', 'ph');
  }

  initiateECRead(BluetoothCharacteristic characteristic) async {
    _ecCharacteristic = characteristic;
    _ecCharacteristic!.setNotifyValue(true);
    if (_ecSubscription != null) _ecSubscription!.cancel();
    _ecSubscription = _ecCharacteristic!.lastValueStream.listen((event) {
      if (utf8.decode(event).trim().contains('ec:')) {
        ec.value = utf8.decode(event).split(':')[1];
      } else {
        if (utf8.decode(event) == '\n') {
          calec.value = 'Calibration...';
        } else {
          calec.value += utf8.decode(event).trim();
        }
      }
      Logger.log(utf8.decode(event));
    });
    await sendCommand('od', 'ec');
  }

  initiatePRead(BluetoothCharacteristic characteristic) async {
    _atmCharacteristic = characteristic;
    _atmCharacteristic!.setNotifyValue(true);
    if (_atmSubscription != null) _atmSubscription!.cancel();
    _atmSubscription = _atmCharacteristic!.lastValueStream.listen((event) {
      if (utf8.decode(event).trim().contains('p:')) {
        atm.value = utf8.decode(event).split(':')[1];
      } else {
        if (utf8.decode(event) == '\n') {
          calp.value += 'Calibration...';
        } else {
          calp.value += utf8.decode(event);
        
        }
      }
      Logger.log(utf8.decode(event));
    });
    
    await sendCommand('od', 'p');
  }

  initiateWRead(BluetoothCharacteristic characteristic) async {
    _wgtCharacteristic = characteristic;
    _wgtCharacteristic!.setNotifyValue(true);
    if (_wgtSubscription != null) _wgtSubscription!.cancel();
    _wgtSubscription = _wgtCharacteristic!.lastValueStream.listen((event) {
     if (utf8.decode(event).trim().contains('w:')) {
        wgt.value = utf8.decode(event).split(':')[1];
      }

      Logger.log(utf8.decode(event));
    });
    
    await sendCommand('od', 'w');
  }
 //The BLE devices are programmed is such way that it sends data if an 'od' command is send to it.
 // This function is responsible for sending the 'od' command.
  sendCommand(String command, String device) async {
    try {
      switch (device) {
        case 't':
          if (_temperatureCharacteristic == null) {
            Logger.log('aborting write on temperature');
            break;
          }
          Logger.log('writing to t');
          await _temperatureCharacteristic!.write(utf8.encode(command));
          break;

        case 'ph':
          if (_phCharacteristic == null) {
            Logger.log('aborting write on ph');
            break;
          }
          Logger.log('writing to ph');
          await _phCharacteristic!.write(utf8.encode(command));
          break;
        case 'ec':
          if (_ecCharacteristic == null) {
            Logger.log('aborting write on ec');
            break;
          }
          Logger.log('writing to ec');
          await _ecCharacteristic!.write(utf8.encode(command));
          break;
        case 'p':
          if (_atmCharacteristic == null) {
            Logger.log('aborting write on pressure');
            break;
          }
          Logger.log('writing to p');
          await _atmCharacteristic!.write(utf8.encode(command));
          break;
        case 'w':
          if (_wgtCharacteristic == null) {
            Logger.log('aborting write on weight');
            break;
          }
          Logger.log('writing to w');
          await _wgtCharacteristic!.write(utf8.encode(command));
          break;
      }
    } catch (e) {
      Logger.log(e.toString());
      sendCommand(command, device);
    }
  }

  updateScanResult(ScanResult result) {
    scanResults.removeWhere(
        (element) => element.device.remoteId.str == result.device.remoteId.str);
  }
  // This function is responsible for the continuos data update. 
  //This function takes user input from textfield. One is duration and another one is interval.
  //Interval is used to start a periodic timer which calls 'sendCommand()' function. 
  //Duration is used to start a timer which will determine how long this function will persist.
  startContinuous(String duration, String interval) {
    isStart.value = true;
    duration = duration.trim();
    interval = interval.trim();
    if (duration.isEmpty || interval.isEmpty) return;
    csv.clear();
    csv = [
      ['Time-Stamp', 'temp', 'ph', 'ec', 'pressure', 'weight']
    ].obs;

    final durationInMin = int.parse(duration);
    final intervalInSeconds = int.parse(interval);

    tP = Timer.periodic(Duration(seconds: intervalInSeconds), (timer) async {
      csv.add([
        DateTime.now().toString(),
        temperature.value.trim(),
        ph.value.trim(),
        ec.value.trim(),
        atm.value.trim(),
        wgt.value.trim(),
      ]);
      await sendCommand('od', 't');
      await sendCommand('od', 'ph');
      await sendCommand('od', 'ec');
      await sendCommand('od', 'p');
      await sendCommand('od', 'w');
    });

    tN = Timer(Duration(minutes: durationInMin), () async {
      Logger.log('timer');
      Logger.log(csv);
      await stopContinuous();
      tP.cancel();
    });
  }
  // The timer which was created in 'startContinuos()' function calls this function when duration is over.
  // This function cancel the 'startContinuos()' function 
  stopContinuous() async {
    isStart.value = false;
    tP.cancel();
    tN.cancel();
    await sendCommand('stop', 't');
    await sendCommand('stop', 'ph');
    await sendCommand('stop', 'ec');
    await sendCommand('stop', 'p');
    await sendCommand('stop', 'w');
    stopDialog();
  }

  void stopDialog() {
    Get.dialog(const SaveAndExportPopup());
  }
  
  exitCal(){
     calec.value='';
     calph.value='';
     calp.value='';

  }

  BluetoothCharacteristic get temperatureCharacteristic =>
      _temperatureCharacteristic!;
  BluetoothCharacteristic get phCharacteristic => _phCharacteristic!;
  BluetoothCharacteristic get ecCharacteristic => _ecCharacteristic!;
  BluetoothCharacteristic get atmCharacteristic => _atmCharacteristic!;
  BluetoothCharacteristic get wgtCharacteristic => _wgtCharacteristic!;

 
}
