import 'package:app_user/consts.dart';
import 'package:app_user/model/comp_notice/comp_notice_vo.dart';
import 'package:app_user/model/company_review/review_vo.dart';
import 'package:app_user/model/consulting/consulting_user_vo.dart';
import 'package:app_user/model/correction/correction_vo.dart';
import 'package:app_user/model/tip/tip_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/detail_page/company_notice_detail.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/drop_down_button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyListPage extends StatefulWidget {
  @override
  _MyListPageState createState() => _MyListPageState();

  String role;
}

class _MyListPageState extends State<MyListPage> {
  final scafforldkey = GlobalKey<ScaffoldState>();

  //'취업공고', '작성한 면접 후기', "상담", "요청한 첨삭", "완료한 첨삭", "작성한 꿀팁"
  List<CompNoticeVO> noticeList = [];
  List<ReviewVO> reviewList = [];
  List<ConsultingUserVO> consultingList = [];
  List<CorrectionVO> correctionList = [];
  List<CorrectionVO> correctionApplyList = [];
  List<TipVO> tipList = [];
  List<CompNoticeVO> searchNoticeList = [];
  final titleC = TextEditingController();
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
                                msg = "완료한 첨삭이 없습니다.";
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
                          if (selectValue == valueList[1]) {
                            itemCount = 0;
                            searchNoticeList.clear();
                            msg = "이름, 지역, 직군으로 검색하기";
                          } else {
                            titleC.text = "";
                          }
                        });
                      },
                      hint: "보기"),
                ],
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(right: 33, left: 33, bottom: 15, top: 15),
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
                })),
            Expanded(child: selectValue == valueList[0] ? _companyListBuilder() : _getConsultingList() ),
          ],
        ),
      ),
    );
  }

  // region 취업공고
  Widget _companyListBuilder() {
    return FutureBuilder(
        future: _getCompany(),
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
            return ListView.builder(
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
                  return buildItemCompany(context, index, noticeList);
                }
              },
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            );
          }
        });
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
              Text(
                "${list[index].title}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
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
  
  //endregion

  // region 상담
  Widget _getConsultingList() {
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
                            style:
                            TextStyle(fontWeight: FontWeight.w700),
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
    DateFormat("yyyy-MM-dd hh:mm").parse(consultingList[index].applyDate);
    var strDate = DateFormat("yyyy년 MM월 dd일 hh시 mm분").format(tempDate);
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18))),
        elevation: 5,
        margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: Padding(
          padding: EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${consultingList[index].classNumber} ${consultingList[index].name}님의 신청",
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                strDate,
                style:
                TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ));
  }

  Future<List<ConsultingUserVO>> getCounselingUserList() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print("token: ${token}");
    try {
      var res = await helper.getConsultingUserList(token);
      print("res.success: ${res.success}");
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
}
