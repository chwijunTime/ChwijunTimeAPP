import 'package:app_user/consts.dart';
import 'package:app_user/model/consulting/consulting_admin_vo.dart';
import 'package:app_user/model/consulting/consulting_user_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/write_page/counseling_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/counseling_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/drop_down_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CounselingManage extends StatefulWidget {
  @override
  _CounselingManageState createState() => _CounselingManageState();
}

class _CounselingManageState extends State<CounselingManage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  RetrofitHelper helper;

  PanelController panelController = PanelController();
  final _scrollController = ScrollController();
  final titleC = TextEditingController();

  List<ConsultingAdminVO> counAdminList = [];
  List<ConsultingUserVO> counUserList = [];
  List<String> tagList = [];
  int itemCount = Consts.showItemCount;
  List<String> valueList = ['상담 정보', '상담 신청내역'];
  String selectValue = "상담 정보";

  Future<List<ConsultingAdminVO>> getCounselingAdminList() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print("token: ${token}");
    try {
      var res = await helper.getConsultingAdminList(token);
      print("res.success: ${res.success}");
      if (res.success) {
        return res.list;
      } else {
        return null;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Future<List<ConsultingUserVO>> getCounselingUserList() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print("token: ${token}");
    try {
      var res = await helper.getConsultingUserList(token);
      print("res.success: ${res.success}");
      if (res.success) {
        return res.list;
      } else {
        return null;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    initRetrofit();
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
        if (selectValue == valueList[0]) {
          if (itemCount != counAdminList.length) {
            if ((counAdminList.length - itemCount) ~/ Consts.showItemCount <=
                0) {
              itemCount = counAdminList.length;
            } else {
              itemCount += Consts.showItemCount;
            }
          }
        } else {
          if (itemCount != counUserList.length) {
            if ((counUserList.length - itemCount) ~/ Consts.showItemCount <=
                0) {
              itemCount = counUserList.length;
            } else {
              itemCount += Consts.showItemCount;
            }
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
      key: scaffoldKey,
      appBar: buildAppBar("취준타임", context),
      drawer: buildDrawer(context),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  makeGradientBtn(
                      msg: "상담 등록하기",
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CounselingWrite()));
                        setState(() {
                          getCounselingAdminList();
                          _scrollController.animateTo(
                              _scrollController.position.minScrollExtent,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.elasticOut);
                        });
                      },
                      mode: 1,
                      icon: Icon(
                        Icons.note_add,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            makeDropDownBtn(
                valueList: valueList,
                selectedValue: selectValue,
                onSetState: (value) {
                  selectValue = value;
                  setState(() {
                    if (selectValue == valueList[1]) {
                      itemCount = 0;
                      counUserList.clear();
                    } else {
                      itemCount = Consts.showItemCount;
                    }
                  });
                },
                hint: "보기"),
            SizedBox(
              height: 10,
            ),
            selectValue == valueList[0]
                ? Expanded(
                    child: FutureBuilder(
                    future: getCounselingAdminList(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        counAdminList = snapshot.data;
                        if (counAdminList.length <= Consts.showItemCount) {
                          itemCount = counAdminList.length;
                        }
                        print(counAdminList.length);
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: itemCount + 1,
                          itemBuilder: (context, index) {
                            print(
                                "index: $index, counAdminList.length: ${counAdminList.length}, itemCount: $itemCount");
                            if (index == itemCount) {
                              if (counAdminList.length == 0) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  elevation: 5,
                                  margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                                  child: Center(
                                    child: Padding(
                                        padding: EdgeInsets.all(Consts.padding),
                                        child: Text(
                                          "등록된 상담이 없습니다.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        )),
                                  ),
                                );
                              } else if (index == counAdminList.length) {
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
                  ))
                : Expanded(
                    child: FutureBuilder(
                    future: getCounselingUserList(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        counUserList = snapshot.data;
                        if (counUserList.length <= Consts.showItemCount) {
                          itemCount = counUserList.length;
                        }
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: itemCount + 1,
                          itemBuilder: (context, index) {
                            if (index == itemCount) {
                              if (counUserList.length == 0) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  elevation: 5,
                                  margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                                  child: Center(
                                    child: Padding(
                                        padding: EdgeInsets.all(Consts.padding),
                                        child: Text(
                                          "상담 신청이 없습니다.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        )),
                                  ),
                                );
                              } else if (index == counUserList.length) {
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
                              return buildCounselingUser(context, index);
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
    var tempDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(counAdminList[index].applyDate);
    var strDate = DateFormat("yyyy년 MM월 dd일 HH시 mm분").format(tempDate);
    return InkWell(
      onTap: () async {
        var res = await showDialog(
            context: context,
            builder: (BuildContext context) =>
                CounselingDialog(index: counAdminList[index].index));
        if (res != null && res == "delete") {
          print("하이");
          setState(() {
            itemCount--;
          });
        }
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
                  child: Text(
                    strDate,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                makeTag(counAdminList[index].status)
              ],
            ),
          )),
    );
  }

  Widget makeTag(String str) {
    String msg;
    Color color;

    if (str == "No_Application") {
      msg = "진행중";
      color = Color(0xff5BC7F5);
    } else {
      msg = "마감";
      color = Color(0xffFF7777);
    }

    return Container(
      width: 48,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: Border.all(color: color)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2, top: 2),
        child: Text(
          msg,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: color),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildCounselingUser(BuildContext context, int index) {
    var tempDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(counUserList[index].applyDate);
    var strDate = DateFormat("yyyy년 MM월 dd일 HH시 mm분").format(tempDate);
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18))),
        elevation: 5,
        margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                strDate,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${counUserList[index].classNumber} ${counUserList[index].name}님의 신청",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ));
  }
}
