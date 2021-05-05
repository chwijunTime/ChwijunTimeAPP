import 'package:app_user/model/company_review/review_vo.dart';
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

class InterviewReviewWrite extends StatefulWidget {
  @override
  _InterviewReviewWriteState createState() => _InterviewReviewWriteState();
}

class _InterviewReviewWriteState extends State<InterviewReviewWrite> {
  RetrofitHelper helper;

  var titleC = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String strDate = "지원날짜";
  String date = "";
  var addressC = TextEditingController();
  var priceC = TextEditingController();
  var reviewC = TextEditingController();
  var questionC = TextEditingController();
  var grade = "1학년";

  List<String> gradeList = ['1학년', '2학년', '3학년'];
  List<String> tagList = [];

  List<String> _list = [];

  initList() {
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
    initList();
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
                    child: buildTextField("비용", priceC,
                        type: TextInputType.number),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 33, left: 33, top: 10),
              child: GestureDetector(
                onTap: () async {
                  final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2050));
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                      strDate =
                          "${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일";
                    });
                    date =
                        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      strDate,
                      style: TextStyle(
                          fontSize: 16,
                          color:
                              strDate == "지원날짜" ? Colors.grey : Colors.black),
                    ),
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
                        "후기 내용",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      buildTextField("후기 내용을 작성해주세요.", reviewC,
                          maxLine: 6, maxLength: 100)
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              margin: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 20),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "자주 나온 질문",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      buildTextField("자주 나온 질문을 작성해주세요.", questionC,
                          maxLine: 6, maxLength: 100)
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
                            builder: (context) => SearchPage(
                                  list: _list,
                                )));
                    setState(() {
                      if (result != null) {
                        tagList = result;
                      }
                    });
                    print("tagList: $tagList");
                  },
                  mode: 2),
            ),
            Align(
                alignment: Alignment.center,
                child:
                    makeTagWidget(tag: tagList, size: Size(360, 27), mode: 1)),
            Padding(
              padding:
                  EdgeInsets.only(right: 33, left: 33, top: 10, bottom: 30),
              child: makeGradientBtn(
                  msg: "등록하기",
                  onPressed: () {
                    onReviewPost();
                  },
                  mode: 2,
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

  onReviewPost() async {
    print(
        "${titleC.text}, ${grade}, ${strDate}, ${addressC.text}, ${priceC.text}, ${reviewC.text}, ${questionC.text}, ${tagList.toString()}");

    if (titleC.text.isEmpty ||
        date == "" ||
        addressC.text.isEmpty ||
        priceC.text.isEmpty ||
        reviewC.text.isEmpty ||
        questionC.text.isEmpty ||
        tagList.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      ReviewVO vo = ReviewVO(
          address: addressC.text,
          price: int.parse(priceC.text),
          applyDate: strDate,
          question: questionC.text,
          title: titleC.text,
          review: reviewC.text,
          tag: tagList);

      final pref = await SharedPreferences.getInstance();
      var token = pref.getString("accessToken");
      print("token: ${token}");
      try {
        var res = await helper.postReview(token, vo.toJson());
        if (res.success) {
          Navigator.pop(context, true);
        } else {
          snackBar("서버에러", context);
          print("error: ${res.msg}");
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
