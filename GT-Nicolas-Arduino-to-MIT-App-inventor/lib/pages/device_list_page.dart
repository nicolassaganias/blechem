import 'package:blechem/utils/Logger.dart';
import 'package:blechem/widgets/connected_device_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../controllers/devices_controller.dart';
import '../widgets/scan_result_tile.dart';
//This page shows the scan result and connected devices on two section
class DeviceListPage extends StatefulWidget {
  const DeviceListPage({super.key});

  @override
  State<DeviceListPage> createState() => _DeviceListPageState();
}

class _DeviceListPageState extends State<DeviceListPage> {
  final _controller = Get.find<DevicesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices'),
        centerTitle: true,
        backgroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),
          Obx(
            () => Column(
              children: [
                for (var device in _controller.connectedDevices)
                  ConnectedDeviceTile(device: device),
              ],
            ),
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _controller.scanResults.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  ScanResult result = _controller.scanResults[index];
                  return ScanResultTile(
                    result: result,
                    onTap: () {
                      Logger.log('Connect clicked');
                      _controller.detectDeviceAndConnect(result);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
