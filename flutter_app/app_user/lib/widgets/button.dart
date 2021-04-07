import 'package:flutter/material.dart';

double _width, _height, _borderRadius;

Widget makeGradientBtn({@required String msg, @required VoidCallback onPressed, @required int mode, Icon icon}) {
  if (mode == 1) {
    // 작은 네모 버튼
    _width = 175;
    _height = 33;
    _borderRadius = 5;
  } else if (mode == 2) {
    // 작은 동글 버튼
    _width = 190;
    _height = 33;
    _borderRadius = 16;
  } else if (mode ==3) {
    // 짧고 두꺼운 동글 버튼
    _width = 174;
    _height = 50;
    _borderRadius = 26;
  } else if (mode == 4) {
    // 긴 동글 버튼
    _width = 324;
    _height = 33;
    _borderRadius = 16;
  } else {
    // 작은 네모 버튼
    _width = 175;
    _height = 33;
    _borderRadius = 5;
  }

  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff4FB8F3),
              Color(0xff9342FA),
              Color(0xff2400FF)
            ]),
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[500],
              offset: Offset(2,4),
              blurRadius: 5,
              spreadRadius: 0.5
          )]
    ),
    width: _width,
    height: _height,
    child: FlatButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            msg,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
          icon == null ? SizedBox() : icon
        ],
      ),
      onPressed: () {
        onPressed();
      },
    ),
  );
}

Widget makeBtn({@required String msg, @required VoidCallback onPressed, @required int mode, Icon icon, Color color = Colors.grey, Color textColor = Colors.white, bool shadow = true}) {
  if (mode == 1) {
    // 기본 네모 버튼 1
    _width = 175;
    _height = 33;
    _borderRadius = 5;
  } else if (mode == 2){
    // 기본 네모 버튼 2
    _width = 135;
    _height = 33;
    _borderRadius = 5;
  } else {
    // 기본 네모 버튼 1
    _width = 175;
    _height = 33;
    _borderRadius = 5;
  }

  return Container(
    decoration: BoxDecoration(
      color: color,
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        boxShadow: [
          shadow ?
          BoxShadow(
              color: Colors.grey[500],
              offset: Offset(2,4),
              blurRadius: 5,
              spreadRadius: 0.5
          ) : BoxShadow(
            color: Colors.transparent
          ) ]
    ),
    width: _width,
    height: _height,
    child: FlatButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            msg,
            style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
          icon == null ? SizedBox() : icon
        ],
      ),
      onPressed: () {
        onPressed();
      },
    ),
  );
}