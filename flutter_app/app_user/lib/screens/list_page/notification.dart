import 'package:app_user/model/notice/notification_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/write_page/notification_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/notification_dialog.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
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
  List<bool> deleteNoti = [];
  final titleC = TextEditingController();
  String _searchText = "";
  bool _IsSearching;

  RetrofitHelper helper;

  @override
  void initState() {
    super.initState();
    initRetrofit();
    widget.role = User.role;
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

  _onHeartPressed(int index) {
    setState(() {
      deleteNoti[index] = !deleteNoti[index];
    });
  }

  initRetrofit() {
    Dio dio = Dio(BaseOptions(
        connectTimeout: 5 * 1000,
        receiveTimeout: 5 * 1000,
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        }));
    helper = RetrofitHelper(dio);
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
            widget.role == User.user
                ? Padding(
                    padding: EdgeInsets.only(right: 33, left: 33, bottom: 26),
                    child: buildTextField("공지사항 제목", titleC, autoFocus: false))
                : Padding(
                    padding:
                        const EdgeInsets.only(right: 26, left: 26, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        makeGradientBtn(
                            msg: "공지사항 등록",
                            onPressed: () async {
                              print("등록하자");
                              final res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationWrite()));
                              if (res != null) {
                                if (res) {
                                  setState(() {
                                    _getNotice();
                                  });
                                }
                              }
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
                    : FutureBuilder(
                        future: _getNotice(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var result = snapshot.data as List<NotificationVO>;
                            noticeList = result;
                            for (int i = 0; i < noticeList.length; i++) {
                              deleteNoti.add(false);
                            }
                            return ListView.builder(
                                itemCount: noticeList.length,
                                itemBuilder: (context, index) {
                                  return buildItemNotification(
                                      context, index, noticeList);
                                });
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<NotificationVO>> _getNotice() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print(token);
    var res = await helper.getNoticeList(token);
    print("res.success: ${res.success}");
    if (res.success) {
      return res.list.reversed.toList();
    } else {
      return null;
    }
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
    DateTime dt = DateTime.parse(list[index].date);
    String strDate = "${dt.year}.${dt.month}.${dt.day}";
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
      child: GestureDetector(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (BuildContext context) => NotificationDialog(
                    index: noticeList[index].index,
                    size: Size(346, 502),
                    role: widget.role,
                  ));

          setState(() {
            _getNotice();
          });
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
                  widget.role == User.user
                      ? IconButton(
                          icon: deleteNoti[index]
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
                        )
                      : IconButton(
                          icon: deleteNoti[index]
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
                child: Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "등록일: ${strDate}",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onDeleteNoti() async {
    List<int> arr = [];
    for (int i = 0; i < noticeList.length; i++) {
      if (deleteNoti[i]) {
        arr.add(noticeList[i].index);
      }
    }

    if (arr.isEmpty) {
      snackBar("삭제할 업체를 선택해주세요.", context);
    } else {
      var res = await showDialog(
          context: context,
          builder: (BuildContext context) => StdDialog(
                msg: "선택된 공지사항을 삭제하시겠습니까?",
                size: Size(326, 124),
                btnName1: "아니요",
                btnCall1: () {
                  Navigator.pop(context, false);
                },
                btnName2: "삭제하기",
                btnCall2: () async {
                  print("삭제할 업체들================================");
                  final pref = await SharedPreferences.getInstance();
                  var token = pref.getString("accessToken");
                  try {
                    for (int i = 0; i < arr.length; i++) {
                      final res = await helper.deleteNotice(
                          token: token, index: arr[i]);
                      if (res.success) {
                        print("삭제함: ${res.msg}");
                      } else {
                        print("errorr: ${res.msg}");
                      }
                    }
                    Navigator.pop(context, true);
                  } catch (e) {
                    print("err: ${e}");
                    Navigator.pop(context, false);
                    snackBar("이미 삭제된 공지입니다.", context);
                  }
                },
              ),
          barrierDismissible: false);
      if (res != null && res) {
        setState(() {
          _getNotice();
          deleteNoti.clear();
        });
      }
    }
  }
}
