import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  RetrofitHelper helper;

  var value = 0.0;
  String msg = "";

  @override
  void initState() {
    super.initState();
    initRetrofit();
    _init();
  }

  initRetrofit() {
    Dio dio = Dio(BaseOptions(
        connectTimeout: 5 * 1000,
        receiveTimeout: 5 * 1000,
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        }));
    helper = RetrofitHelper(dio);
  }

  void _init() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      value = 1.0;
      msg = "회원 정보 확인중...";
    });
    var prefs = await SharedPreferences.getInstance();
    var role = prefs.getString("role") ?? User.admin;
    var token = prefs.getString("accessToken");
    var classNumber = prefs.getString("classNumber");
    print("role, main: ${role}");
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      msg = "완료!";
    });
    User.role = role;
    User.classNumber = classNumber;
    await Future.delayed(Duration(milliseconds: 500));
    if (token != null && role != null) {
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    }
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
                  "assets/images/logo.png",
                  width: 150,
                  height: 150,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  msg,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
