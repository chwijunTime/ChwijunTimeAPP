import 'package:app_user/screens/list_page/company_notice.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompanyNoticeWritePage extends StatefulWidget {
  @override
  _CompanyNoticeWritePageState createState() => _CompanyNoticeWritePageState();
}

class _CompanyNoticeWritePageState extends State<CompanyNoticeWritePage> {
  var titleC = TextEditingController();
  var fieldC = TextEditingController();
  String noticeDateC = "공고일";
  String deadLineDateC = "마감일";
  String noticeDate, deadLineDate = "";
  var addressC = TextEditingController();
  var infoC = TextEditingController();
  var preferentialInfoC = TextEditingController();
  var etcC = TextEditingController();
  List<String> tagList = [];
  List<String> _list = [];

  DateTime selectedDate = DateTime.now();

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
                child: LayoutBuilder(
                   builder:  (BuildContext context, BoxConstraints constraints) {
                     return Column(
                       children: [
                         buildTextField("업체명", titleC, deco: false),
                         buildTextField("채용분야", fieldC, deco: false),
                         buildTextField("주소", addressC, deco: false),
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
                                 noticeDateC = "${selectedDate.year}년 ${selectedDate
                                     .month}월 ${selectedDate.day}일";
                               });
                               noticeDate = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                             }
                           },
                           child: Container(
                             decoration: BoxDecoration(
                               border: Border(
                                 bottom: BorderSide(
                                   color: Colors.grey,
                                   width: 1
                                 )
                               )
                             ),
                             width: constraints.maxWidth,
                             child: Padding(
                               padding: const EdgeInsets.only(top: 10, bottom: 10),
                               child: Text(noticeDateC, style: TextStyle(color: noticeDateC == "공고일" ? Colors.grey: Colors.black, fontSize: 16),),
                             ),
                           ),
                         ),
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
                                 deadLineDateC = "${selectedDate.year}년 ${selectedDate
                                     .month}월 ${selectedDate.day}일";
                               });
                               deadLineDate = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                             }
                           },
                           child: Container(
                             decoration: BoxDecoration(
                                 border: Border(
                                     bottom: BorderSide(
                                         color: Colors.grey,
                                         width: 1
                                     )
                                 )
                             ),
                             width: constraints.maxWidth,
                             child: Padding(
                               padding: const EdgeInsets.only(top: 10, bottom: 10),
                               child: Text(deadLineDateC, style: TextStyle(color: deadLineDateC == "마감일" ? Colors.grey: Colors.black, fontSize: 16),),
                             ),
                           ),
                         ),
                       ],
                     );
                   }
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
                        "회사 설명",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildTextField("회사 설명을 적어주세용", infoC,
                          maxLine: 10, maxLength: 500)
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
                          maxLine: 10, maxLength: 500)
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
                          maxLine: 10, maxLength: 500)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: makeBtn(msg: "태그 선택하러 가기", onPressed: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage(
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

  _onCreate() {
    if (titleC.text.isEmpty ||
        fieldC.text.isEmpty ||
        noticeDate == "" ||
        deadLineDate == ""||
        addressC.text.isEmpty ||
        infoC.text.isEmpty ||
        preferentialInfoC.text.isEmpty ||
        tagList.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      CompNotice vo = CompNotice(
          title: titleC.text,
          startDate: noticeDate,
          endDate: deadLineDate,
          field: fieldC.text,
          address: addressC.text,
          compInfo: infoC.text,
          preferentialInfo: preferentialInfoC.text,
          isBookMark: false,
          tag: tagList,
          etc: etcC.text.isEmpty ? "" : etcC.text);

      print(vo);
      Navigator.pop(context);
    }
  }
}
