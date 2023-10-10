import 'dart:io';

import 'package:blechem/pages/home_page.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'pages/bluetooth_off.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //Takes all the permission according to android version
  if (Platform.isAndroid && androidInfo.version.sdkInt <= 30) {
    [
      Permission.storage,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan
    ].request().then((status) {
      runApp(const FlutterBlueApp());
    });
  } else if (Platform.isAndroid && androidInfo.version.sdkInt >= 31) {
    [
      Permission.storage,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.location
    ].request().then((status) {
      runApp(const FlutterBlueApp());
    });
  } else if (Platform.isIOS) {
    [
      Permission.storage,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
    ].request().then((status) {
      runApp(const FlutterBlueApp());
    });
  }
}

/// This class is the root of our app.According to Bluetooth state the class will call either Homepage or BluetoothOffScreen

class FlutterBlueApp extends StatelessWidget {
  const FlutterBlueApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.lightBlue,
      home: StreamBuilder<BluetoothAdapterState>(
        stream: FlutterBluePlus.adapterState,
        initialData: BluetoothAdapterState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.requireData;
          if (state == BluetoothAdapterState.on) {
            return const HomePage();
          }
          return BluetoothOffScreen(state: state);
        },
      ),
    );
  }
}
