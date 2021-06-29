import 'package:app_user/consts.dart';
import 'package:app_user/model/comp_notice/comp_apply_status_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/apply_dialog.dart';
import 'package:app_user/widgets/drop_down_button.dart';
import 'package:flutter/material.dart';

class CompanyNoticeApply extends StatefulWidget {
  @override
  _CompanyNoticeApplyState createState() => _CompanyNoticeApplyState();
}

class _CompanyNoticeApplyState extends State<CompanyNoticeApply> {
  RetrofitHelper helper;
  List<CompApplyStatusVO> applyList = [];

  final titleC = TextEditingController();
  final _scrollController = ScrollController();
  int itemCount = Consts.showItemCount;
  List<String> valueList = ['전체', '수락', '거절', '대기중'];
  String selectValue = '전체';

  @override
  void initState() {
    super.initState();
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
          if ((applyList.length - itemCount) ~/ Consts.showItemCount <= 0) {
            itemCount = applyList.length;
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
                        "취업 공고 신청",
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
                          itemCount = 0;
                        });
                      },
                      hint: "보기"),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: _getList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      applyList = snapshot.data;
                      if (applyList.length <= Consts.showItemCount) {
                        itemCount = applyList.length;
                      }
                      return ListView.separated(
                        controller: _scrollController,
                        itemCount: itemCount + 1,
                        itemBuilder: (context, index) {
                          if (index == itemCount) {
                            if (applyList.length == 0) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                elevation: 5,
                                margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                                child: Center(
                                  child: Padding(
                                      padding: EdgeInsets.all(Consts.padding),
                                      child: Text(
                                        "요청된 취업공고가 없습니다.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      )),
                                ),
                              );
                            } else if (index == applyList.length) {
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
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<CompApplyStatusVO>> _getList() async {
    try {
      var status = "";
      switch (selectValue) {
        case "전체":
          {
            status = "All";
            break;
          }
        case "수락":
          {
            status = "Approve";
            break;
          }

        case "거절":
          {
            status = "Reject";
            break;
          }
        case "대기중":
          {
            status = "Wait";
            break;
          }
        default:
          status = "All";
      }
      helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
        setState(() {});
      }));
      var res = await helper.getCompApplyStatusList(status);
      if (res.success) {
        return res.list;
      } else {
        print("error: ${res.msg}");
        snackBar(res.msg, context);
      }
    } catch (e) {
      print("err: $e");
    }
  }

  Widget buildItemApply(BuildContext context, int index) {
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: InkWell(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (BuildContext context) => ApplyDialog(
                    index: applyList[index].index,
                    statusVo: applyList[index],
                  ));
          setState(() {
            _getList();
          });
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                "${applyList[index].classNumber}_${applyList[index].title}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            makeTag(applyList[index].status),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    ));
  }

  Widget makeTag(String str) {
    String msg;
    Color color;

    if (str == "Wait") {
      msg = "대기중";
      color = Colors.grey;
    } else if (str == "Approve") {
      msg = "수락함";
      color = Color(0xff5BC7F5);
    } else {
      msg = "거절함";
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
}
