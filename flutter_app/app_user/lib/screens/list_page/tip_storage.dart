import 'package:app_user/model/tip_storage_vo.dart';
import 'package:app_user/screens/write_page/tip_storage_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class TipStoragePage extends StatefulWidget {
  @override
  _TipStoragePageState createState() => _TipStoragePageState();
}

class _TipStoragePageState extends State<TipStoragePage> {
  final scafforldkey = GlobalKey<ScaffoldState>();

  List<TipVO> tipList = [];
  final titleC = TextEditingController();
  String _searchText = "";
  bool _IsSearching;

  @override
  void initState() {
    super.initState();
    _listSetting();
    _IsSearching = false;

    titleC.addListener(() {
      if (titleC.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = titleC.text;
          print("searchtext = $_searchText, searchQuery.text = ${titleC.text}");
        });
      }
    });
  }

  void _listSetting() {
    for (int i = 1; i <= 8; i++) {
      tipList.add(TipVO(
          title: "${i + 1}.업체명",
          address: "광주광역시 광산구 광주소프트웨어마이스터고등학교",
          tip: "이건 팁내용이에요 아주아주 길어요 아주아주 길다구요 엄청길죠? 신기하죠? 너무 길어서 놀랐죠? 저도이건 팁내용이에요 아주아주 길어요 아주아주 길다구요 엄청길죠? 신기하죠? 너무 길어서 놀랐죠? 저도이건 팁내용이에요 아주아주 길어요 아주아주 길다구요 엄청길죠? 신기하죠? 너무 길어서 놀랐죠? 저도이건 팁내용이에요 아주아주 길어요 아주아주 길다구요 엄청길죠? 신기하죠? 너무 길어서 놀랐죠? 저도 놀랐어요"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafforldkey,
      drawer: buildDrawer(context),
      appBar: buildAppBar("취준타임"),
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
                        "면접후기 & 회사후기",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TipStorageWrite()));
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
                child: buildTextField("꿀팁 제목", titleC, autoFocus: false)),
            Expanded(
              child: Align(
                child: _IsSearching
                    ? buildSearchList()
                    : ListView.builder(
                        itemCount: tipList.length,
                        itemBuilder: (context, index) {
                          return buildItemNotification(
                              context, index, tipList);
                        }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSearchList() {
    if (_searchText.isEmpty) {
      return ListView.builder(
          itemCount: tipList.length,
          itemBuilder: (context, index) {
            return buildItemNotification(context, index, tipList);
          });
    } else {
      List<TipVO> _searchList = [];
      for (int i = 0; i < tipList.length; i++) {
        String name = tipList[i].title;
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(tipList[i]);
        }
      }
      return ListView.builder(
          itemCount: _searchList.length,
          itemBuilder: (context, index) {
            return buildItemNotification(context, index, _searchList);
          });
    }
  }

  Widget buildItemNotification(
      BuildContext context, int index, List<TipVO> list) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
      child: GestureDetector(
        onTap: () {
          print("눌림");
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${list[index].title}",
                style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
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
