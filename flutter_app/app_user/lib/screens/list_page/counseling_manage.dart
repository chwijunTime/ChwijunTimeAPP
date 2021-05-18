import 'package:app_user/consts.dart';
import 'package:app_user/model/counseling_vo.dart';
import 'package:app_user/screens/write_page/counseling_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/counseling_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CounselingManage extends StatefulWidget {
  @override
  _CounselingManageState createState() => _CounselingManageState();
}

class _CounselingManageState extends State<CounselingManage> {
  final scafforldkey = GlobalKey<ScaffoldState>();

  PanelController panelController = PanelController();
  final _scrollController = ScrollController();
  var tagC = TextEditingController();
  final titleC = TextEditingController();

  List<CounselingVO> counList = [];
  List<String> tagList = [];
  int itemCount = Consts.showItemCount;

  Future<List<CounselingVO>> getCounselingList() async {
    List<CounselingVO> list = [];
    await Future.delayed(Duration(seconds: 1));
    for (int i = 0; i < 39; i++) {
      list.add(CounselingVO(
          date: "2021.03.21",
          time: "03:30",
          place: "취진부",
          tag: List.generate(5, (index) => "${i}.tag"),
          reason: "이유라는게 뭐 각별하게 있습니다. 있다구요",
          user: "3210 안수빈",
          done: i % 2 == 0));
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
      key: scafforldkey,
      appBar: buildAppBar("취준타임", context),
      drawer: buildDrawer(context),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(26),
              child: Row(
                children: [
                  Column(
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
                        "상담신청 내역",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: makeGradientBtn(
                          msg: "상담 등록하기",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CounselingWrite()));
                          },
                          mode: 1,
                          icon: Icon(
                            Icons.note_add,
                            color: Colors.white,
                          )))
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 33, left: 33, bottom: 26),
                child: buildTextField("키워드 검색", titleC,
                    autoFocus: false,
                    icon: Icon(Icons.search), textInput: (String key) {
                  print("호잇: ${key}");
                })),
            Expanded(
                child: FutureBuilder(
              future: getCounselingList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  counList = snapshot.data;
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: itemCount + 1,
                    itemBuilder: (context, index) {
                      if (index == itemCount) {
                        if (index == counList.length) {
                          return Padding(
                            padding: EdgeInsets.all(Consts.padding),
                            child: makeGradientBtn(
                                msg: "맨 처음으로",
                                onPressed: () {
                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.minScrollExtent,
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.elasticOut);
                                },
                                mode: 1,
                                icon: Icon(
                                  Icons.arrow_upward,
                                  color: Colors.white,
                                )),
                          );
                        } else {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
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
            )),
          ],
        ),
      ),
    );
  }

  Widget buildCounseling(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                CounselingDialog(index: counList[index].index));
      },
      child: Card(
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        counList[index].place,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                counList[index].done
                    ? Container(
                        width: 48,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            border: Border.all(color: Color(0xffFF7777))),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            "마감",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffFF7777)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Container(
                        width: 48,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            border: Border.all(color: Color(0xff5BC7F5))),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            "진행중",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff5BC7F5)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
              ],
            ),
          )),
    );
  }
}
