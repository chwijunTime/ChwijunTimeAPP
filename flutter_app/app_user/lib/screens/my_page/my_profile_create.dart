import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class MyProfileCreate extends StatefulWidget {
  @override
  _MyProfileCreateState createState() => _MyProfileCreateState();
}

class _MyProfileCreateState extends State<MyProfileCreate> {
  var phoneC = TextEditingController();
  List<String> tagList = [];

  @override
  void initState() {
    super.initState();
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
                    "프로필 생성하기",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(right: 34, left: 34),
                  child: Column(
                    children: [
                      buildTextField("전화번호", phoneC, type: TextInputType.phone),
                      SizedBox(
                        height: 10,
                      ),
                      LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchPage()));
                              setState(() {
                                if (result != null) {
                                  tagList = result;
                                }
                              });
                              print("tagList: $tagList");
                            },
                            child: Container(
                              width: constraints.maxWidth,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 16, bottom: 16),
                                child: Text(
                                  "태그 선택하러 가기",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 15, left: 15, top: 10),
                        child: Align(
                            alignment: Alignment.center,
                            child: makeTagWidget(
                                tag: tagList, size: Size(360, 27), mode: 1)),
                      ),
                    ],
                  )),
            ),
            Center(
              child: Text(
                "전화번호와 태그는 프로필 생성후 수정이 불가능합니다.",
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
                    msg: "프로필 생성 완료",
                    onPressed: _postCreateProfile,
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

  _postCreateProfile() {
    if (phoneC.text.isEmpty ||
        tagList.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      Navigator.pop(context, true);
    }
  }
}
