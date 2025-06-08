import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final bool isNum;
  final int lines;
  final String? validationMessage;
  final TextEditingController controller;
  const CustomInputField({
    super.key,

    required this.isNum,
    required this.lines,
    required this.controller,
    required this.validationMessage,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
      textAlign: TextAlign.justify,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE8E8E8), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
      ),
      controller: controller,
      keyboardType: isNum ? TextInputType.number : TextInputType.text,
      maxLines: lines,
      validator: (value) {
        debugPrint("This is debug value $value");
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        if (isNum) {
          if (double.tryParse(value) == null) {
            return 'Please enter Number';
          }
        }
        return null;
      },
    );
  }
}
