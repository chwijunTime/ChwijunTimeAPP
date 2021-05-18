import 'package:app_user/consts.dart';
import 'package:app_user/model/counseling_vo.dart';
import 'package:app_user/screens/detail_page/counseling_apply_detail.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class CounselingApplyPage extends StatefulWidget {
  @override
  _CounselingApplyPageState createState() => _CounselingApplyPageState();
}

class _CounselingApplyPageState extends State<CounselingApplyPage> {
  List<CounselingVO> counList = [];
  final _scrollController = ScrollController();
  int itemCount = Consts.showItemCount;

  final titleC = TextEditingController();

  Future<List<CounselingVO>> getCounselingList() async {
    await Future.delayed(Duration(seconds: 1));
    List<CounselingVO> list = [];
    for (int i = 0; i < 33; i++) {
      list.add(CounselingVO(
        index: i,
          date: "2021.03.2${i}",
          time: "0${i}.30.PM",
          place: "취진부 상담실",
          reason: "아니 이유 그런게 필요한가요?",
          tag: List.generate(5, (index) => "text${index}")));
    }

    return list;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    titleC.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        if (itemCount != counList.length) {
          if ((counList.length - itemCount) ~/ Consts.showItemCount <= 0) {
            itemCount += counList.length % Consts.showItemCount;
          } else {
            itemCount += Consts.showItemCount;
          }
        }
      });
    }
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
                    "취진부 상담신청",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 33, left: 33, bottom: 26),
                child: buildTextField("상담 제목", titleC,
                    autoFocus: false,
                    icon: Icon(Icons.search), textInput: (String key) {
                      print(key);
                    })),
            Expanded(
              child: FutureBuilder(
                future: getCounselingList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    counList = snapshot.data;
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: itemCount +1,
                      itemBuilder: (context, index) {
                        if (index == itemCount) {
                          if (index == counList.length) {
                            return Padding(
                              padding: EdgeInsets.all(Consts.padding),
                              child: makeGradientBtn(msg: "맨 처음으로",
                                  onPressed: () {
                                    _scrollController.animateTo(
                                        _scrollController.position
                                            .minScrollExtent,
                                        duration: Duration(
                                            milliseconds: 200),
                                        curve: Curves.elasticOut);
                                  },
                                  mode: 1,
                                  icon: Icon(Icons.arrow_upward,
                                    color: Colors.white,)),
                            );
                          } else {
                            return Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                              elevation: 5,
                              margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(Consts.padding),
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          }
                        } else {
                          return buildCounseling(context, index);
                        }
                      },
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
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
                            CounselingApplyDetail(index: counList[index].index,)));
                  })
            ],
          ),
        ));
  }
}
