import 'package:app_user/consts.dart';
import 'package:app_user/model/apply_vo.dart';
import 'package:app_user/model/comp_notice/comp_notice_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/apply_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CompanyNoticeApply extends StatefulWidget {
  CompNoticeVO list;

  CompanyNoticeApply({@required this.list});

  @override
  _CompanyNoticeApplyState createState() => _CompanyNoticeApplyState();
}

class _CompanyNoticeApplyState extends State<CompanyNoticeApply> {
  RetrofitHelper helper;
  List<ApplyVO> applyList = [];

  final titleC = TextEditingController();
  final _scrollController = ScrollController();
  int itemCount = Consts.showItemCount;

  @override
  void initState() {
    super.initState();
    initRetrofit();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    titleC.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        if (itemCount != applyList.length) {
          if ((applyList.length - itemCount) ~/ Consts.showItemCount <=
              0) {
            itemCount += applyList.length % Consts.showItemCount;
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
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(26),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.list.title,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,),
                  ),
                  Text(
                    "에 지원한 학생들",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.separated(
                        controller: _scrollController,
                        itemCount: itemCount + 1,
                        itemBuilder: (context, index) {
                          if (index == itemCount) {
                            if (index == applyList.length) {
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
                            return buildItemApply(context, index);
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
                    }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<ApplyVO>> _getList () async {
    await Future.delayed(Duration(seconds: 3));
    List<ApplyVO> list = [];
    for (int i = 0; i < 15; i++) {
      list.add(ApplyVO(
          user: "3210안수빈",
          portfolio: "https://www.naver.com/",
          introduction: "https://www.naver.com/",
          status: "notDone"));
    }
  }


  Widget buildItemApply(BuildContext context, int index) {
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: InkWell(
        onTap: () {
          showDialog(context: context, builder: (BuildContext context) => ApplyDialog(vo: applyList[index]));
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                "${applyList[index].user}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    ));
  }
}
