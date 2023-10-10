import 'package:blechem/controllers/devices_controller.dart';
import 'package:blechem/pages/settings_page.dart';
import 'package:blechem/widgets/custom_button.dart';
import 'package:blechem/widgets/data_display_card.dart';
import 'package:blechem/widgets/start_new_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DataDisplayPage extends StatefulWidget {
  const DataDisplayPage({super.key});

  @override
  State<DataDisplayPage> createState() => _DataDisplayPageState();
}

class _DataDisplayPageState extends State<DataDisplayPage> {
  final _controller = Get.find<DevicesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Display'),
        centerTitle: true,
        backgroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Obx(
                    () => Expanded(
                      child: DataDisplayCard(
                        title: 'Temperature',
                        unit: '(C)',
                        data: _controller.temperature.value.trim(),
                        onTap: () {
                          _controller.sendCommand('od', 't');
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => Expanded(
                      child: DataDisplayCard(
                        title: 'pH',
                        unit: '',
                        data: _controller.ph.value.trim(),
                        onTap: () {
                          _controller.sendCommand('od', 'ph');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Obx(
                    () => Expanded(
                      child: DataDisplayCard(
                        title: 'EC',
                        unit: '(mS/cm)',
                        data: _controller.ec.value.trim(),
                        onTap: () {
                          _controller.sendCommand('od', 'ec');
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => Expanded(
                      child: DataDisplayCard(
                        title: 'Pressure',
                        unit: '(bar)',
                        data: _controller.atm.value.trim(),
                        onTap: () {
                          _controller.sendCommand('od', 'p');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Obx(
                    () => Expanded(
                      child: DataDisplayCard(
                        title: 'Weight',
                        unit: '(g)',
                        data: _controller.wgt.value.trim(),
                        onTap: () {
                          _controller.sendCommand('od', 'w');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => _controller.isStart.value
                  ? CustomButton(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      onTap: () {
                        _controller.stopContinuous();
                      },
                      bgColor: Colors.red,
                      title: 'Stop',
                    )
                  : CustomButton(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      onTap: () {
                        startDialog();
                      },
                      title: 'Start New Project',
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void startDialog() {
    Get.dialog(
      const StartNewProjectPopup(),
    );
  }
}
