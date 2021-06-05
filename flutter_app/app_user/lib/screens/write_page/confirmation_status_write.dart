import 'package:app_user/model/confirmation/confirmation_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationStatusWrite extends StatefulWidget {
  @override
  _ConfirmationStatusWriteState createState() =>
      _ConfirmationStatusWriteState();
}

class _ConfirmationStatusWriteState extends State<ConfirmationStatusWrite> {
  var titleC = TextEditingController();
  var areaC = TextEditingController();
  var stdNameC = TextEditingController();
  var generationC = TextEditingController();
  var addressC = TextEditingController();
  var siteUrl = TextEditingController();
  var etcC = TextEditingController();
  List<String> tagList = [];

  RetrofitHelper helper;

  @override
  void initState() {
    super.initState();
    initRetrofit();
  }

  @override
  void dispose() {
    titleC.dispose();
    areaC.dispose();
    stdNameC.dispose();
    generationC.dispose();
    addressC.dispose();
    siteUrl.dispose();
    etcC.dispose();
    super.dispose();
  }

  initRetrofit() {
    Dio dio = Dio(BaseOptions(
        connectTimeout: 5 * 1000,
        receiveTimeout: 5 * 1000,
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        }));
    helper = RetrofitHelper(dio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              margin: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 25,
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    buildTextField("업체명", titleC, deco: false),
                    buildTextField("학생 이름", stdNameC, deco: false),
                    buildTextField("회사 사이트 주소", siteUrl, deco: false),
                    buildTextField("지역명", areaC, deco: false),
                    buildTextField("상세 주소", addressC, deco: false),
                    buildTextField("기수", generationC, suffixText: "기", type: TextInputType.number, deco: false),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              margin: EdgeInsets.all(25),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "기타",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildTextField("비고를 적어주세요", etcC,
                          maxLine: 10, maxLength: 500)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: makeBtn(
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
                  icon: Icon(Icons.tag, color: Colors.white,)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Align(
                  alignment: Alignment.center,
                  child: makeTagWidget(
                      tag: tagList, size: Size(360, 27), mode: 1)),
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
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  onReviewPost() async {
    if (titleC.text.isEmpty ||
        siteUrl.text.isEmpty ||
        addressC.text.isEmpty ||
        areaC.text.isEmpty ||
        stdNameC.text.isEmpty ||
        generationC.text.isEmpty ||
        tagList.isEmpty ||
    etcC.text.isEmpty ) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      var vo = ConfirmationVO(
          title: titleC.text,
          area: areaC.text,
          siteUrl: siteUrl.text,
          etc: etcC.text,
          jockey: generationC.text,
          address: addressC.text,
          name: stdNameC.text,
          postTag: tagList);
      try {
        final pref = await SharedPreferences.getInstance();
        var token = pref.getString("accessToken");
        var res = await helper.postConf(token, vo.toJson());
        if (res.success) {
          Navigator.pop(context, true);
        } else {
          snackBar("서버오류", context);
          print("error: ${res.msg}");
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
