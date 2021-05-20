import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class FindPasswordPage extends StatefulWidget {
  final scafforldkey = GlobalKey<ScaffoldState>();

  @override
  _FindPasswordPageState createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  var email = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scafforldkey,
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
                        "비밀번호 바꾸기",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 48),
                      ),
                      Text(
                        "아이디(이메일)을 입력해주세요.",
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
                  height: 24,
                ),
                makeGradientBtn(
                    msg: "메일 보내기",
                    onPressed: () {
                      onFindPassword();
                    },
                    mode: 3),
                SizedBox(
                  height: 10,
                ),
                Text("입력한 이메일로 비밀번호 변경 url이 전송됩니다. 확인해 주세요.",
                style: TextStyle(fontSize: 12, color: Colors.grey,),),
              ],
            ))),
            Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: Image.asset(
                      "images/bottom.png",
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

  onFindPassword() {
    if (email.text.isEmpty) {
      widget.scafforldkey.currentState.showSnackBar(SnackBar(
        content: Text("이메일을 입력해주세요."),
        duration: Duration(milliseconds: 1500),
      ));
    } else if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(email.text)) {
      widget.scafforldkey.currentState.showSnackBar(SnackBar(
        content: Text("올바른 이메일 형식으로 입력해주세요."),
        duration: Duration(milliseconds: 1500),
      ));
    } else {
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
    }
  }
}
