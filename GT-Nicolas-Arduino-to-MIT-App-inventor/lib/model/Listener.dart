import 'dart:async';
import 'dart:convert' show utf8;

import 'package:blechem/controllers/devices_controller.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../utils/Logger.dart';

class Listener {
  BluetoothCharacteristic characteristic;
  DevicesController deviceController;
  late StreamSubscription<List<int>> subscription;

  Listener(this.characteristic, this.deviceController) {
    subscription = characteristic.lastValueStream.listen((event) {
      var res = utf8.decode(event);
      Logger.log('response $res');
      if (res.contains('pair')) {
        if (res.startsWith('t:')) {
          deviceController.initiateTemperatureRead(characteristic);
        } else if (res.startsWith('ph:')) {
          deviceController.initiatePhRead(characteristic);
        } else if (res.startsWith('ec:')) {
          deviceController.initiateECRead(characteristic);
        } else if (res.startsWith('p:')) {
          deviceController.initiatePRead(characteristic);
        } else if (res.startsWith('w:')) {
          deviceController.initiateWRead(characteristic);
        }
        cancel();
      }
    });
  }

  cancel() {
    Logger.log('cancel');
    subscription.cancel();
  }
}
