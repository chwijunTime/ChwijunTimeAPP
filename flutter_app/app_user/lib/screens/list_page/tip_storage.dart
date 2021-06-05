import 'package:app_user/consts.dart';
import 'package:app_user/model/tip/tip_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/detail_page/tip_storage_detail.dart';
import 'package:app_user/screens/write_page/tip_storage_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/drop_down_button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TipStoragePage extends StatefulWidget {
  @override
  _TipStoragePageState createState() => _TipStoragePageState();
}

class _TipStoragePageState extends State<TipStoragePage> {
  final scafforldkey = GlobalKey<ScaffoldState>();
  RetrofitHelper helper;
  final _scrollController = ScrollController();

  List<TipVO> tipList = [];
  List<TipVO> searchTipList = [];
  final titleC = TextEditingController();
  int itemCount = Consts.showItemCount;
  List<String> valueList = ['전체보기', '검색하기'];
  String selectValue = "전체보기";
  String msg = "등록된 꿀팁이 없습니다.";

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

  Future<List<TipVO>> _getTipList() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print(token);
    try {
      var res = await helper.getTipList(token);
      if (res.success) {
        return res.list;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                makeDropDownBtn(
                    valueList: valueList,
                    selectedValue: selectValue,
                    onSetState: (value) {
                      setState(() {
                        selectValue = value;
                        itemCount = 0;
                        if (selectValue == valueList[1]) {
                          searchTipList.clear();
                          msg = "회사명으로 검색하기";
                        } else {
                          titleC.text = "";
                        }
                      });
                    },
                    hint: "보기"),
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: FloatingActionButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TipStorageWrite()));
                      setState(() {
                        _getTipList();
                      });
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
            selectValue == valueList[1]
                ? Padding(
                    padding: EdgeInsets.only(
                        right: 33, left: 33, bottom: 15, top: 15),
                    child: buildTextField("업체명", titleC,
                        autoFocus: false, prefixIcon: Icon(Icons.search),
                        textInput: (String key) async {
                      final pref = await SharedPreferences.getInstance();
                      var token = pref.getString("accessToken");
                      print("key: $key");
                      print(token);
                      try {
                        var res = await helper.getTipListKeyword(token, key);
                        print(res.toJson());
                        if (res.success)
                          setState(() {
                            searchTipList = res.list;
                            if (searchTipList.length <= Consts.showItemCount) {
                              itemCount = searchTipList.length;
                              print(searchTipList.length);
                              msg = "검색된 리뷰가 없습니다.";
                            }
                          });
                      } catch (e) {
                        print("error: $e");
                      }
                    }))
                : SizedBox(),
            selectValue == valueList[1]
                ? Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: itemCount + 1,
                        itemBuilder: (context, index) {
                          if (index == itemCount) {
                            if (searchTipList.length == 0) {
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      )),
                                ),
                              );
                            } else if (index == searchTipList.length) {
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
                            return buildItemTip(context, index, searchTipList);
                          }
                        }),
                  )
                : Expanded(
                    child: FutureBuilder(
                        future: _getTipList(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            tipList = snapshot.data;
                            if (tipList.length <= Consts.showItemCount) {
                              itemCount = tipList.length;
                            }
                            return Align(
                              child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: itemCount + 1,
                                  itemBuilder: (context, index) {
                                    if (index == itemCount) {
                                      if (tipList.length == 0) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18)),
                                          elevation: 5,
                                          margin: EdgeInsets.fromLTRB(
                                              25, 13, 25, 13),
                                          child: Center(
                                            child: Padding(
                                                padding: EdgeInsets.all(
                                                    Consts.padding),
                                                child: Text(
                                                  msg,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )),
                                          ),
                                        );
                                      } else if (index == tipList.length) {
                                        return Padding(
                                          padding:
                                              EdgeInsets.all(Consts.padding),
                                          child: makeGradientBtn(
                                              msg: "맨 처음으로",
                                              onPressed: () {
                                                _scrollController.animateTo(
                                                    _scrollController.position
                                                        .minScrollExtent,
                                                    duration: Duration(
                                                        milliseconds: 200),
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
                                          margin: EdgeInsets.fromLTRB(
                                              25, 13, 25, 13),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  Consts.padding),
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        );
                                      }
                                    } else {
                                      return buildItemTip(
                                          context, index, tipList);
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
      child: InkWell(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TipStorageDetail(index: list[index].index)));
          setState(() {
            _getTipList();
          });
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
                  "${list[index].tipInfo}",
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
