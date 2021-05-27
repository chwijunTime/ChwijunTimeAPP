import 'package:app_user/model/comp_notice/comp_notice_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyNoticeModifyPage extends StatefulWidget {
  CompNoticeVO list;

  CompanyNoticeModifyPage({@required this.list});

  @override
  _CompanyNoticeModifyPageState createState() =>
      _CompanyNoticeModifyPageState();
}

class _CompanyNoticeModifyPageState extends State<CompanyNoticeModifyPage> {
  RetrofitHelper helper;

  var titleC = TextEditingController();
  var fieldC = TextEditingController();
  var infoC = TextEditingController();
  var preferentialInfoC = TextEditingController();
  var addressC = TextEditingController();
  var etcC = TextEditingController();
  var deadline = TextEditingController();
  List<String> tagList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      titleC.text = widget.list.title;
      fieldC.text = widget.list.field;
      infoC.text = widget.list.info;
      preferentialInfoC.text = widget.list.preferential;
      addressC.text = widget.list.address;
      etcC.text = widget.list.etc;
      var tempDate =
      DateFormat("yyyy-MM-dd").parse(widget.list.deadLine);
      var strDate = DateFormat("yyyy년 MM월 dd일").format(tempDate);
      deadline.text = "$strDate (수정이 불가능합니다.)";
      tagList = widget.list.tag;
    });
    initRetrofit();
  }

  @override
  void dispose() {
    titleC.dispose();
    fieldC.dispose();
    infoC.dispose();
    preferentialInfoC.dispose();
    addressC.dispose();
    etcC.dispose();
    deadline.dispose();
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
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 25,
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
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return Column(
                    children: [
                      buildTextField("업체명", titleC, deco: false),
                      buildTextField("채용분야", fieldC, deco: false),
                      buildTextField("주소", addressC, deco: false),
                      buildTextField("마감일", deadline, deco: false, disable: true)
                    ],
                  );
                }),
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
                        "회사 설명",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildTextField("회사 설명을 적어주세용", infoC,
                          maxLine: 10, maxLength: 500, multiLine: true, type: TextInputType.multiline)
                    ],
                  ),
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
                        "우대 조건",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildTextField("우대 조건을 적어주세용", preferentialInfoC,
                          maxLine: 10, maxLength: 500, multiLine: true, type: TextInputType.multiline)
                    ],
                  ),
                ),
              ),
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
                      buildTextField("기타 설명을 적어주세요. (필수가 아닙니다.)", etcC,
                          maxLine: 10, maxLength: 500, multiLine: true, type: TextInputType.multiline)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: makeBtn(
                  msg: "태그 선택하러 가기",
                  onPressed: () async {
                    final result = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchPage()));
                    setState(() {
                      if (result != null) {
                        tagList = result;
                      }
                    });
                    print("tagList: $tagList");
                  },
                  mode: 2),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Align(
                  alignment: Alignment.center,
                  child: makeTagWidget(
                      tag: tagList, size: Size(360, 27), mode: 1)),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 34, left: 34, bottom: 25),
              child: makeGradientBtn(
                  msg: "수정하기",
                  onPressed: _onModify,
                  mode: 4,
                  icon: Icon(
                    Icons.note_add,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }

  _onModify() async {
    if (titleC.text.isEmpty ||
        fieldC.text.isEmpty ||
        addressC.text.isEmpty ||
        infoC.text.isEmpty ||
        preferentialInfoC.text.isEmpty ||
        tagList.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      CompNoticeVO vo = CompNoticeVO(
          title: titleC.text,
          field: fieldC.text,
          address: addressC.text,
          info: infoC.text,
          preferential: preferentialInfoC.text,
          etc: etcC.text.isEmpty ? "" : etcC.text,
      postTag: tagList);

      final pref = await SharedPreferences.getInstance();
      var token = pref.getString("accessToken");
      print(vo);
      try {
        var res = await helper.putComp(token, widget.list.index, vo.toJson());
        if (res.success) {
          Navigator.pop(context, true);
        } else {
          snackBar(res.msg, context);
          print("eeror: ${res.msg}");
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
