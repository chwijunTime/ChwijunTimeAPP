import 'package:app_user/model/resume_portfolio/portfolio_vo.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/dialog/request_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:flutter/material.dart';

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  List<PortfolioVO> introList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      drawer: buildDrawer(context),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "취준타임",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0x832B8AC0)),
                  ),
                  Text(
                    "자기소개서 첨삭 요청",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: introList.length,
                itemBuilder: (context, index) {
                  return buildPortfolio(context, index);
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  );
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPortfolio(BuildContext context, int index) {
    return Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: GestureDetector(
            onTap: () {
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
                ],
              ),
            ),
          ),
        ));
  }

  Widget makeTag(String str) {
    String msg;
    Color color;

    if (str == "notDone") {
      msg = "처리전";
      color = Colors.black;
    } else if (str == "approve") {
      msg = "승인";
      color = Color(0xff5BC7F5);
    } else {
      msg = "거절";
      color = Color(0xffFF7777);
    }

    return Container(
      width: 48,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: Border.all(color: color)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Text(
          msg,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: color),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
