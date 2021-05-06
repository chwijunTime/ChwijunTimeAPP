import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>{
  var value = 0.0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      value = 1.0;
    });
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Center(
          child: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("이제는 준비할 시간"),
                Image.asset(
                  "images/logo.png",
                  width: 150,
                  height: 150,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
