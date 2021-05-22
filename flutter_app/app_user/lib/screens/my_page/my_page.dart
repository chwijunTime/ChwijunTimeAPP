import 'package:app_user/model/company_review/review_vo.dart';
import 'package:app_user/screens/detail_page/interview_review_detail.dart';
import 'package:app_user/screens/my_page/my_profile_create.dart';
import 'package:app_user/screens/my_page/my_profile_modify.dart';
import 'package:app_user/screens/my_page/portfolio.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  String studentId = "3210";
  String name = "안수빈";
  bool isCreated = false;

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String phone = "010-2467-9504";
  String address = "광주광역시 우리집";
  String classNumber = "2";
  String number = "10";
  List<String> tagList = List.generate(5, (index) => "${index}.tag");

  CarouselController buttonCarouselController = CarouselController();
  List<Widget> menuList = [
    Image.asset("images/logo.png",),
    Image.asset("images/loco.jpg"),
    Image.asset("images/top.png"),
    Image.asset("images/bottom.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  color: Color(0xff5BC7F5),
                  height: 110,
                  width: constraints.maxWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.studentId} ${widget.name}님!",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "취준타임",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w900)),
                          TextSpan(
                              text: "과 함께 취업 준비해요.",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ]))
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              margin: EdgeInsets.fromLTRB(25, 22, 25, 10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15,5,15,5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "자소서 보러가기",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.file_download,
                          size: 28,
                        ),
                        onPressed: () {})
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(25, 0, 25, 22),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15,5,15,5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "포트폴리오 보러가기",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.file_download,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PortfolioPage()));
                        })
                  ],
                ),
              ),
            ),
            Expanded(
                child: CarouselSlider(
                    items: menuList,
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      aspectRatio: 2.0,
                      initialPage: 2,
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                makeBtn(
                    msg: "←",
                    onPressed: () {
                      buttonCarouselController.previousPage();
                    },
                    mode: 3),
                SizedBox(
                  width: 20,
                ),
                makeBtn(
                    msg: "→",
                    onPressed: () {
                      buttonCarouselController.nextPage();
                    },
                    mode: 3)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: EdgeInsets.only(right: 25, bottom: 25),
                  child: makeGradientBtn(
                      msg: widget.isCreated ? "프로필 수정하기" : "프로필 생성하기",
                      onPressed: widget.isCreated
                          ? _moveProfileModif
                          : _moveProfileCreate,
                      mode: 1,
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ))),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<ReviewVO>> _getReview() async {
    List<ReviewVO> list = [];

    return list;
  }

  Widget buildItemReview(BuildContext context, int index, List<ReviewVO> list) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
      child: GestureDetector(
        onTap: () {
          print("눌림");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (countext) => InterviewReviewDetail(
                        index: list[index].index,
                      )));
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${list[index].title}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Text(
                  "${list[index].review}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 22,
                child: Row(
                  children: [
                    Row(
                      children: List.generate(2, (indextag) {
                        return buildItemTag(list[index].tag, indextag);
                      }),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.blue[400],
                          )),
                      child: Center(
                        child: Text(
                          "외 ${list[index].tag.length - 2}개",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "지원날짜: ${list[index].applyDate}",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _moveProfileCreate() async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyProfileCreate()));
    setState(() {
      if (result == null) {
        widget.isCreated = false;
      } else {
        widget.isCreated = result;
      }
    });
  }

  _moveProfileModif() async {
    final Map<String, String> result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyProfileModify(
                  phone: phone,
                  classNumber: classNumber,
                  number: number,
                  tagList: tagList,
                  address: address,
                )));
    setState(() {
      if (result != null) {
        classNumber = result["class"];
        number = result["number"];
        address = result["address"];
      }
    });
  }
}
