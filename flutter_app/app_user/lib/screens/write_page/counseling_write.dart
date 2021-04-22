import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class CounselingWrite extends StatefulWidget {
  @override
  _CounselingWriteState createState() => _CounselingWriteState();
}

class _CounselingWriteState extends State<CounselingWrite> {
  var dateC = TextEditingController();
  var timeC = TextEditingController();
  var placeC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar("취준타임", context),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(33),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "상담이 가능한 날짜와 시간, 장소를 입력해주세요!",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff4F9ECB)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  buildTextField("날짜", dateC),
                  SizedBox(
                    height: 10,
                  ),
                  buildTextField("시간", timeC),
                  SizedBox(
                    height: 10,
                  ),
                  buildTextField("장소", placeC),
                  SizedBox(
                    height: 30,
                  ),
                  makeGradientBtn(
                      msg: "등록하기",
                      onPressed: _onCounselingWrite,
                      mode: 4,
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
        ));
  }

  _onCounselingWrite() {
    if (dateC.text.isEmpty || timeC.text.isEmpty || placeC.text.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      Navigator.pop(context);
    }
  }
}
