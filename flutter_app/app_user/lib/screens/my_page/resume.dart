import 'package:app_user/consts.dart';
import 'package:app_user/model/resume_portfolio/resume_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/show_web_view.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/correction_dialog.dart';
import 'package:app_user/widgets/dialog/edit_dialog.dart';
import 'package:app_user/widgets/dialog/portfolio_resume_dialog.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:flutter/material.dart';

class ResumePage extends StatefulWidget {
  @override
  _ResumePageState createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  RetrofitHelper helper;
  List<ResumeVO> resumeList = [];
  final _scrollController = ScrollController();
  int itemCount = Consts.showItemCount;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        if (itemCount != resumeList.length) {
          if ((resumeList.length - itemCount) ~/ Consts.showItemCount <= 0) {
            itemCount += resumeList.length % Consts.showItemCount;
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
              padding: EdgeInsets.all(26),
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
                        "내 이력서",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      )
                    ],
                  ),
                  makeGradientBtn(
                      msg: "이력서 등록하기",
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                PortfolioResumeDialog(
                                  mode: "resume",
                                ));
                        setState(() {
                          _getResume();
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
            Expanded(
                child: FutureBuilder(
              future: _getResume(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  resumeList = snapshot.data;
                  if (resumeList.length <= Consts.showItemCount) {
                    itemCount = resumeList.length;
                  }
                  return ListView.separated(
                    controller: _scrollController,
                    itemCount: itemCount + 1,
                    itemBuilder: (context, index) {
                      if (index == itemCount) {
                        if (resumeList.length == 0) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            elevation: 5,
                            margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                            child: Center(
                              child: Padding(
                                  padding: EdgeInsets.all(Consts.padding),
                                  child: Text(
                                    "등록된 이력서가 없습니다.",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  )),
                            ),
                          );
                        } else if (index == resumeList.length) {
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
                        return buildResumeCorrection(context, index);
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

  Future<List<ResumeVO>> _getResume() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getMyResumeList();
      if (res.success) {
        return res.list;
      } else {
        return null;
      }
    } catch (e) {
      print("err: $e");
    }
  }

  Widget buildResumeCorrection(BuildContext context, int index) {
    ResumeVO vo = resumeList[index];
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: GestureDetector(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (BuildContext context) =>
                  CorrectionDialog(index: vo.index));
          setState(() {
            _getResume();
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "이력서 ${resumeList[index].index}",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => StdDialog(
                              msg: "이력서${resumeList[index].index} 첨삭 요청하기",
                              size: Size(326, 124),
                              icon: Icon(
                                Icons.outgoing_mail,
                                color: Color(0xff4687ff),
                              ),
                              btnName2: "요청하기",
                              btnCall2: () {
                                _postResume(index);
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
                            builder: (context) => ShowWebView(
                                url: resumeList[index].resResumeUrl)));
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) => EditDialog(
                              mode: "resume",
                              index: resumeList[index].index,
                            ));
                    setState(() {
                      _getResume();
                    });
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) => StdDialog(
                              msg: "선택한 이력서를 삭제하시겠습니까?",
                              size: Size(326, 124),
                              btnName1: "아니요",
                              btnCall1: () {
                                Navigator.pop(context, false);
                              },
                              btnName2: "삭제하기",
                              btnCall2: () async {
                                helper = RetrofitHelper(
                                    await TokenInterceptor.getApiClient(context,
                                        () {
                                  setState(() {});
                                }));
                                try {
                                  var res = await helper
                                      .deleteResume(resumeList[index].index);
                                  if (res.success) {
                                    snackBar("이력서가 삭제되었습니다", context);
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
                                  snackBar("이미 삭제된 이력서 입니다.", context);
                                }
                              },
                            ));
                    setState(() {
                      _getResume();
                    });
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
        ),
      ),
    ));
  }

  _postResume(int index) async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res =
          await helper.postCorrectionRequest("Resume", resumeList[index].index);
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
