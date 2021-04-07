import 'package:app_user/model/member_login_dto.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/main_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  RetrofitHelper helper;

  @override
  void initState() {
    super.initState();

    Dio dio = Dio();
    helper = RetrofitHelper(dio);
  }

  postLogin() async {
    var res = await helper.postLogin(MemberLoginDTO(memberEmail: emailController.text, memberPassword: passWordController.text).toJson());
    if (res.success) {
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    } else {
      switch (res.msg) {
        case "오잉" : {
          print(res.msg);
        }
      }
    }
    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: PreferredSize(
        child: AppBar(
            backgroundColor: Colors.white,
        ),
          preferredSize: Size.fromHeight(0)
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: Image.asset(
                      "images/top.png",
                      fit: BoxFit.fill,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 54, left: 38),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "로그인",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 48),
                      ),
                      Text(
                        "GSM의 다양한\n취업정보를 확인해요.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 34.0, left: 34),
                    child: buildTextField("email", emailController),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 34, left: 34),
                    child: buildTextField("password", passWordController),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: makeGradientBtn(
                        msg: "Login",
                        onPressed: () {
                          print("로그인");
                          postLogin();
                        },
                        mode: 3),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: GestureDetector(
                        onTap: () {
                          print("눌림");
                          Navigator.pushNamed(context, "/join");
                        },
                        child: Text(
                          "아직 계정이 없으신가요?",
                          style: TextStyle(color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                        )),
                  ),
                  SizedBox(height: 5,),
                  Center(
                    child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "계정이 기억나지 않으시나요?",
                          style: TextStyle(color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Image.asset(
                  "images/bottom.png",
                  fit: BoxFit.fill,
                ))
          ],
        ),
      ),
    );
  }
}
