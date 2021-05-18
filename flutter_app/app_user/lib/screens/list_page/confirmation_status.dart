import 'package:app_user/consts.dart';
import 'package:app_user/model/confirmation/confirmation_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/detail_page/confirmation_status_detail.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/write_page/confirmation_status_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationStatusPage extends StatefulWidget {
  String role;

  @override
  _ConfirmationStatusPageState createState() => _ConfirmationStatusPageState();
}

class _ConfirmationStatusPageState extends State<ConfirmationStatusPage> {
  final scafforldkey = GlobalKey<ScaffoldState>();
  RetrofitHelper helper;

  final _scrollController = ScrollController();
  final titleC = TextEditingController();
  int itemCount = Consts.showItemCount;

  List<ConfirmationVO> confList = [];
  List<bool> checkList = [];

  _onCheckPressed(int index) {
    setState(() {
      checkList[index] = !checkList[index];
    });
  }

  @override
  void initState() {
    super.initState();
    widget.role = User.role;
    _scrollController.addListener(_scrollListener);
    initRetrofit();
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
        if (itemCount != confList.length) {
          if ((confList.length - itemCount) ~/ Consts.showItemCount <= 0) {
            itemCount += confList.length % Consts.showItemCount;
          } else {
            itemCount += Consts.showItemCount;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafforldkey,
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
                    "취업확정 현황",
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
                    child: buildTextField("회사 이름, 기수, 지역", titleC,
                        autoFocus: false,
                        prefixIcon: Icon(Icons.search), textInput: (String key) {
                      print(key);
                    }))
                : Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        makeGradientBtn(
                            msg: "취업 현황 등록",
                            onPressed: () async {
                              print("등록하자");
                              var res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ConfirmationStatusWrite()));
                              if (res != null && res) {
                                _getComfirmation();
                              }
                            },
                            mode: 1,
                            icon: Icon(
                              Icons.note_add,
                              color: Colors.white,
                            )),
                        makeGradientBtn(
                            msg: "선택된 현황 삭제",
                            onPressed: () {
                              _onDeleteConfirmation();
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
                  future: _getComfirmation(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      confList = snapshot.data;
                      for (int i = 0; i < confList.length; i++) {
                        checkList.add(false);
                      }
                      return ListView.separated(
                        controller: _scrollController,
                        itemCount: itemCount + 1,
                        itemBuilder: (context, index) {
                          if (index == itemCount) {
                            if (index == confList.length) {
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
                            return buildState(context, index);
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
                        physics: ScrollPhysics(),
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

  Future<List<ConfirmationVO>> _getComfirmation() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print(token);
    try {
      var res = await helper.getConfList(token);
      if (res.success) {
        return res.list.reversed.toList();
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  _onDeleteConfirmation() async {
    List<int> arr = [];
    for (int i = 0; i < confList.length; i++) {
      if (checkList[i]) {
        arr.add(confList[i].index);
      }
    }

    if (arr.isEmpty) {
      snackBar("삭제할 업체를 선택해주세요.", context);
    } else {
      var res = await showDialog(
          context: context,
          builder: (BuildContext context) => StdDialog(
                msg: "선택된 취업현황을 삭제하시겠습니까?",
                size: Size(326, 124),
                btnName1: "아니요",
                btnCall1: () {
                  Navigator.pop(context, false);
                },
                btnName2: "삭제하기",
                btnCall2: () async {
                  final pref = await SharedPreferences.getInstance();
                  var token = pref.getString("accessToken");
                  try {
                    for (int i = 0; i < arr.length; i++) {
                      final res = await helper.deleteConf(token, arr[i]);
                      if (res.success) {
                        Navigator.pop(context, true);
                        print(res.toJson());
                      } else {
                        print("error: ${res.msg}");
                      }
                    }
                  } catch (e) {
                    print("err: ${e}");
                    Navigator.pop(context, false);
                    snackBar("이미 삭제된 취업현황입니다.", context);
                  }
                },
              ),
          barrierDismissible: false);
      if (res != null && res) {
        setState(() {
          _getComfirmation();
          checkList.clear();
        });
      }
    }
  }

  Widget buildState(BuildContext context, int index) {
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ConfirmationStatusDetail(
                        index: confList[index].index,
                      )));
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                "${confList[index].title}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              "${confList[index].area}",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
            SizedBox(
              width: 10,
            ),
            widget.role == User.user
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmationStatusDetail(
                                    index: confList[index].index,
                                  )));
                    },
                    child: Icon(Icons.arrow_forward_ios_rounded),
                  )
                : InkWell(
                    onTap: () {
                      _onCheckPressed(index);
                    },
                    child: checkList[index]
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
}
