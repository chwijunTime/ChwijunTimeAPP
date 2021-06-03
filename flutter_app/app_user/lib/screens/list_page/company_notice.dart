import 'package:app_user/consts.dart';
import 'package:app_user/model/comp_notice/comp_notice_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/detail_page/company_notice_detail.dart';
import 'package:app_user/screens/list_page/company_notice_apply.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/write_page/company_notice_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/drop_down_button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyNoticePage extends StatefulWidget {
  @override
  _CompanyNoticePageState createState() => _CompanyNoticePageState();

  String role;
}

class _CompanyNoticePageState extends State<CompanyNoticePage> {
  final scafforldkey = GlobalKey<ScaffoldState>();

  List<CompNoticeVO> noticeList = [];
  List<CompNoticeVO> searchNoticeList = [];
  final titleC = TextEditingController();
  final _scrollController = ScrollController();
  List<bool> deleteNoti = [];
  int itemCount = Consts.showItemCount;
  List<String> valueList = ['전체보기', '검색하기'];
  String selectValue = "전체보기";
  String msg = "등록된 취업공고가 없습니다.";

  RetrofitHelper helper;

  @override
  void initState() {
    super.initState();
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
        if (itemCount != noticeList.length) {
          if ((noticeList.length - itemCount) ~/ Consts.showItemCount <= 0) {
            itemCount += noticeList.length % Consts.showItemCount;
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

  _onCheckPressed(int index) {
    setState(() {
      deleteNoti[index] = !deleteNoti[index];
    });
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
                        "취업 공고",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      )
                    ],
                  ),
                  makeDropDownBtn(
                      valueList: valueList,
                      selectedValue: selectValue,
                      onSetState: (value) {
                        setState(() {
                          selectValue = value;
                          if (selectValue == valueList[1]) {
                            itemCount = 0;
                            searchNoticeList.clear();
                            msg = "이름, 지역, 직군으로 검색하기";
                          } else {
                            titleC.text = "";
                            msg = "등록된 취업공고가 없습니다.";
                          }
                        });
                      },
                      hint: "보기"),
                ],
              ),
            ),
            User.role == User.user
                ? SizedBox()
                : Padding(
                    padding:
                        const EdgeInsets.only(right: 26, left: 26, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            makeGradientBtn(
                                msg: "취업 공고 등록",
                                onPressed: () async {
                                  print("등록하자");
                                  var res = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CompanyNoticeWritePage()));
                                  if (res != null && res) {
                                    setState(() {
                                      _getCompany();
                                    });
                                  }
                                },
                                mode: 1,
                                icon: Icon(
                                  Icons.note_add,
                                  color: Colors.white,
                                )),
                            makeGradientBtn(
                                msg: "선택된 공고 삭제",
                                onPressed: () {
                                  _onDeleteCompNotice();
                                },
                                mode: 1,
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        makeGradientBtn(
                            msg: "취업 공고 신청 목록 보기", onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyNoticeApply()));
                        }, mode: 6, icon: Icon(Icons.search, color: Colors.white,))
                      ],
                    ),
                  ),
            selectValue == valueList[1]
                ? Padding(
                    padding: EdgeInsets.only(
                        right: 33, left: 33, bottom: 15, top: 15),
                    child: buildTextField("이름, 지역, 직군", titleC,
                        autoFocus: false, prefixIcon: Icon(Icons.search),
                        textInput: (String key) async {
                      final pref = await SharedPreferences.getInstance();
                      var token = pref.getString("accessToken");
                      var res = await helper.getCompListKeyword(token, key);
                      if (res.success)
                        setState(() {
                          searchNoticeList = res.list;
                          if (searchNoticeList.length <= Consts.showItemCount) {
                            itemCount = searchNoticeList.length;
                            print(searchNoticeList.length);
                            msg = "검색된 취업공고가 없습니다.";
                          }
                        });
                    }))
                : SizedBox(),
            selectValue == valueList[1]
                ? Expanded(
                    child: ListView.builder(
                    controller: _scrollController,
                    itemCount: itemCount + 1,
                    itemBuilder: (context, index) {
                      print("index: $index");
                      if (index == itemCount) {
                        if (searchNoticeList.length == 0) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            elevation: 5,
                            margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                            child: Center(
                              child: Padding(
                                  padding: EdgeInsets.all(Consts.padding),
                                  child: Text(
                                    msg,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  )),
                            ),
                          );
                        } else if (index == searchNoticeList.length) {
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
                        return buildItemCompany(
                            context, index, searchNoticeList);
                      }
                    },
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                  ))
                : Expanded(
                    child: FutureBuilder(
                        future: _getCompany(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            noticeList = snapshot.data;
                            for (int i = 0; i < noticeList.length; i++) {
                              deleteNoti.add(false);
                            }
                            if (noticeList.length <= Consts.showItemCount) {
                              itemCount = noticeList.length;
                            }
                            return ListView.builder(
                              controller: _scrollController,
                              itemCount: itemCount + 1,
                              itemBuilder: (context, index) {
                                if (index == itemCount) {
                                  if (noticeList.length == 0) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      elevation: 5,
                                      margin:
                                          EdgeInsets.fromLTRB(25, 13, 25, 13),
                                      child: Center(
                                        child: Padding(
                                            padding:
                                                EdgeInsets.all(Consts.padding),
                                            child: Text(
                                              msg,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            )),
                                      ),
                                    );
                                  } else if (index == noticeList.length) {
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
                                      margin:
                                          EdgeInsets.fromLTRB(25, 13, 25, 13),
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(Consts.padding),
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return buildItemCompany(
                                      context, index, noticeList);
                                }
                              },
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                            );
                          }
                        }),
                  )
          ],
        ),
      ),
    );
  }

  Future<List<CompNoticeVO>> _getCompany() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print("token: ${token}");
    try {
      var res = await helper.getCompList(token);
      print("res.success: ${res.success}");
      if (res.success) {
        return res.list.toList();
      } else {
        return null;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  _onDeleteCompNotice() async {
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
                      final res = await helper.deleteComp(token, arr[i]);
                      if (res.success) {
                        print("삭제함: ${res.msg}");
                      } else {
                        print("errorr: ${res.msg}");
                        if (res.msg == "작성자의 권한이 필요합니다.") {
                          snackBar("작성자의 권한이 필요한 취업공고가 존재합니다.", context);
                        } else {
                          snackBar(res.msg, context);
                        }
                        Navigator.pop(context);
                        return null;
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
          _getCompany();
          deleteNoti.clear();
        });
      }
    }
  }

  Widget buildItemCompany(
      BuildContext context, int index, List<CompNoticeVO> list) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CompanyNoticeDetailPage(
                        index: list[index].index,
                      )));
          setState(() {
            _getCompany();
            selectValue = valueList[0];
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
                  User.role == User.user
                      ? SizedBox()
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
                          onPressed: () => _onCheckPressed(index)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Container(
                  height: 60,
                  child: AutoSizeText(
                    "${list[index].info}, ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    minFontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 22,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: List.generate(
                          list[index].tag.length < 2 ? 1 : 2, (indextag) {
                        return buildItemTag(list[index].tag, indextag);
                      }),
                    ),
                    list[index].tag.length < 3
                        ? SizedBox()
                        : Container(
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
                          ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "마감일: ${list[index].deadLine}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
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
}
