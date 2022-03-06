import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  // final TextEditingController controller;
  final String hintText;
  // final String labelText;
  Icon iconType;
   TextEditingController controller;

  MyTextFormField({
    // required this.controller,
    required this.hintText,
    // required this.labelText,
    required this.iconType,
    required this.controller,

  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: TextFormField(
        // controller: controller,
        decoration: InputDecoration(
          focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
          enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          border: UnderlineInputBorder(),
          hintText: hintText,
          // labelText: labelText,
          prefixIcon: iconType,
          labelStyle: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}