import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:blechem/utils/Logger.dart';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'devices_controller.dart';

class CreateCsvController extends GetxController {
  final _devicesController = Get.find<DevicesController>();
  List<String> attachments = [];
  var fileName = ''.obs;
  RxBool isSave = false.obs;

  //Generates CSV file from List of List of strings. Also saves it to phones directory. Then attached it to 'attachments' to send with mail

  generateCsv() async {
    attachments.clear();
    String csvData = const ListToCsvConverter().convert(_devicesController.csv);
    late String directory;
    if (Platform.isAndroid) {
      directory = (await getTemporaryDirectory()).path;
    } else if (Platform.isIOS) {
      directory = (await getTemporaryDirectory()).path;
    }
    final path = "$directory/${fileName.value}-${DateTime.now()}.csv";
    Logger.log("File$path");
    final File file = File(path);
    await file.writeAsString(csvData);
    attachments.add(path);
  }

  send() async {
    Logger.log('GOT EMAIL');
    final Email email = Email(
        body: 'You can find your data below',
        subject: 'Sensor Data',
        attachmentPaths: attachments,
        isHTML: true);
    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      Logger.log(error);
    }
  }
// This function Saves the csv file to users downloads directory

  saveAs() async {
    String csvData = const ListToCsvConverter().convert(_devicesController.csv);
    String? path = await FileSaver.instance.saveAs(
      name: fileName.value,
      ext: 'csv',
      mimeType: MimeType.csv,
      bytes: Uint8List.fromList(
        utf8.encode(csvData),
      ),
    );
    Logger.log(path);
  }
}
