import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final int lines;
  final String? validationMessage;
  final TextEditingController controller;
  String? type;
  String? originalPassword;
  CustomInputField({
    super.key,
    required this.lines,
    required this.controller,
    required this.validationMessage,
    this.type,
    this.originalPassword
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
      textAlign: TextAlign.justify,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal:10),
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
      keyboardType: type == "price" ? TextInputType.number : TextInputType.text,
      maxLines: lines,
      obscureText: type == "password" || type== "confirm_password" ? true : false,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        // debugPrint("This is debug value $value");
        if ((type?.isNotEmpty ?? false)) {
          if (type == "email") {
            return !RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+",
                ).hasMatch(value!)
                ? 'Wrong email form'
                : null;
          } else if (type == "password") {
            return !RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
                ).hasMatch(value!)
                ? 'Write least one upper, lower case, and digit'
                : null;
          } 
          else if (type =="confirm_password" ){
            if (originalPassword != controller.text){
              return "Password does not match";
            }
          }
          else if (type == "price") {
            if (double.tryParse(value) == null) {
              return 'Please enter Number';
            }
          }
        }

        return null;
      },
    );
  }
}
