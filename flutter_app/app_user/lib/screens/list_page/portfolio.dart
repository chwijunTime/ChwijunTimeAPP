import 'package:app_user/consts.dart';
import 'package:app_user/model/correction/correction_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
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
            itemCount += correctionList.length % Consts.showItemCount;
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
                if (snapshot.data) {
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
                        return buildPortfolio(context, index);
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
        return res.list;
      }
    } catch (e) {
      print("err: $e");
    }
  }

  Widget buildPortfolio(BuildContext context, int index) {
    CorrectionVO vo = correctionList[index];
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                      "${vo.member.classNumber}${vo.type == "portfolio" ? "포트폴리오" : "이력서"}")),
              vo.status == "Wait"
                  ? Container(
                      width: 48,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          "대기중",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : vo.status == "Approve"
                      ? Container(
                          width: 48,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              border: Border.all(color: Color(0xff4687ff))),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              "수락함",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff4687ff)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Container(
                          width: 48,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              border: Border.all(color: Color(0xffFF7777))),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              "거절함",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffFF7777)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    ));
  }
}
