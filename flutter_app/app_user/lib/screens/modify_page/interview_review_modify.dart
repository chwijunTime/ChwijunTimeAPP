import 'package:app_user/model/company_review/review_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterviewReviewModify extends StatefulWidget {
  ReviewVO list;

  InterviewReviewModify({@required this.list});

  @override
  _InterviewReviewModifyState createState() => _InterviewReviewModifyState();
}

class _InterviewReviewModifyState extends State<InterviewReviewModify> {
  RetrofitHelper helper;

  var titleC = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String strDate = "지원날짜";
  String date = "";
  var addressC = TextEditingController();
  var priceC = TextEditingController();
  var reviewC = TextEditingController();
  var questionC = TextEditingController();
  List<String> tagList = [];

  @override
  void initState() {
    super.initState();
    initRetrofit();
    setState(() {
      titleC.text = widget.list.title;
      addressC.text = widget.list.address;
      priceC.text = widget.list.price.toString();
      reviewC.text = widget.list.review;
      questionC.text = widget.list.question;
      var listDate = widget.list.applyDate.split("-");
      strDate = "${listDate[0]}년 ${listDate[1]}월 ${listDate[2]}일";
      tagList = widget.list.tag;
    });
  }

  @override
  void dispose() {
    titleC.dispose();
    addressC.dispose();
    priceC.dispose();
    reviewC.dispose();
    questionC.dispose();
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
            Padding(
              padding: const EdgeInsets.only(right: 33, left: 33, top: 24),
              child: buildTextField("업체명", titleC),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 33, left: 33, top: 10),
              child: buildTextField("주소", addressC, type: TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 33, left: 33, top: 10),
              child: buildTextField("비용", priceC, type: TextInputType.number),
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
                    final f = DateFormat("yyyy-MM-dd");
                    date = f.format(selectedDate);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
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
            Align(
                alignment: Alignment.center,
                child:
                    makeTagWidget(tag: tagList, size: Size(360, 27), mode: 1)),
            Padding(
              padding:
                  EdgeInsets.only(right: 33, left: 33, top: 10, bottom: 30),
              child: makeGradientBtn(
                  msg: "수정하기",
                  onPressed: _onModify,
                  mode: 2,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }

  _onModify() async {
    if (addressC.text.isEmpty ||
        priceC.text.isEmpty ||
        reviewC.text.isEmpty ||
        questionC.text.isEmpty ||
        titleC.text.isEmpty ||
        tagList.isEmpty ||
        strDate.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요.", context);
    } else {
      ReviewVO vo = ReviewVO(
        title: titleC.text,
        applyDate: date,
        address: addressC.text,
        price: int.parse(priceC.text),
        review: reviewC.text,
        question: questionC.text,
        postTag: tagList,
      );
      final pref = await SharedPreferences.getInstance();
      var token = pref.getString("accessToken");
      try {
        print(vo.toJson());
        var res = await helper.putReview(token, widget.list.index, vo.toJson());
        if (res.success) {
          Navigator.pop(context);
        } else {
          print("err: ${res.msg}");
          snackBar(res.msg, context);
        }
      } catch (e) {
        print("error: $e");
      }
    }
  }
}
