import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  String studentId = "3210";
  String name = "안수빈";
  bool isCreated = true;

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임"),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  color: Color(0xff5BC7F5),
                  height: 100,
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
                        "자소서 다운받기",
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
                        onPressed: () {})
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                    padding: EdgeInsets.only(right: 25, bottom: 25),
                    child: widget.isCreated
                        ? makeGradientBtn(
                            msg: "프로필 수정하기",
                            onPressed: () {},
                            mode: 1,
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ))
                        : makeGradientBtn(
                            msg: "프로필 생성하기",
                            onPressed: () {},
                            mode: 1,
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
