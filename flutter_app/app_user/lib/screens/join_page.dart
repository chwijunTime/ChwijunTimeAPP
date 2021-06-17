import 'package:app_user/model/member_dto.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  var passwordC = TextEditingController();
  var rePasswordC = TextEditingController();
  var stIDC = TextEditingController();
  var emailC = TextEditingController();

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
                    height: 115,
                    child: Image.asset(
                      "assets/images/top.png",
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    buildTextField("Email", emailC,
                        type: TextInputType.emailAddress),
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
                    buildTextField("Student ID (ex 3210)", stIDC,
                        type: TextInputType.number),
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
                                letterSpacing: -1,
                                fontFamily: "Nixgon")),
                        TextSpan(
                            text: '이용약관',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                letterSpacing: -1,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Nixgon")),
                        TextSpan(
                            text: ' 동의로 간주합니다.',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                letterSpacing: -1,
                                fontFamily: "Nixgon"))
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
                      "assets/images/bottom.png",
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
                                    fontFamily: "Nixgon")),
                            TextSpan(
                                text: "과 함께\n취업성공해요!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    fontFamily: "Nixgon")),
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

  _onJoin() async {
    if (emailC.text.isEmpty ||
        passwordC.text.isEmpty ||
        rePasswordC.text.isEmpty ||
        stIDC.text.isEmpty) {
      snackBar("모든 필드를 필수로 입력해주세요.", context);
    } else if (passwordC.text != rePasswordC.text) {
      snackBar("비멀번호를 다시 확인해주세요", context);
    } else if (stIDC.text.length != 4) {
      snackBar("학번은 숫자 4자리로 입력해주세요.\nex) 3210 (3학년2반10번)", context);
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
