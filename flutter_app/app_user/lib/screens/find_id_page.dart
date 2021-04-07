import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/find_id_dialog.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class FindIdPage extends StatefulWidget {
  final scafforldkey = GlobalKey<ScaffoldState>();

  @override
  _FindIdPageState createState() => _FindIdPageState();
}

class _FindIdPageState extends State<FindIdPage> {
  var phoneC = TextEditingController();

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
                        "아이디 찾기",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 48),
                      ),
                      Text(
                        "핸드폰 번호를 입력해주세요.",
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
                  child:
                      buildTextField("Phone Number", phoneC, autoFocus: false),
                ),
                SizedBox(
                  height: 24,
                ),
                makeGradientBtn(
                    msg: "아이디 찾기",
                    onPressed: () {
                      onFindId();
                    },
                    mode: 3),
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

  onFindId() {
    if (phoneC.text.isEmpty) {
      widget.scafforldkey.currentState.showSnackBar(SnackBar(
        content: Text("핸드폰 번호를 입력해주세요."),
        duration: Duration(milliseconds: 1500),
      ));
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) =>
              FindIdDialog(name: "예원문", email: "jjol@naver.com"));
    }
  }
}
