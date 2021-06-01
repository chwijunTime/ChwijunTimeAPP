import 'package:app_user/screens/my_page/my_list.dart';
import 'package:app_user/screens/my_page/my_profile_create.dart';
import 'package:app_user/screens/my_page/my_profile_modify.dart';
import 'package:app_user/screens/my_page/portfolio.dart';
import 'package:app_user/screens/my_page/resume.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drawer.dart';
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
              margin: EdgeInsets.fromLTRB(25, 22, 25, 22),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "이력서 보러가기",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResumePage()));
                        })
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(25, 0, 25,22),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                          Icons.arrow_forward_ios_rounded,
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
            Card(
              margin: EdgeInsets.fromLTRB(25, 0, 25, 22),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "마이 리스트 보러가기",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyListPage()));
                        })
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                    padding: EdgeInsets.only(right: 25, bottom: 40),
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
            ),
          ],
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
