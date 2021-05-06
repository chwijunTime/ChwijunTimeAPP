import 'package:app_user/model/tag/tag_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/dialog/tag_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TagList extends StatefulWidget {
  String role;

  @override
  _TagListState createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  RetrofitHelper helper;
  List<TagVO> tagList = [];
  List<bool> deleteTag = [];

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
  void initState() {
    super.initState();
    widget.role = User.role;
    initRetrofit();
  }

  _onCheckPressed(int index) {
    setState(() {
      deleteTag[index] = !deleteTag[index];
    });
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
                    "태그(분야)",
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
                    padding: EdgeInsets.only(right: 20, left: 20, bottom: 10),
                    child: makeGradientBtn(
                        msg: "태그 등록 요청",
                        onPressed: () {},
                        mode: 1,
                        icon: Icon(
                          Icons.mail,
                          color: Colors.white,
                        )),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        makeGradientBtn(
                            msg: "태그 등록",
                            onPressed: () async {
                              var res = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) => TagDialog(
                                        mode: "post",
                                      ));
                              if (res!=null && res) {
                                setState(() {
                                  _getTagList();
                                });
                              }
                            },
                            mode: 1,
                            icon: Icon(
                              Icons.note_add,
                              color: Colors.white,
                            )),
                        makeGradientBtn(
                            msg: "선택된 태그 삭제",
                            onPressed: () {
                              _onDeleteTag();
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
              child: FutureBuilder(
                future: _getTagList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    tagList = snapshot.data;
                    for (int i=0; i<tagList.length; i++) {
                      deleteTag.add(false);
                    }
                    return ListView.separated(
                      itemCount: tagList.length,
                      itemBuilder: (context, index) {
                        return buildTag(context, index);
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
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<TagVO>> _getTagList() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print("token: ${token}");
    try {
      var res = await helper.getTagList(token);
      if (res.success) {
        return res.list.reversed.toList();
      } else {
        return null;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Widget buildTag(BuildContext context, int index) {
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: GestureDetector(
        onTap: () async {
          var res = await showDialog(
              context: context,
              builder: (BuildContext context) => TagDialog(
                mode: "modify",
                index: tagList[index].index,
              ));
          print(res);
          if (res!=null && res) {
            setState(() {
              _getTagList();
            });
          }
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                "${tagList[index].name}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            widget.role == User.user
                ? InkWell(
                    onTap: () {},
                    child: Icon(Icons.tag),
                  )
                : InkWell(
                    onTap: () {
                      _onCheckPressed(index);
                    },
                    child: deleteTag[index]
                        ? Icon(
                            Icons.check_box_outlined,
                            color: Colors.red,
                          )
                        : Icon(Icons.check_box_outline_blank),
                  )
          ],
        ),
      ),
    ));
  }

  _onDeleteTag() async {
    List<int> deleteList = [];
    for (int i = 0; i < tagList.length; i++) {
      if (deleteTag[i]) {
        deleteList.add(tagList[i].index);
      }
    }

    if (deleteList.isEmpty) {
      snackBar("삭제할 업체를 선택해주세요.", context);
    } else {
      var res = await showDialog(
          context: context,
          builder: (BuildContext context) => StdDialog(
                msg: "선택된 태그를 삭제하시겠습니까?",
                size: Size(326, 124),
                btnName1: "아니요",
                btnCall1: () {
                  Navigator.pop(context);
                },
                btnName2: "삭제하기",
                btnCall2: () async {
                  final pref = await SharedPreferences.getInstance();
                  var token = pref.getString("accessToken");
                  print("token: ${token}");
                  try {
                    for (int i=0; i<deleteList.length; i++) {
                      var res = await helper.deleteTag(token, deleteList[i]);
                      if (res.success) {
                        print("삭제함: ${res.msg}");
                      } else {
                        print("errorr: ${res.msg}");
                      }
                    }
                    Navigator.pop(context, true);
                  } catch (e) {
                    print(e);
                  }
                },
              ),
          barrierDismissible: false);
      if (res!=null && res) {
        setState(() {
          _getTagList();
        });
      }
    }
  }
}
