import 'package:app_user/consts.dart';
import 'package:app_user/model/comp_notice/comp_apply_status_vo.dart';
import 'package:app_user/model/company_review/review_vo.dart';
import 'package:app_user/model/consulting/consulting_user_vo.dart';
import 'package:app_user/model/correction/corrected_vo.dart';
import 'package:app_user/model/correction/correction_vo.dart';
import 'package:app_user/model/tip/tip_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/detail_page/interview_review_detail.dart';
import 'package:app_user/screens/detail_page/tip_storage_detail.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/corrected_dialog.dart';
import 'package:app_user/widgets/dialog/correction_dialog.dart';
import 'package:app_user/widgets/drop_down_button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyListPage extends StatefulWidget {
  @override
  _MyListPageState createState() => _MyListPageState();

  String role;
}

class _MyListPageState extends State<MyListPage> {
  final scafforldkey = GlobalKey<ScaffoldState>();

  //'취업공고', '작성한 면접 후기', "상담", "요청한 첨삭", "완료한 첨삭", "작성한 꿀팁"
  List<CompApplyStatusVO> noticeList = []; // 취업고고
  List<ReviewVO> reviewList = []; // 작성한 면접후기
  List<ConsultingUserVO> consultingList = []; // 상담
  List<CorrectedVO> correctedList = []; // 완료한 첨삭
  List<CorrectionVO> correctionApplyList = []; // 요청한 첨삭
  List<TipVO> tipList = []; // 작성한 꿀팁
  final _scrollController = ScrollController();
  int itemCount = Consts.showItemCount;
  List<String> valueList = [
    '취업공고',
    '작성한 면접 후기',
    "상담",
    "요청한 첨삭",
    "완료한 첨삭",
    "작성한 꿀팁"
  ];
  String selectValue = "취업공고";
  String msg = "신청한 취업공고가 없습니다.";

