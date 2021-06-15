import 'package:app_user/consts.dart';
import 'package:app_user/model/resume_portfolio/portfolio_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/show_web_view.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/edit_dialog.dart';
import 'package:app_user/widgets/dialog/portfolio_resume_dialog.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  List<PortfolioVO> portList = [];
  RetrofitHelper helper;
  final _scrollController = ScrollController();
  int itemCount = Consts.showItemCount;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    initRetrofit();
  }

  initRetrofit() {
    Dio dio = Dio();
    dio.options = BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 10 * 1000,
        receiveTimeout: 10 * 1000,
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        });
    helper = RetrofitHelper(dio);
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        if (itemCount != portList.length) {
          if ((portList.length - itemCount) ~/ Consts.showItemCount <=
              0) {
            itemCount += portList.length % Consts.showItemCount;
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
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(26.0),
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
                        "포트폴리오",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  makeGradientBtn(
                      msg: "포트폴리오 등록하기",
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                PortfolioResumeDialog(
                                  mode: "portfolio",
                                ));
                        setState(() {
                          _getPortpolio();
                          print("호잇");
                        });
                      },
                      mode: 2,
                      icon: Icon(
                        Icons.note_add,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: FutureBuilder(
              future: _getPortpolio(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  portList = snapshot.data;
                  if (portList.length <= Consts.showItemCount) {
                    itemCount = portList.length;
                  }
                  return ListView.separated(
                    controller: _scrollController,
                    itemCount: itemCount + 1,
                    itemBuilder: (context, index) {
                      if (index == itemCount) {
                        if (portList.length == 0) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            elevation: 5,
                            margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                            child: Center(
                              child: Padding(
                                  padding: EdgeInsets.all(Consts.padding),
                                  child: Text(
                                    "등록된 포트폴리오가 없습니다.",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700),
                                  )),
                            ),
                          );
                        } else if (index == portList.length) {
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

  Future<List<PortfolioVO>> _getPortpolio() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print(token);
    try {
      var res = await helper.getPortfolioList(token);
      if (res.success) {
        return res.list;
      } else {
        return null;
      }
    } catch (e) {
      print("err: $e");
    }
  }

  Widget buildPortfolio(BuildContext context, int index) {
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20,0,20,0),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            Expanded(
              child: Text(
                "포트폴리오 ${portList[index].index}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => StdDialog(
                            msg: "포트폴리오${portList[index].index} 첨삭 요청하기",
                            size: Size(326, 124),
                            icon: Icon(
                              Icons.outgoing_mail,
                              color: Color(0xff4687ff),
                            ),
                            btnName2: "요청하기",
                            btnCall2: (){
                              _postRequest(index);
                            },
                            btnIcon2: Icon(
                              Icons.outgoing_mail,
                              color: Colors.white,
                            ),
                          ));
                },
                icon: Icon(Icons.mail)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShowWebView(url: portList[index].portfolioUrl)));
                },
                icon: Icon(Icons.search)),
            IconButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) => EditDialog(
                            mode: "portfolio",
                            index: portList[index].index,
                          ));
                  setState(() {
                    _getPortpolio();
                  });
                },
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) => StdDialog(
                            msg: "선택한 포트폴리오를 삭제하시겠습니까?",
                            size: Size(326, 124),
                            btnName1: "아니요",
                            btnCall1: () {
                              Navigator.pop(context, false);
                            },
                            btnName2: "삭제하기",
                            btnCall2: () async {
                              final pref =
                                  await SharedPreferences.getInstance();
                              var token = pref.getString("accessToken");
                              try {
                                var res = await helper.deletePortfolio(
                                    token, portList[index].index);
                                if (res.success) {
                                  snackBar("포트폴리오가 삭제되었습니다", context);
                                  Navigator.pop(context, true);
                                } else {
                                  snackBar(res.msg, context);
                                  print("error: ${res.msg}");
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                print("err: ${e}");
                                Navigator.pop(
                                  context,
                                );
                                snackBar("이미 삭제된 포트폴리오 입니다.", context);
                              }
                            },
                          ));
                  setState(() {
                    _getPortpolio();
                  });
                },
                icon: Icon(Icons.delete))
          ],
        ),
      ),
    ));
  }

  _postRequest(int index) async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print(token);
    try {
      var res = await helper.postCorrectionRequest(
          token, "Portfolio", portList[index].index);
      if (res.success) {
        snackBar("첨삭 요청을 완료했습니다", context);
      } else {
        snackBar(res.msg, context);
        print("error: ${res.msg}");
      }
    } catch (e) {
      print("err: $e");
    }
    Navigator.pop(context);
  }
}
