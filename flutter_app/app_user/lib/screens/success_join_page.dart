import 'package:app_user/widgets/button.dart';
import 'package:flutter/material.dart';

class SuccessJoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff4FB8F3),
                    Color(0xff9342FA),
                    Color(0xff2400FF)
                  ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("취준타임과 함께하는 취준",style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white
              ),)),
              SizedBox(height: 14,),
              makeBtn(msg: "로그인하러 가기", onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
              }, mode: 1, color: Colors.white, textColor: Colors.black, shadow: false)
            ],
          ),
        ),
      ),
    );
  }
}
