import 'package:app_user/model/resume_portfolio/portfolio_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/show_web_view.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/dialog/edit_dialog.dart';
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

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                "포트폴리오",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
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
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return buildPortfolio(context, index);
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 1,
                            color: Colors.grey,
                          );
                        },
                        itemCount: portList.length);
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
      ),
    );
  }

  Future<List<PortfolioVO>> _getPortpolio() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
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
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            Expanded(
              child: Text(
                "포트폴리오 ${portList[index].index + 1}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => StdDialog(
                          msg: "포트폴리오${portList[index].index + 1} 첨삭 요청하기",
                          size: Size(326, 124),
                          icon: Icon(
                            Icons.outgoing_mail,
                            color: Color(0xff4687ff),
                          ),
                          btnName2: "요청하기",
                          btnCall2: _postRequest(index),
                          btnIcon2: Icon(
                            Icons.outgoing_mail,
                            color: Colors.white,
                          ),
                        ));
              },
              child: Icon(Icons.mail),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShowWebView(url: portList[index].portfolioUrl)));
                },
                icon: Icon(Icons.search)),
            SizedBox(
              width: 10,
            ),
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
            SizedBox(
              width: 10,
            ),
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
    try {
      var res = await helper.postCorrectionRequest(
          token, "portfolio", portList[index].index);
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
