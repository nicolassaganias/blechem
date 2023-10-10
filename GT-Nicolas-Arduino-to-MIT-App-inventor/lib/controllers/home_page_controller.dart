import 'package:app_settings/app_settings.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

import '../pages/data_display_page.dart';
import '../pages/device_list_page.dart';

class HomePageController extends GetxController {
  var pageIndex = 0.obs;
  var isScanning = false.obs;

  final pages = [
    const DeviceListPage(),
    const DataDisplayPage(),
  ];

  @override
  void onInit() {
    super.onInit();
    listenScanState();
  }

  listenScanState() {
    FlutterBluePlus.isScanning.listen((event) {
      isScanning.value = event;
    });
  }

  startScan() async {
    Location location = Location();
    bool isOn = await location.serviceEnabled();
    if (!isOn) {
      AppSettings.openAppSettings(type: AppSettingsType.location);
    }

    FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 5),
    );
  }

  stopScan() {
    FlutterBluePlus.stopScan();
  }
}
