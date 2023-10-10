import 'package:blechem/controllers/csv_controller.dart';
import 'package:blechem/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/devices_controller.dart';
import 'custom_text_field_text.dart';
import 'custom_text_field.dart';

class StartNewProjectPopup extends StatefulWidget {
  const StartNewProjectPopup({super.key});

  @override
  State<StartNewProjectPopup> createState() => _StartNewProjectPopupState();
}

class _StartNewProjectPopupState extends State<StartNewProjectPopup> {
  TextEditingController durationCtrl = TextEditingController();
  TextEditingController intervalCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  final _controller = Get.find<DevicesController>();
  final _csvController = Get.find<CreateCsvController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Start New Project')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFieldText(
              margin: const EdgeInsets.only(left: 8, right: 16),
              hintText: 'Project Name',
              controller: nameCtrl,
              isCentered: true,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              margin: const EdgeInsets.only(left: 8, right: 16),
              hintText: 'Duration(min)',
              controller: durationCtrl,
              isCentered: true,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              margin: const EdgeInsets.only(left: 8, right: 16),
              hintText: 'Interval(sec)',
              controller: intervalCtrl,
              isCentered: true,
            ),
            const SizedBox(height: 10),
            CustomButton(
                onTap: () {
                  _controller.startContinuous(
                      durationCtrl.text, intervalCtrl.text);
                  _csvController.fileName.value = nameCtrl.text;
                  Navigator.of(context).pop();
                },
                title: 'Start'),
          ],
        ),
      ),
    );
  }
}
