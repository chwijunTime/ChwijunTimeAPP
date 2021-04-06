import 'package:flutter/material.dart';

Widget buildTextField(String hint, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
  );
}

Widget buildTextFormField(
    String hint, TextEditingController controller, String msg) {
  return TextFormField(
      controller: controller,
      validator: (value) {
        if (value.trim().isEmpty) {
          return msg;
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))));
}
