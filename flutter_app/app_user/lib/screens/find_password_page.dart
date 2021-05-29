import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FindPasswordPage extends StatefulWidget {

  @override
  _FindPasswordPageState createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  RetrofitHelper helper;
  var email = TextEditingController();
  var classNumber = TextEditingController();


  @override
  void initState() {
    super.initState();
    initRetrofit();
  }

  @override
  void dispose() {
    email.dispose();
    classNumber.dispose();
    super.dispose();
  }

  initRetrofit() {
    Dio dio = Dio();
    dio.options = BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 10 * 1000,
        receiveTimeout: 10 * 1000,
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        });
    helper = RetrofitHelper(dio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.white,
          ),
          preferredSize: Size.fromHeight(0)),
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
                      "assets/images/top.png",
                      fit: BoxFit.fill,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "비밀번호 바꾸기",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 40),
                      ),
                      Text(
                        "아이디(이메일), 학번을 입력해주세요.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
                child: Center(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 34, left: 34),
                  child: buildTextField("Email", email,
                      autoFocus: false, type: TextInputType.emailAddress),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 34, left: 34),
                  child: buildTextField("학번", classNumber,
                      autoFocus: false,
                      type: TextInputType.number,
                      maxLength: 4,
                  isCounterText: true),
                ),
                SizedBox(
                  height: 24,
                ),
                makeGradientBtn(
                    msg: "메일 보내기",
                    onPressed: () {
                      onFindPassword();
                    },
                    mode: 3),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "입력한 이메일로 비밀번호 변경 url이 전송됩니다. 확인해 주세요.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ))),
            Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: Image.asset(
                      "assets/images/bottom.png",
                      fit: BoxFit.fill,
                    )),
                Positioned(
                  right: 0,
                  bottom: 15,
                  child: Padding(
                    padding: const EdgeInsets.all(34),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(children: [
                            TextSpan(
                                text: "취준타임",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                )),
                            TextSpan(
                                text: "과 함께\n취업준비해요!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  onFindPassword() async {
    if (email.text.isEmpty || classNumber.text.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요.", context);
    } else if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(email.text)) {
      snackBar("올바른 이메일 형식으로 입력해주세요.", context);
    } else {
      try {
        var res = await helper.getCheckFindPw(classNumber.text, email.text);
        if (res.success) {
          var res = await helper.postSendEmail(email.text);
          if (res.success) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => StdDialog(
                msg: "해당 이메일로 메일이 발송되었습니다.",
                size: Size(346, 138),
                icon: Icon(
                  Icons.outgoing_mail,
                  color: Color(0xff4687FF),
                ),
                btnName2: "로그인하기",
                btnCall2: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/login", (route) => false);
                },
              ),
            );
          } else {
            snackBar(res.msg, context);
          }
        } else {
          snackBar(res.msg, context);
        }
      } catch (e) {
        print("err: $e");
      }
    }
  }
}
