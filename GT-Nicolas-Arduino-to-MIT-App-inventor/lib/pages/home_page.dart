import 'package:blechem/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/csv_controller.dart';
import '../controllers/devices_controller.dart';
//This the homepage for our app.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Get.put(HomePageController());

  @override
  void initState() {
    Get.put(DevicesController());
    Get.put(CreateCsvController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _controller.pages[_controller.pageIndex.value]),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                if (_controller.pageIndex.value != 0) {
                  _controller.pageIndex.value = 0;
                } else {
                  if (!_controller.isScanning.value) {
                    _controller.startScan();
                  } else {
                    _controller.stopScan();
                  }
                }
              },
              icon: Obx(
                () => _controller.isScanning.value
                    ? const Icon(
                        Icons.stop,
                        color: Colors.red,
                        size: 35,
                      )
                    : const Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                        size: 35,
                      ),
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                _controller.pageIndex.value = 1;
              },
              icon: const Icon(
                Icons.connected_tv_rounded,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
