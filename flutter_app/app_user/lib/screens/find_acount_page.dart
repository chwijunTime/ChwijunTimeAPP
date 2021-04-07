import 'package:app_user/screens/find_id_page.dart';
import 'package:app_user/screens/find_password_page.dart';
import 'package:app_user/widgets/button.dart';
import 'package:flutter/material.dart';

class FindAcountPage extends StatelessWidget {
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
                        "계정 찾기",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 48),
                      ),
                      Text(
                        "아이디 & 비밀번호 찾기",
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    makeGradientBtn(msg: "아이디 찾기", onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FindIdPage()));
                    }, mode: 3, icon: Icon(Icons.lock, color: Colors.white,)),
                    makeGradientBtn(msg: "비밀번호 찾기", onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FindPasswordPage()));
                    }, mode: 3, icon: Icon(Icons.lock, color: Colors.white,)),
                  ],
                ),
              )
            ),
            Stack(
              children: [
                Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
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
}
