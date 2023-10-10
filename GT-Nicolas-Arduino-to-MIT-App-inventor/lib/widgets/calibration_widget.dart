import 'package:flutter/material.dart';
//This widget is used in settings page
// to initiate the calibration by tapping the send button
class CalibrationWidget extends StatelessWidget {
  const CalibrationWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.size,
    required this.txtField,
  });
  final VoidCallback onTap;
  final String title;
  final double? size;
  final Widget? txtField;

  @override
  Widget build(BuildContext context) {
    final disp = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: disp.width / 10,
        ),
        Container(
          height: 40,
          width: 170,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6,
                )
              ]),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: size! * .8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        txtField!,
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: onTap,
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
            child: const Text(
              'Send',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
