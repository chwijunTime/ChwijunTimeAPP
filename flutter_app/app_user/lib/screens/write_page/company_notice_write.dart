import 'package:app_user/model/comp_notice/comp_notice_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CompanyNoticeWritePage extends StatefulWidget {
  @override
  _CompanyNoticeWritePageState createState() => _CompanyNoticeWritePageState();
}

class _CompanyNoticeWritePageState extends State<CompanyNoticeWritePage> {
  var titleC = TextEditingController();
  var fieldC = TextEditingController();
  var infoC = TextEditingController();
  var preferentialInfoC = TextEditingController();
  var addressC = TextEditingController();
  String deadLineDateC = "마감일 (클릭해주세요)";
  String deadLineDate = "";
  var etcC = TextEditingController();
  List<String> tagList = [];

  DateTime selectedDate = DateTime.now();
  RetrofitHelper helper;

  @override
  void dispose() {
    titleC.dispose();
    fieldC.dispose();
    infoC.dispose();
    preferentialInfoC.dispose();
    addressC.dispose();
    etcC.dispose();
    super.dispose();
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
                      buildTextField("지역", addressC, deco: false),
                      GestureDetector(
                        onTap: () async {
                          final DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050));
                          if (picked != null) {
                            setState(() {
                              selectedDate = picked;
                              deadLineDateC =
                                  "${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일";
                              deadLineDateC = DateFormat("yyyy년 MM월 dd일").format(selectedDate);
                              deadLineDate = DateFormat("yyyy-MM-dd").format(selectedDate);
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 1))),
                          width: constraints.maxWidth,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 14, bottom: 14),
                            child: Text(
                              deadLineDateC,
                              style: TextStyle(
                                  color: deadLineDateC == "마감일 (클릭해주세요)"
                                      ? Colors.grey
                                      : Colors.black,
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
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
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      buildTextField("회사 설명을 적어주세용", infoC,
                          maxLine: 15, maxLength: 15000, multiLine: true, type: TextInputType.multiline)
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
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      buildTextField("우대 조건을 적어주세용", preferentialInfoC,
                          maxLine: 15, maxLength: 5000, multiLine: true, type: TextInputType.multiline)
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
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      buildTextField("기타 설명을 적어주세요.", etcC,
                          maxLine: 15, maxLength: 5000, multiLine: true, type: TextInputType.multiline)
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
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 34, left: 34, bottom: 25),
              child: makeGradientBtn(
                  msg: "등록하기",
                  onPressed: _onCreate,
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

  _onCreate() async {
    if (titleC.text.isEmpty ||
        fieldC.text.isEmpty ||
        deadLineDate == deadLineDateC ||
        addressC.text.isEmpty ||
        tagList.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      CompNoticeVO vo = CompNoticeVO(
          title: titleC.text,
          deadLine: deadLineDate,
          field: fieldC.text,
          address: addressC.text,
          info: infoC.text.isEmpty ? "": infoC.text,
          preferential: preferentialInfoC.text.isEmpty ? "" : preferentialInfoC.text,
          postTag: tagList,
          etc: etcC.text.isEmpty ? "" : etcC.text);

      helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
        setState(() {});
      }));
      print(vo.toJson());
      try {
        var res = await helper.postComp(vo.toJson());
        if (res.success) {
          Navigator.pop(context, true);
        } else {
          print("error: ${res.msg}");
          snackBar(res.msg, context);
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
