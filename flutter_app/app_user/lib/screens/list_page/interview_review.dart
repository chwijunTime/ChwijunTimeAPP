import 'package:app_user/consts.dart';
import 'package:app_user/model/company_review/review_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/detail_page/interview_review_detail.dart';
import 'package:app_user/screens/write_page/interview_review_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterviewReviewPage extends StatefulWidget {
  String role;

  @override
  _InterviewReviewPageState createState() => _InterviewReviewPageState();
}

class _InterviewReviewPageState extends State<InterviewReviewPage> {
  final scafforldkey = GlobalKey<ScaffoldState>();
  RetrofitHelper helper;

  List<ReviewVO> reviewList = [];
  final titleC = TextEditingController();
  final _scrollController = ScrollController();
  int itemCount = Consts.showItemCount;

  @override
  void initState() {
    super.initState();
    widget.role = User.role;
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
        if (itemCount != reviewList.length) {
          if ((reviewList.length - itemCount) ~/ Consts.showItemCount <= 0) {
            itemCount += reviewList.length % Consts.showItemCount;
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
                        "면접후기 & 회사후기",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: FloatingActionButton(
                    onPressed: () async {
                      var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InterviewReviewWrite()));
                      if (res != null && res) {
                        setState(() {
                          _getReview();
                        });
                      }
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
            widget.role == User.role
                ? Padding(
                padding:
                EdgeInsets.only(right: 33, left: 33, bottom: 26),
                child: buildTextField("회사 이름", titleC,
                    autoFocus: false,
                    prefixIcon: Icon(Icons.search), textInput: (String key) {
                      print("호잇: ${key}");
                    }))
                : SizedBox(),
            Expanded(
              child: Align(
                child: FutureBuilder(
                    future: _getReview(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        var result = snapshot.data as List<ReviewVO>;
                        reviewList = result;
                        return ListView.builder(
                            controller: _scrollController,
                            itemCount: itemCount + 1,
                            itemBuilder: (context, index) {
                              if (index == itemCount) {
                                if (index == reviewList.length) {
                                  return Padding(
                                    padding: EdgeInsets.all(Consts.padding),
                                    child: makeGradientBtn(
                                        msg: "맨 처음으로",
                                        onPressed: () {
                                          _scrollController.animateTo(
                                              _scrollController
                                                  .position.minScrollExtent,
                                              duration:
                                                  Duration(milliseconds: 200),
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
                                return buildItemReview(context, index);
                              }
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItemReview(BuildContext context, int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
      child: GestureDetector(
        onTap: () {
          print("눌림");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (countext) => InterviewReviewDetail(
                        index: reviewList[index].index,
                      )));
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${reviewList[index].title}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Text(
                  "${reviewList[index].review}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 22,
                child: Row(
                  children: [
                    Row(
                      children: List.generate(2, (indextag) {
                        return buildItemTag(reviewList[index].tag, indextag);
                      }),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.blue[400],
                          )),
                      child: Center(
                        child: Text(
                          "외 ${reviewList[index].tag.length - 2}개",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "지원날짜: ${reviewList[index].applyDate}",
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
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print("token: ${token}");
    try {
      var res = await helper.getReviewList(token);
      if (res.success) {
        return res.list.reversed.toList();
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
