import 'package:app_user/model/user/profile_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class MyProfileModify extends StatefulWidget {
  ProfileVO vo;

  MyProfileModify({this.vo});

  @override
  _MyProfileModifyState createState() => _MyProfileModifyState();
}

class _MyProfileModifyState extends State<MyProfileModify> {
  RetrofitHelper helper;

  var phoneC = TextEditingController();
  var etcC = TextEditingController();
  List<String> tagList = [];

  @override
  void initState() {
    super.initState();
    phoneC.text = widget.vo.member.phone;
    etcC.text = widget.vo.member.etc;
    tagList = widget.vo.tag;
  }

  @override
  void dispose() {
    phoneC.dispose();
    etcC.dispose();
    super.dispose();
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
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(right: 34, left: 34),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildTextField("전화번호", phoneC, type: TextInputType.phone),
                      SizedBox(
                        height: 20,
                      ),
                      buildTextField("소개", etcC, type: TextInputType.text, maxLine: 4, maxLength: 255),
                      SizedBox(
                        height: 30,
                      ),
                      makeBtn(
                          msg: "태그 선택하러 가기",
                          onPressed: () async {
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
                          mode: 4,
                          icon: Icon(
                            Icons.tag,
                            color: Colors.white,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Align(
                            alignment: Alignment.center,
                            child: makeTagWidget(
                                tag: tagList, size: Size(360, 27), mode: 1)),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 20,
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

  _postModifyProfile() async {
    if (phoneC.text.isEmpty || etcC.text.isEmpty || tagList.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
        setState(() {});
      }));
      try {
        var res = await helper.putProfile({
          "memberETC": etcC.text,
          "memberPhoneNumber": phoneC.text,
          "tagName": tagList
        });
        if (res.success) {
          snackBar("프로필을 수정했습니다.", context);
          Navigator.pop(context);
        } else {
          snackBar(res.msg, context);
        }
      } catch (e) {
        print("err: $e");
      }
    }
  }
}
