import 'package:flutter/material.dart';

Widget makeDropDownBtn(
    {List<String> valueList,
    String selectedValue,
    void Function(String value) onSetState}) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.grey[500], offset: Offset(0,2))
      ]
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton(
        value: selectedValue,
        hint: Text(
          "Please select the number!",
          style: TextStyle(color: Colors.blue),
        ),
        items: valueList.map(
          (value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
        onChanged: (value) {
          print("onChanged: ${value}");
          onSetState(value);
        },
      ),
    ),
  );
}
