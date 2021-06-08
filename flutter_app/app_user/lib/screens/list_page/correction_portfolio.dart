import 'package:app_user/consts.dart';
import 'package:app_user/model/correction/correction_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/correction_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CorrectionPortfolioPage extends StatefulWidget {
  @override
  _CorrectionPortfolioPageState createState() => _CorrectionPortfolioPageState();
}

class _CorrectionPortfolioPageState extends State<CorrectionPortfolioPage> {
  RetrofitHelper helper;
  List<CorrectionVO> correctionList = [];
  final _scrollController = ScrollController();
  int itemCount = Consts.showItemCount;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    initRetrofit();
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
        if (itemCount != correctionList.length) {
          if ((correctionList.length - itemCount) ~/ Consts.showItemCount <=
              0) {
            itemCount = correctionList.length;
          } else {
            itemCount += Consts.showItemCount;
          }
        }
      });
    }
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
                  Text(
                    "포트폴리오 첨삭 요청",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: _getCorrection(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  correctionList = snapshot.data;
                  if (correctionList.length <= Consts.showItemCount) {
                    itemCount = correctionList.length;
                  }
                  return ListView.separated(
                    controller: _scrollController,
                    itemCount: itemCount + 1,
                    itemBuilder: (context, index) {
                      if (index == itemCount) {
                        if (correctionList.length == 0) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            elevation: 5,
                            margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                            child: Center(
                              child: Padding(
                                  padding: EdgeInsets.all(Consts.padding),
                                  child: Text(
                                    "등록된 요청이 없습니다.",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  )),
                            ),
                          );
                        } else if (index == correctionList.length) {
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
                        return buildPortfolioCorrection(context, index);
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
              },
            ))
          ],
        ),
      ),
    );
  }

  Future<List<CorrectionVO>> _getCorrection() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    try {
      var res = await helper.getCorrectionList(token);
      if (res.success) {
        List<CorrectionVO> list = [];
        for (int i=0; i< res.list.length; i++) {
          if (res.list[i].type == "Portfolio") {
            list.add(res.list[i]);
          }
        }
        return list;
      }
    } catch (e) {
      print("err: $e");
    }
  }

  Widget buildPortfolioCorrection(BuildContext context, int index) {
    CorrectionVO vo = correctionList[index];
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: InkWell(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (BuildContext context) =>
                  CorrectionDialog(index: vo.index,));
          setState(() {
            _getCorrection();
          });
          },
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                      "${vo.member.classNumber}_포트폴리오", style: TextStyle(fontWeight: FontWeight.w600),)),
              makeTag(vo.status)
            ],
          ),
        ),
      ),
    ));
  }

  Widget makeTag(String str) {
    String msg;
    Color color;

    if (str == "Correction_Applying") {
      msg = "대기중";
      color = Colors.grey;
    } else if (str == "Correction_Successful") {
      msg = "완료함";
      color = Color(0xff5BC7F5);
    } else {
      msg = "거절함";
      color = Color(0xffFF7777);
    }

    return Container(
      width: 48,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.all(Radius.circular(40)),
          border: Border.all(color: color)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2, top: 2),
        child: Text(
          msg,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
