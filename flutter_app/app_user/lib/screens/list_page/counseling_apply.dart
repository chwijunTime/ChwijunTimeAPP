import 'package:app_user/model/counseling_vo.dart';
import 'package:app_user/screens/detail_page/counseling_apply_detail.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:flutter/material.dart';

class CounselingApplyPage extends StatefulWidget {
  @override
  _CounselingApplyPageState createState() => _CounselingApplyPageState();
}

class _CounselingApplyPageState extends State<CounselingApplyPage> {
  List<CounselingVO> counList = [];

  initList() {
    for (int i = 0; i < 10; i++) {
      counList.add(CounselingVO(
          date: "2021.03.2${i}",
          time: "0${i}.30.PM",
          place: "취진부 상담실",
          reason: "아니 이유 그런게 필요한가요?",
          tag: List.generate(5, (index) => "text${index}")));
    }
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      drawer: buildDrawer(context),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        label: makeGradientBtn(
            msg: "내가 신청한 상담 보러가기",
            onPressed: () {},
            mode: 4,
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )),
      ),
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
                    "취진부 상담신청",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: counList.length,
                itemBuilder: (context, index) {
                  return buildCounseling(context, index);
                },
                shrinkWrap: true,
                physics: ScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCounseling(BuildContext context, int index) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18))),
        elevation: 5,
        margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: Padding(
          padding: EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${counList[index].date}, ${counList[index].time}",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      counList[index].place,
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.outgoing_mail,
                    color: Color(0xff4687ff),
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            CounselingApplyDetail(list: counList[index],)));
                  })
            ],
          ),
        ));
  }
}
