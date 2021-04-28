import 'package:app_user/model/member_dto.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  var passwordC = TextEditingController();
  var rePasswordC = TextEditingController();
  var phoneC = TextEditingController();
  var stIDC = TextEditingController();
  var nameC = TextEditingController();
  var emailC = TextEditingController();

  bool checkEmail = false;

  RetrofitHelper helper;

  @override
  void initState() {
    super.initState();

    Dio dio = Dio();
    dio.options = BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        });
    helper = RetrofitHelper(dio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    height: 115,
                    child: Image.asset(
                      "images/top.png",
                      fit: BoxFit.fill,
                    )),
                Padding(
                  padding: const EdgeInsets.all(34),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "회원가입",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 30),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 34, left: 34),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    buildTextField("Email", emailC,
                        type: TextInputType.emailAddress, disable: checkEmail),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: makeBtn(
                          msg: checkEmail ? "다른 이메일" : "중복확인", onPressed: checkEmail ? _onReTry : _onEmailCheck, mode: 2),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    buildTextField("Password", passwordC, password: true),
                    SizedBox(
                      height: 20,
                    ),
                    buildTextField("Re Password", rePasswordC, password: true),
                    SizedBox(
                      height: 20,
                    ),
                    buildTextField("Phone Number", phoneC,
                        type: TextInputType.phone),
                    SizedBox(
                      height: 20,
                    ),
                    buildTextField("Student ID (ex 3210)", stIDC,
                        type: TextInputType.number),
                    SizedBox(
                      height: 20,
                    ),
                    buildTextField("Name", nameC),
                    SizedBox(
                      height: 10,
                    ),
                    makeGradientBtn(
                        msg: "SignUp",
                        onPressed: () {
                          _onJoin();
                        },
                        mode: 3),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: '회원가입시 ',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                letterSpacing: -1)),
                        TextSpan(
                            text: '이용약관',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                letterSpacing: -1,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                            text: ' 동의로 간주합니다.',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                letterSpacing: -1))
                      ])),
                    )
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 115,
                    child: Image.asset(
                      "images/bottom.png",
                      fit: BoxFit.fill,
                    )),
                Positioned(
                  right: 0,
                  top: 15,
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
                                text: "과 함께\n취업성공해요!",
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

  _onReTry() {
    setState(() {
      checkEmail = !checkEmail;
    });
  }

  _onEmailCheck() async {
    if (emailC.text == "") {
      snackBar("이메일을 입력해주세요.", context);
    } else if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(emailC.text)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return RichAlertDialog(
              alertTitle: richTitle("입력 에러"),
              alertSubtitle:
                  richSubtitle("이메일 형식으로 입력해주세요. '[    ]@[   ].[   ]' 형식"),
              alertType: RichAlertType.ERROR,
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "확인",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.orange[800],
                )
              ],
            );
          });
    } else {
      var res = await helper.postEmailCheck(emailC.text);
      print("ress: ${res.toJson()}");
      if (res.success) {
        snackBar("사용가능한 이메일 입니다.", context);
        setState(() {
          checkEmail = true;
        });
      } else {
        print("msg: ${res.msg}");
        snackBar("중복된 이메일 입니다.", context);
      }
    }
  }

  _onJoin() async {
    if (emailC.text.isEmpty ||
        passwordC.text.isEmpty ||
        rePasswordC.text.isEmpty ||
        phoneC.text.isEmpty ||
        stIDC.text.isEmpty ||
        nameC.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return RichAlertDialog(
              alertTitle: richTitle("모두 입력해주세요!"),
              alertSubtitle: richSubtitle("모든 필드를 필수로 입력해주세요."),
              alertType: RichAlertType.ERROR,
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "확인",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.orange[800],
                )
              ],
            );
          });
    } else if (!checkEmail) {
      snackBar("이메일 중복확인을 완료해주세요!", context);
    }
    else if (passwordC.text != rePasswordC.text) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return RichAlertDialog(
              alertTitle: richTitle("입력 에러"),
              alertSubtitle:
                  richSubtitle("비밀번호를 다시 확인해주세요.\n비밀번호는 '8~15글자, 특수문자 포함입니다.'로 해야합니다."),
              alertType: RichAlertType.ERROR,
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "확인",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.orange[800],
                )
              ],
            );
          });
    } else if (stIDC.text.length != 4) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return RichAlertDialog(
              alertTitle: richTitle("입력 에러"),
              alertSubtitle:
                  richSubtitle("학번은 숫자 4자리로 입력해주세요.\nex) 3210 (3학년2반10번)"),
              alertType: RichAlertType.ERROR,
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "확인",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.orange[800],
                )
              ],
            );
          });
    } else {
      MemberDTO dto = MemberDTO(
          memberClassNumber: stIDC.text,
          memberEmail: emailC.text,
          memberPassword: passwordC.text);
      var res = await helper.postJoin(dto.toJson());
      if (res.success) {
        Navigator.pushNamedAndRemoveUntil(
            context, "/success_join", (route) => false);
      } else {
        snackBar(res.msg, context);
      }
    }
  }
}
