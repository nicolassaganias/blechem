import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/devices_controller.dart';

class AlertDialogPopUp extends StatefulWidget {
  const AlertDialogPopUp(
      {super.key,
      required this.calTitle,
      required this.onTap,
      required this.onTapcal,
      required this.onTapex,
      required this.buttonName,
      required this.buttonNamecal,
      required this.buttonNameex,
      required this.message});

  final String calTitle;
  final VoidCallback onTap;
  final VoidCallback onTapcal;
  final VoidCallback onTapex;
  final String buttonName;
  final String buttonNamecal;
  final String buttonNameex;
  final String message;
  @override
  State<AlertDialogPopUp> createState() => _AlertDialogPopUpState();
}

class _AlertDialogPopUpState extends State<AlertDialogPopUp> {
  final _controller = Get.find<DevicesController>();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: Center(
        child: Text(
          widget.calTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
              _controller.exitCal();
            },
            icon: const Icon(Icons.close),
          ),
        )
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                border: Border.all(),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(5.0, 5.0),
                  )
                ],
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Text(
                widget.buttonName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: h / 4.5,
            width: w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(),
            ),
            child: Obx(() {
              var temp = _controller.calp.value;
              if (widget.message == 'ec') {
                temp = _controller.calec.value;
              } else if (widget.message == 'ph') {
                temp = _controller.calph.value;
              }
              return Text(
                 temp,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 10,
              );
            }),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: widget.onTapcal,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(5.0, 5.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Text(
                    widget.buttonNamecal,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: widget.onTapex,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(5.0, 5.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Text(
                    widget.buttonNameex,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
