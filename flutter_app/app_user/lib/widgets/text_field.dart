import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildTextField(String hint, TextEditingController controller,
    {TextInputType type = TextInputType.text,
    bool password = false,
    bool autoFocus = true,
    int maxLine = 1,
    int maxLength = 1,
    bool deco = true,
    bool disable = false,
    Icon prefixIcon,
    String suffixText,
    Function textInput,
    bool multiLine = false,
    bool isCounterText = false}) {
  return TextField(
    controller: controller,
    keyboardType: type,
    obscureText: password,
    textInputAction:
        textInput != null ? TextInputAction.done : multiLine ? TextInputAction.newline : TextInputAction.next,
    onSubmitted: textInput,
    autofocus: autoFocus,
    maxLines: maxLine,
    maxLength: maxLength <= 1 ? null : maxLength,
    enabled: !disable,
    style: TextStyle(fontFamily: password ? "StdFont" : "Nixgon", fontWeight: password ? FontWeight.w100 : FontWeight.w800),
    decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey, fontWeight: password ? FontWeight.w100 : FontWeight.w800),
        focusedBorder: deco
            ? OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent))
            : null,
        enabledBorder: deco
            ? OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))
            : null,
        prefixIcon: prefixIcon != null ? prefixIcon : null,
        suffixText: suffixText,
    counterText: isCounterText ? "" : null),
  );
}
