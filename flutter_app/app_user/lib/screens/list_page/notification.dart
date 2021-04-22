import 'package:app_user/model/notification_vo.dart';
import 'package:app_user/screens/detail_page/interview_review_detail.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/write_page/interview_review_write.dart';
import 'package:app_user/screens/write_page/notification_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/notification_dialog.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  String role;

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final scafforldkey = GlobalKey<ScaffoldState>();

  List<NotificationVO> noticeList = [];
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
    loadShaPref();
  }

  loadShaPref() async {
    var role = await getRole();
    setState(() {
      widget.role = role;
    });
  }

  Future<String> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    var role = prefs.getString("role") ?? "user";
    print("role: ${role}");
    return role;
  }

  _onHeartPressed(int index) {
    setState(() {
      noticeList[index].isFavorite = !noticeList[index].isFavorite;
    });
  }

  void _listSetting() {
    for (int i = 1; i <= 8; i++) {
      noticeList.add(NotificationVO(
          isFavorite: false,
          title: i%2 == 0 ? "${i}.title": "${i}.abct",
          content:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          date: "2021.03.19",
          tag: List.generate(8, (index) => "${index}태그")));
    }
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
                    "공지사항",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            widget.role == "user"
                ? Padding(
                padding: EdgeInsets.only(right: 33, left: 33, bottom: 26),
                child: buildTextField("공지사항 제목", titleC, autoFocus: false))
                : Padding(
              padding: const EdgeInsets.only(
                  right: 26, left: 26, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  makeGradientBtn(
                      msg: "공지사항 등록",
                      onPressed: () {
                        print("등록하자");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NotificationWrite()));
                      },
                      mode: 1,
                      icon: Icon(
                        Icons.note_add,
                        color: Colors.white,
                      )),
                  makeGradientBtn(
                      msg: "선택된 공지 삭제",
                      onPressed: () {
                        _onDeleteNoti();
                      },
                      mode: 1,
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Expanded(
              child: Align(
                child: _IsSearching
                    ? buildSearchList()
                    : ListView.builder(
                        itemCount: noticeList.length,
                        itemBuilder: (context, index) {
                          return buildItemNotification(
                              context, index, noticeList);
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
          itemCount: noticeList.length,
          itemBuilder: (context, index) {
            return buildItemNotification(context, index, noticeList);
          });
    } else {
      List<NotificationVO> _searchList = [];
      for (int i = 0; i < noticeList.length; i++) {
        String name = noticeList[i].title;
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(noticeList[i]);
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
      BuildContext context, int index, List<NotificationVO> list) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => NotificationDialog(
                list: list[index],
                size: Size(346, 502),
              ));
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${list[index].title}",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                  ),
                  widget.role == "user" ?
                  IconButton(
                    icon: list[index].isFavorite
                        ? Icon(
                            Icons.favorite,
                            size: 28,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            size: 28,
                          ),
                    onPressed: () => _onHeartPressed(index),
                  ): IconButton(
                      icon: list[index].isFavorite
                          ? Icon(
                        Icons.check_box_outlined,
                        size: 28,
                        color: Colors.red,
                      )
                          : Icon(
                        Icons.check_box_outline_blank,
                        size: 28,
                      ),
                      onPressed: () => _onHeartPressed(index)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Text(
                  "${list[index].content}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
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
                    list[index].tag.length-2 !=0 ? Container(
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
                    ): SizedBox(),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "등록일: ${list[index].date}",
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

  _onDeleteNoti() {
    List<NotificationVO> deleteNoti = [];
    for (int i = 0; i < noticeList.length; i++) {
      if (noticeList[i].isFavorite) {
        deleteNoti.add(noticeList[i]);
      }
    }

    if(deleteNoti.isEmpty) {
      snackBar("삭제할 업체를 선택해주세요.", context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => StdDialog(
            msg: "선택된 공지사항을 삭제하시겠습니까?",
            size: Size(326, 124),
            btnName1: "아니요",
            btnCall1: () {Navigator.pop(context);},
            btnName2: "삭제하기",
            btnCall2: () {
              print("삭제할 업체들================================");
              print(deleteNoti.toString());
              Navigator.pop(context);
            },),
          barrierDismissible: false);
    }
  }
}
