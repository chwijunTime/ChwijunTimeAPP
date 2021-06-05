import 'package:app_user/consts.dart';
import 'package:app_user/model/tag/tag_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/list_page/req_tag_list.dart';
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

  int itemCount = Consts.showItemCount;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.role = User.role;
    initRetrofit();
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
        if (itemCount != tagList.length) {
          print("hihi: ${itemCount}, tagList.length: ${tagList.length}");
          if ((tagList.length - itemCount) ~/ Consts.showItemCount <= 0) {
            itemCount += tagList.length % Consts.showItemCount;
            print("여기다!");
          } else {
            itemCount += Consts.showItemCount;
            print("여기야");
          }
        }
      });
    }
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
              padding: EdgeInsets.all(20),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "태그(분야)",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                      makeGradientBtn(
                          msg: "요청 태그 보기",
                          onPressed: () async {
                            await Navigator.push(context, MaterialPageRoute(builder: (context) => ReqTagList()));
                            setState(() {
                              _getTagList();
                            });
                          },
                          mode: 1,
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
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
                        if (res != null && res) {
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
                      for (int i = 0; i < tagList.length; i++) {
                        deleteTag.add(false);
                      }
                      if (tagList.length <= Consts.showItemCount) {
                        itemCount = tagList.length;
                      }
                      return ListView.separated(
                        controller: _scrollController,
                        itemCount: itemCount + 1,
                        itemBuilder: (context, index) {
                          print("index: $index, itemCount: $itemCount, tagList.length: ${tagList.length}");
                          if (index == itemCount) {
                            if (index == 0) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                elevation: 5,
                                margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                                child: Center(
                                  child: Padding(
                                      padding: EdgeInsets.all(Consts.padding),
                                      child: Text(
                                        "등록된 태그가 없습니다.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      )),
                                ),
                              );
                            } else if (index == tagList.length) {
                              return Padding(
                                padding: EdgeInsets.all(20),
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
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          } else {
                            return buildTag(context, index);
                          }
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
                  }),
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
          if (res != null && res) {
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
                    for (int i = 0; i < deleteList.length; i++) {
                      var res = await helper.deleteTag(token, deleteList[i]);
                      if (res.success) {
                        print("삭제함: ${res.msg}");
                        itemCount --;
                        deleteTag.clear();
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
      if (res != null && res) {
        setState(() {
          _getTagList();
        });
      }
    }
  }
}
