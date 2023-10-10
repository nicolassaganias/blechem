import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/Logger.dart';
import '../widgets/calibration_widget.dart';
import '../controllers/devices_controller.dart';
import '../widgets/dialog_widget.dart';

class SettingsPage extends StatelessWidget {
  final _controller = Get.find<DevicesController>();
  final DevicesController controller = DevicesController();
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final disp = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting Page'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: disp.height / 10,
            ),
            CalibrationWidget(
              title: 'EC Calibration',
              size: 20,
              txtField: const SizedBox(
                width: 70,
                height: 30,
              ),
              onTap: () {
                _controller.isCalibrationOn.value=true;
                Get.dialog(
                   AlertDialogPopUp(
                        calTitle: 'EC Calibration',
                        onTap: () {
                            _controller.sendCommand('enterec', 'ec');                        
                        },
                        onTapcal: () {
                          _controller.sendCommand('calec', 'ec');
                        },
                        onTapex: () {
                          _controller.sendCommand('exitec', 'ec');                        
                          _controller.isCalibrationOn.value=false;
                        },
                        buttonName: 'enterec',
                        buttonNamecal: 'calec',
                        buttonNameex: 'exitec',
                        message: 'ec',
                        
                        ),
                  
                );
                Logger.log('send');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CalibrationWidget(
                title: 'pH Calibration',
                size: 20,
                txtField: const SizedBox(
                  width: 70,
                  height: 30,
                ),
                onTap: () {
                  _controller.isCalibrationOn.value=true;
                  Get.dialog(
                    AlertDialogPopUp(
                          calTitle: 'pH Calibration',
                          onTap: () {
                            _controller.sendCommand('enterph', 'ph');
                          },
                          onTapcal: () {
                            _controller.sendCommand('calph', 'ph');
                          },
                          onTapex: () {
                            _controller.sendCommand('exitph', 'ph');                         
                            _controller.isCalibrationOn.value=false;
                          },
                          buttonName: 'enterph',
                          buttonNamecal: 'calph',
                          buttonNameex: 'exitph',
                          message:'ph',
                          ),            
                  );
                }),
            const SizedBox(
              height: 10,
            ),
            CalibrationWidget(
              title: 'Pressure Calibration',
              size: 20,
              txtField: const SizedBox(
                width: 70,
                height: 30,
              ),
              onTap: () {
                _controller.isCalibrationOn.value=true;
                Get.dialog(
                   AlertDialogPopUp(
                        calTitle: 'Pressure Calibration',
                        onTap: () {
                          _controller.sendCommand('enterp', 'p');
                        },
                        onTapcal: () {
                          _controller.sendCommand('calp', 'p');
                        },
                        onTapex: () {
                          _controller.sendCommand('exitp', 'p');                  
                          _controller.isCalibrationOn.value=false;
                        },
                        buttonName: 'enterp',
                        buttonNamecal: 'calp',
                        buttonNameex: 'exitp',
                        message:'p',
                        ),                 
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
