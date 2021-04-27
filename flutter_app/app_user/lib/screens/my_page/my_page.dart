import 'package:app_user/screens/my_page/my_profile_create.dart';
import 'package:app_user/screens/my_page/my_profile_modify.dart';
import 'package:app_user/screens/my_page/portfolio.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drawer.dart';
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
      appBar: buildAppBar("취준타임",  context),
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
            widget.isCreated
                ? Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                    child: Container(
                      width: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${classNumber}반 ${number}번 ${"이건 이름"}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "TEL. ${phone}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Home. ${address}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  )
                : Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                    child: Container(
                      width: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                            child: Text(
                          "프로필을 작성해주세요.",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        )),
                      ),
                    ),
                  ),
            Card(
              margin: EdgeInsets.fromLTRB(25, 22, 25, 10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              child: Padding(
                padding: EdgeInsets.all(15),
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
              margin: EdgeInsets.fromLTRB(25, 22, 25, 22),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              child: Padding(
                padding: EdgeInsets.all(15),
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
                child: Align(
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
            )),
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
