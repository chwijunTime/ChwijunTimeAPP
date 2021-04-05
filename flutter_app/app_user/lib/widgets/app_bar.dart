import 'package:flutter/material.dart';

Widget buildAppBar(String title) {
  return PreferredSize(
      child: AppBar(
        centerTitle: true,
        title: Text(title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700
        ),),
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      preferredSize: Size.fromHeight(50));
}
