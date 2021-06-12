import 'package:flutter/material.dart';

Widget makeDropDownBtn(
    {List<String> valueList,
    String selectedValue,
    void Function(String value) onSetState,
    String hint}) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      border: Border.all(color: Colors.grey),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton(
        value: selectedValue,
        hint: Text(
          hint,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        ),
        items: valueList.map(
          (value) {
            return DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            );
          },
        ).toList(),
        onChanged: (value) {
          print("onChanged: ${value}");
          onSetState(value);
        },
        dropdownColor: Colors.white,
      ),
    ),
  );
}
