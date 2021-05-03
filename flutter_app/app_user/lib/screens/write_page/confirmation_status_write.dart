import 'package:app_user/model/confirmation/confirmation_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drop_down_button.dart';
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
  var addressC = TextEditingController();
  var siteUrl = TextEditingController();
  var etcC = TextEditingController();
  var classNumberC = TextEditingController();

  List<String> _list = [];
  List<String> tagList = [];

  RetrofitHelper helper;

  init() {
    _list.add("Google");
    _list.add("IOS");
    _list.add("Android");
    _list.add("Dart");
    _list.add("Flutter");
    _list.add("Python");
    _list.add("React");
    _list.add("Xamarin");
    _list.add("Kotlin");
    _list.add("Java");
    _list.add("RxAndroid");
  }

  @override
  void initState() {
    super.initState();
    init();
    initRetrofit();
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
                    buildTextField("학번", classNumberC, deco: false),
                    buildTextField("회사 사이트 주소", siteUrl, deco: false),
                    buildTextField("지역명", areaC, deco: false),
                    buildTextField(
                      "상세 주소",
                      addressC, deco: false
                    ),
                  ],
                ),
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
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: makeBtn(msg: "태그 선택하러 가기", onPressed: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchPage(
                              list: _list,
                            )));
                setState(() {
                  if (result != null) {
                    tagList = result;
                  }
                });
                print("tagList: $tagList");
              }, mode: 2),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Align(
                  alignment: Alignment.center,
                  child: makeTagWidget(
                      tag: tagList, size: Size(360, 27), mode: 1)),
            ),
            SizedBox(
              height: 20,
            ),
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
        classNumberC.text.isEmpty ||
        tagList.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      var vo = ConfirmationVO(
          title: titleC.text,
          area: areaC.text,
          siteUrl: siteUrl.text,
          address: addressC.text,
          etc: etcC.text,
          classNumber: classNumberC.text,
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
