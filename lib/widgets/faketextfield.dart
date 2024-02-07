import 'package:flutter/material.dart';
import '../constant/constant.dart';

class FakeTextField extends StatelessWidget {
   FakeTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String labelText;
   bool  obscureText=false;
   Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      obscureText:obscureText,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          border: const OutlineInputBorder(
              borderSide:  BorderSide(color: Colors.teal)),
          hintText: hintText,
          labelText:labelText,
          suffixIcon:suffixIcon,
          suffixStyle: const TextStyle(color: themeColorDart)),
    );
  }
}
