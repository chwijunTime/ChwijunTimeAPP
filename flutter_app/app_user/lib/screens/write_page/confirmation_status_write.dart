import 'package:app_user/model/confirmation_status_vo.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drop_down_button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../search_page.dart';

class ConfirmationStatusWrite extends StatefulWidget {
  @override
  _ConfirmationStatusWriteState createState() =>
      _ConfirmationStatusWriteState();
}

class _ConfirmationStatusWriteState extends State<ConfirmationStatusWrite> {
  var titleC = TextEditingController();
  var areaC = TextEditingController();
  var addressC = TextEditingController();
  var siteUrl = TextEditingController();
  var etcC = TextEditingController();
  var grade = "1학년";

  List<String> gradeList = ['1학년', '2학년', '3학년'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임"),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 33, left: 33, top: 24),
              child: buildTextField("업체명", titleC),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 33, left: 33, top: 10),
              child: Row(
                children: [
                  makeDropDownBtn(
                      valueList: gradeList,
                      hint: "학년",
                      selectedValue: grade,
                      onSetState: (value) {
                        setState(() {
                          grade = value;
                        });
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: buildTextField("회사 사이트 주소", siteUrl),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 33, left: 33, top: 10),
              child: buildTextField("지역명", areaC),
            ),
            Padding(
              padding: EdgeInsets.only(right: 33, left: 33, top: 10),
              child: buildTextField(
                "상세 주소",
                addressC,
              ),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              margin: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 25,
              ),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "비고",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      buildTextField("비고를 적어주세요!", etcC,
                          maxLine: 8, maxLength: 150)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding:
                  EdgeInsets.only(right: 33, left: 33, top: 10, bottom: 30),
              child: makeGradientBtn(
                  msg: "등록하기",
                  onPressed: () {
                    onReviewPost();
                  },
                  mode: 4,
                  icon: Icon(
                    Icons.note_add,
                    color: Colors.white,
                  )),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  onReviewPost() {
    if (titleC.text.isEmpty ||
        siteUrl.text.isEmpty ||
        addressC.text.isEmpty ||
        areaC.text.isEmpty ||
        grade.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      int gra = int.parse(grade.substring(0,1));
      var conf = ConfirmationStatusVO(title: titleC.text, grade: gra, area: areaC.text, siteUrl: siteUrl.text, address: addressC.text, etc: etcC.text);
      print(conf.toString());

      Navigator.pop(context);
    }
  }
}
