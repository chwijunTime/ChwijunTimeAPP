import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class MyProfileModify extends StatefulWidget {
  String address;
  String classNumber;
  String number;
  String phone;
  List<String> tagList = [];

  MyProfileModify(
      {@required this.address,
      @required this.classNumber,
      @required this.number,
      @required this.phone,
      @required this.tagList});

  @override
  _MyProfileModifyState createState() => _MyProfileModifyState();
}

class _MyProfileModifyState extends State<MyProfileModify> {
  var addressC = TextEditingController();
  var classC = TextEditingController();
  var numberC = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      addressC.text = widget.address;
      classC.text = widget.classNumber;
      numberC.text = widget.number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "취준타임",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0x832B8AC0)),
                  ),
                  Text(
                    "프로필 수정하기",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              elevation: 5,
              margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
              child: Container(
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TEL. ${widget.phone}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(right: 34, left: 34),
                  child: Column(
                    children: [
                      buildTextField("집주소", addressC),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: buildTextField("반", classC,
                                  type: TextInputType.number)),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 3,
                              child: buildTextField("번호", numberC,
                                  type: TextInputType.number))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 15, left: 15, top: 10),
                        child: Align(
                            alignment: Alignment.center,
                            child: makeTagWidget(
                                tag: widget.tagList,
                                size: Size(360, 27),
                                mode: 1)),
                      ),
                    ],
                  )),
            ),
            Center(
              child: Text(
                "집주소와 반, 번호만 수정이 가능합니다.",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: makeGradientBtn(
                    msg: "프로필 수정 완료",
                    onPressed: _postModifyProfile,
                    mode: 4,
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  _postModifyProfile() {
    if (addressC.text.isEmpty || classC.text.isEmpty || numberC.text.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      Map<String, String> result = {
        "address" : addressC.text, "class": classC.text, "number": numberC.text
      };
      Navigator.pop(context, result);
    }
  }
}
