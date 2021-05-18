import 'package:app_user/consts.dart';
import 'package:app_user/model/tip_storage_vo.dart';
import 'package:app_user/screens/detail_page/tip_storage_detail.dart';
import 'package:app_user/screens/write_page/tip_storage_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class TipStoragePage extends StatefulWidget {
  @override
  _TipStoragePageState createState() => _TipStoragePageState();
}

class _TipStoragePageState extends State<TipStoragePage> {
  final scafforldkey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();

  List<TipVO> tipList = [];
  final titleC = TextEditingController();
  int itemCount = Consts.showItemCount;

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
        if (itemCount != tipList.length) {
          if ((tipList.length - itemCount) ~/ Consts.showItemCount <= 0) {
            itemCount += tipList.length % Consts.showItemCount;
          } else {
            itemCount += Consts.showItemCount;
          }
        }
      });
    }
  }

  Future<List<TipVO>> getTipList() async {
    await Future.delayed(Duration(seconds: 2));
    List<TipVO> list = [];
    for (int i = 0; i < 52; i++) {
      list.add(TipVO(
          title: "${i + 1}.업체명",
          address: "광주광역시 광산구 광주소프트웨어마이스터고등학교",
          tip:
              "이건 팁내용이에요 아주아주 길어요 아주아주 길다구요 엄청길죠? 신기하죠? 너무 길어서 놀랐죠? 저도이건 팁내용이에요 아주아주 길어요 아주아주 길다구요 엄청길죠? 신기하죠? 너무 길어서 놀랐죠? 저도이건 팁내용이에요 아주아주 길어요 아주아주 길다구요 엄청길죠? 신기하죠? 너무 길어서 놀랐죠? 저도이건 팁내용이에요 아주아주 길어요 아주아주 길다구요 엄청길죠? 신기하죠? 너무 길어서 놀랐죠? 저도 놀랐어요",
          isMine: i % 2 == 0));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafforldkey,
      drawer: buildDrawer(context),
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        "꿀팁저장소",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TipStorageWrite()));
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff4FB8F3),
                                Color(0xff9342FA),
                                Color(0xff2400FF)
                              ]),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[500],
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 0.5)
                          ]),
                      child: Icon(
                        Icons.note_add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.only(right: 33, left: 33, bottom: 26),
                child: buildTextField("꿀팁 제목", titleC,
                    autoFocus: false,
                    prefixIcon: Icon(Icons.search), textInput: (String key) {
                  print(key);
                })),
            Expanded(
              child: FutureBuilder(
                  future: getTipList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      tipList = snapshot.data;
                      return Align(
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: itemCount + 1,
                            itemBuilder: (context, index) {
                              if (index == itemCount) {
                                if (index == tipList.length) {
                                  return Padding(
                                    padding: EdgeInsets.all(Consts.padding),
                                    child: makeGradientBtn(
                                        msg: "맨 처음으로",
                                        onPressed: () {
                                          _scrollController.animateTo(
                                              _scrollController
                                                  .position.minScrollExtent,
                                              duration:
                                                  Duration(milliseconds: 200),
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
                                        borderRadius:
                                            BorderRadius.circular(18)),
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
                                return buildItemTip(context, index, tipList);
                              }
                            }),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItemTip(BuildContext context, int index, List<TipVO> list) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TipStorageDetail(index: list[index].index)));
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
                  "${list[index].tip}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
