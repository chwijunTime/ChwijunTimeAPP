import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Image.asset(
                      "images/top.png",
                      fit: BoxFit.fitWidth,
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "로그인",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      ),
                      Text(
                        "취준타임과 취업준비해요.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: buildTextField("email", emailController),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: buildTextField("password", passWordController),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  makeGradientBtn(
                      msg: "Login",
                      onPressed: () {
                        print("로그인");
                      },
                      mode: 3),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Image.asset(
                  "images/bottom_2.png",
                  fit: BoxFit.fitWidth,
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
