import 'package:flutter/material.dart';

class CustomTextFieldText extends StatelessWidget {
  const CustomTextFieldText({
    super.key,
    required this.hintText,
    required this.controller,
    this.isCentered = false,
    this.margin,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isCentered;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        textAlign: isCentered ? TextAlign.center : TextAlign.start,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
