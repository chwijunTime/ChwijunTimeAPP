import 'package:app_user/model/company_review/review_vo.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class InterviewReviewModify extends StatefulWidget {
  ReviewVO list;
  int index;

  InterviewReviewModify({@required this.index});

  @override
  _InterviewReviewModifyState createState() => _InterviewReviewModifyState();
}

class _InterviewReviewModifyState extends State<InterviewReviewModify> {
  var titleC = TextEditingController();
  var applyDateC = TextEditingController();
  var addressC = TextEditingController();
  var priceC = TextEditingController();
  var reviewC = TextEditingController();
  var questionC = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      addressC.text = widget.list.address;
      priceC.text = widget.list.price.toString();
      reviewC.text = widget.list.review;
      questionC.text = widget.list.question;
    });
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
              padding: EdgeInsets.only(right: 33, left: 33, top: 24),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 16, bottom: 16),
                  child: Text(
                    widget.list.title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 33, left: 33, top: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    widget.list.applyDate,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 33, left: 33, top: 10),
              child: buildTextField("주소", addressC),
            ),
            Padding(
              padding: EdgeInsets.only(right: 33, left: 33, top: 10),
              child: buildTextField("비용", priceC, type: TextInputType.number),
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
            Align(
                alignment: Alignment.center,
                child: makeTagWidget(
                    tag: widget.list.tag, size: Size(360, 27), mode: 1)),
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

  _onModify() {
    if (addressC.text.isEmpty ||
        priceC.text.isEmpty ||
        reviewC.text.isEmpty ||
        questionC.text.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요.", context);
    } else {
      ReviewVO vo = ReviewVO(
          title: widget.list.title,
          applyDate: widget.list.applyDate,
          address: addressC.text,
          price: int.parse(priceC.text),
          review: reviewC.text,
          question: questionC.text,
          tag: widget.list.tag,
          isFavorite: widget.list.isFavorite,
          isMine: widget.list.isMine);
      Navigator.pop(context, vo);
    }
  }
}