  RetrofitHelper helper;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        switch (selectValue) {
          case "취업공고":
            {
              if (itemCount != noticeList.length) {
                if ((noticeList.length - itemCount) ~/ Consts.showItemCount <=
                    0) {
                  itemCount = noticeList.length;
                } else {
                  itemCount += Consts.showItemCount;
                }
              }
              break;
            }
          case "작성한 면접 후기":
            {
              if (itemCount != reviewList.length) {
                if ((reviewList.length - itemCount) ~/ Consts.showItemCount <=
                    0) {
                  itemCount = reviewList.length;
                } else {
                  itemCount += Consts.showItemCount;
                }
              }
              break;
            }
          case "상담":
            {
              if (itemCount != consultingList.length) {
                if ((consultingList.length - itemCount) ~/ Consts.showItemCount <=
                    0) {
                  itemCount = consultingList.length;
                } else {
                  itemCount += Consts.showItemCount;
                }
              }
              break;
            }
          case "요청한 첨삭":
            {
              if (itemCount != correctionApplyList.length) {
                if ((correctionApplyList.length - itemCount) ~/ Consts.showItemCount <=
                    0) {
                  itemCount = correctionApplyList.length;
                } else {
                  itemCount += Consts.showItemCount;
                }
              }
              break;
            }
          case "완료한 첨삭":
            {
              if (itemCount != correctedList.length) {
                if ((correctedList.length - itemCount) ~/ Consts.showItemCount <=
                    0) {
                  itemCount = correctedList.length;
                } else {
                  itemCount += Consts.showItemCount;
                }
              }
              break;
            }
          case "작성한 꿀팁":
            {
              if (itemCount != tipList.length) {
                if ((tipList.length - itemCount) ~/ Consts.showItemCount <=
                    0) {
                  itemCount = tipList.length;
                } else {
                  itemCount += Consts.showItemCount;
                }
              }
              break;
            }
          default:
            {
              if (itemCount != noticeList.length) {
                if ((noticeList.length - itemCount) ~/ Consts.showItemCount <=
                    0) {
                  itemCount = noticeList.length;
                } else {
                  itemCount += Consts.showItemCount;
                }
              }
              break;
            }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafforldkey,
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
                        "마이 리스트",
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
                          switch (selectValue) {
                            case "취업공고":
                              {
                                msg = "신청한 취업공고가 없습니다.";
                                break;
                              }
                            case "작성한 면접 후기":
                              {
                                msg = "작성한 면접후기가 없습니다.";
                                break;
                              }
                            case "상담":
                              {
                                msg = "신청한 상담이 없습니다.";
                                break;
                              }
                            case "요청한 첨삭":
                              {
                                msg = "요청한 첨삭이 없습니다.";
                                break;
                              }
                            case "완료한 첨삭":
                              {
                                msg = "완료된 첨삭이 없습니다.";
                                break;
                              }
                            case "작성한 꿀팁":
                              {
                                msg = "작성한 꿀팁이 없습니다.";
                                break;
                              }
                            default:
                              {
                                msg = "신청한 취업공고가 없습니다.";
                                break;
                              }
                          }
                        });
                      },
                      hint: "보기"),
                ],
              ),
            ),
            Expanded(child: _myList()),
          ],
        ),
      ),
    );
  }

  Widget _myList() {
    switch (selectValue) {
      case "취업공고":
        {
          return _companyListBuilder();
        }
      case "작성한 면접 후기":
        {
          return _reviewListBuilder();
        }
      case "상담":
        {
          return _consultingListBuilder();
        }
      case "요청한 첨삭":
        {
          return _correctionApplyListBuilder();
        }
      case "완료한 첨삭":
        {
          return _correctedListBuilder();
        }
      case "작성한 꿀팁":
        {
          return _tipListBuilder();
        }
      default:
        {
          return _companyListBuilder();
        }
    }
  }

  // region 취업공고
  Widget _companyListBuilder() {
    return FutureBuilder(
        future: _getCompNoticeList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            noticeList = snapshot.data;
            if (noticeList.length <= Consts.showItemCount) {
              itemCount = noticeList.length;
            }
            return ListView.separated(
              controller: _scrollController,
              itemCount: itemCount + 1,
              itemBuilder: (context, index) {
                if (index == itemCount) {
                  if (noticeList.length == 0) {
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
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )),
                      ),
                    );
                  } else if (index == noticeList.length) {
                    return Padding(
                      padding: EdgeInsets.all(20),
                      child: makeGradientBtn(
                          msg: "맨 처음으로",
                          onPressed: () {
                            _scrollController.animateTo(
                                _scrollController.position.minScrollExtent,
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
        });
  }

  Future<List<CompApplyStatusVO>> _getCompNoticeList() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getMyApplyCompNotice();
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
    var status = noticeList[index].status;
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${noticeList[index].classNumber}_${noticeList[index].title}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          makeTag(noticeList[index].status),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
    ));
  }

  //endregion

  //region 면접 후기
  Widget _reviewListBuilder() {
    return FutureBuilder(
        future: _getReview(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            reviewList = snapshot.data;
            if (reviewList.length <= Consts.showItemCount) {
              itemCount = reviewList.length;
            }
            return ListView.builder(
                controller: _scrollController,
                itemCount: itemCount + 1,
                itemBuilder: (context, index) {
                  if (index == itemCount) {
                    if (index == 0) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        elevation: 5,
                        margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                        child: Center(
                          child: Padding(
                              padding: EdgeInsets.all(Consts.padding),
                              child: Text(
                                "등록된 리뷰가 없습니다.",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )),
                        ),
                      );
                    } else if (index == reviewList.length) {
                      return Padding(
                        padding: EdgeInsets.all(Consts.padding),
                        child: makeGradientBtn(
                            msg: "맨 처음으로",
                            onPressed: () {
                              _scrollController.animateTo(
                                  _scrollController.position.minScrollExtent,
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
                    return buildItemReview(context, index, reviewList);
                  }
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget buildItemReview(BuildContext context, int index, List<ReviewVO> list) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (countext) => InterviewReviewDetail(
                        index: list[index].index,
                      )));
          setState(() {
            _getReview();
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
                  "${list[index].review}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 22,
                child: Row(
                  children: [
                    buildItemTag(list[index].tag, 0),
                    list[index].tag.length > 1
                        ? Container(
                            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.blue[400],
                                )),
                            child: Center(
                              child: Text(
                                "외 ${list[index].tag.length - 1}개",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        : SizedBox(),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "지원날짜: ${list[index].applyDate}",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
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

  Future<List<ReviewVO>> _getReview() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getMyReview();
      if (res.success) {
        return res.list.reversed.toList();
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  //endregion

  // region 상담
  Widget _consultingListBuilder() {
    return FutureBuilder(
      future: getCounselingUserList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          consultingList = snapshot.data;
          if (consultingList.length <= Consts.showItemCount) {
            itemCount = consultingList.length;
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: itemCount + 1,
            itemBuilder: (context, index) {
              if (index == itemCount) {
                if (consultingList.length == 0) {
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
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )),
                    ),
                  );
                } else if (index == consultingList.length) {
                  return Padding(
                    padding: EdgeInsets.all(Consts.padding),
                    child: makeGradientBtn(
                        msg: "맨 처음으로",
                        onPressed: () {
                          _scrollController.animateTo(
                              _scrollController.position.minScrollExtent,
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
    );
  }

  Widget buildCounselingUser(BuildContext context, int index) {
    var tempDate =
        DateFormat("yyyy-MM-dTHH:mm:ss").parse(consultingList[index].applyDate);
    var strDate = DateFormat("yyyy년 MM월 dd일 HH시 mm분").format(tempDate);
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18))),
        elevation: 5,
        margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: Padding(
          padding: EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 20),
          child: Text(
            strDate,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ));
  }

  Future<List<ConsultingUserVO>> getCounselingUserList() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getMyConsulting();
      if (res.success) {
        return res.list;
      } else {
        return null;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  // endregion

  //region 첨삭
  Widget _correctedListBuilder() {
    return FutureBuilder(
      future: _getCorrection(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          correctedList = snapshot.data;
          if (correctedList.length <= Consts.showItemCount) {
            itemCount = correctedList.length;
          }
          return ListView.separated(
            controller: _scrollController,
            itemCount: itemCount + 1,
            itemBuilder: (context, index) {
              if (index == itemCount) {
                if (correctedList.length == 0) {
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
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )),
                    ),
                  );
                } else if (index == correctedList.length) {
                  return Padding(
                    padding: EdgeInsets.all(Consts.padding),
                    child: makeGradientBtn(
                        msg: "맨 처음으로",
                        onPressed: () {
                          _scrollController.animateTo(
                              _scrollController.position.minScrollExtent,
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
                return buildCorrection(context, index);
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
    );
  }

  Future<List<CorrectedVO>> _getCorrection() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getMyCorrection();
      if (res.success) {
        return res.list;
      }
    } catch (e) {
      print("err: $e");
    }
  }

  Widget buildCorrection(BuildContext context, int index) {
    CorrectedVO vo = correctedList[index];
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: InkWell(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (BuildContext context) => CorrectedDialog(list: vo));
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
                      "${vo.classNumber}_${vo.type == "Portfolio" ? "포트폴리오 ${vo.portfolioIdx}" : "이력서 ${vo.resumeIdx}"}")),
              makeTag(vo.status)
            ],
          ),
        ),
      ),
    ));
  }

  // endregion

  //region 첨삭 요청
  Widget _correctionApplyListBuilder() {
    return FutureBuilder(
      future: _getCorrectionApply(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          correctionApplyList = snapshot.data;
          if (correctionApplyList.length <= Consts.showItemCount) {
            itemCount = correctionApplyList.length;
          }
          return ListView.separated(
            controller: _scrollController,
            itemCount: itemCount + 1,
            itemBuilder: (context, index) {
              if (index == itemCount) {
                if (correctionApplyList.length == 0) {
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
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )),
                    ),
                  );
                } else if (index == correctionApplyList.length) {
                  return Padding(
                    padding: EdgeInsets.all(Consts.padding),
                    child: makeGradientBtn(
                        msg: "맨 처음으로",
                        onPressed: () {
                          _scrollController.animateTo(
                              _scrollController.position.minScrollExtent,
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
                return buildCorrectionApply(context, index);
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
    );
  }

  Future<List<CorrectionVO>> _getCorrectionApply() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getMyCorrectionApply();
      if (res.success) {
        return res.list.reversed.toList();
      }
    } catch (e) {
      print("err: $e");
    }
  }

  Widget buildCorrectionApply(BuildContext context, int index) {
    CorrectionVO vo = correctionApplyList[index];
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Row(
          children: [
            Expanded(
                child: Text(
                    "${vo.classNumber}_${vo.type == "Portfolio" ? "포트폴리오 ${vo.portfolioIdx}" : "이력서 ${vo.resumeIdx}"}")),
            makeTag(vo.status)
          ],
        ),
      ),
    ));
  }

  //endregion

  //region 꿀팁
  Widget _tipListBuilder() {
    return FutureBuilder(
        future: _getTipList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                              borderRadius: BorderRadius.circular(18)),
                          elevation: 5,
                          margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                          child: Center(
                            child: Padding(
                                padding: EdgeInsets.all(Consts.padding),
                                child: Text(
                                  msg,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )),
                          ),
                        );
                      } else if (index == tipList.length) {
                        return Padding(
                          padding: EdgeInsets.all(Consts.padding),
                          child: makeGradientBtn(
                              msg: "맨 처음으로",
                              onPressed: () {
                                _scrollController.animateTo(
                                    _scrollController.position.minScrollExtent,
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
                      return buildItemTip(context, index, tipList);
                    }
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
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

  Future<List<TipVO>> _getTipList() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getMyTip();
      if (res.success) {
        return res.list;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

//endregion

  Widget makeTag(String str) {
    String msg;
    Color color;

    if (str == "Correction_Applying" || str == "Wait") {
      msg = "대기중";
      color = Colors.grey;
    } else if (str == "Correction_Successful") {
      msg = "완료함";
      color = Color(0xff5BC7F5);
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
