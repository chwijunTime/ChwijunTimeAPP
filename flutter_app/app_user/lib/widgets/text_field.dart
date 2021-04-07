import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildTextField(String hint, TextEditingController controller,
    {TextInputType type=TextInputType.text, bool password = false, bool autoFocus = true}) {
  return TextField(
    controller: controller,
    keyboardType: type,
    obscureText: password,
    textInputAction: TextInputAction.next,
    autofocus: autoFocus,
    decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
  );
}
