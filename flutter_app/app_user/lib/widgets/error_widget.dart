import 'package:flutter/material.dart';

Widget buildConnectionError() {
  return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Text(
          "[네트워크 연결 오류]\n교내 와이파이를 이용해주세요.",
          textAlign: TextAlign.center,
        ),
      ));
}