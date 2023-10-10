import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/csv_controller.dart';
import '../utils/Logger.dart';

class SaveAndExportPopup extends StatefulWidget {
  const SaveAndExportPopup({super.key});

  @override
  State<SaveAndExportPopup> createState() => _SaveAndExportPopupState();
}

class _SaveAndExportPopupState extends State<SaveAndExportPopup> {
  final _csvController = Get.find<CreateCsvController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Save and Export')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () {
                      _csvController.saveAs();
                      Logger.log('Saving...');
                    },
                  ),
                  const Text(
                    'Save',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      _csvController.generateCsv();
                      Future.delayed(const Duration(seconds: 1), () {
                        _csvController.send();
                      });
                      Logger.log('Exporting...');
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text(
                    'Share',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  _csvController.isSave.value = false;
                  Navigator.of(context).pop(); // Close the popup
                },
              ),
              const Text(
                'close',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
