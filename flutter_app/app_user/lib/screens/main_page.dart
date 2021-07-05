import 'package:app_user/consts.dart';
import 'package:app_user/model/notice/notification_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/back_button.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/notification_dialog.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<SliderCard> sliderList = [
    SliderCard(
        title: "협약업체",
        image: "assets/images/loco.jpg",
        route: "/contracting_company"),
    SliderCard(
        title: "취업공고",
        image: "assets/images/loco.jpg",
        route: "/company_notice"),
    SliderCard(
        title: "면접후기",
        image: "assets/images/loco.jpg",
        route: "/interview_review"),
    SliderCard(
        title: "취업 확정 현황",
        image: "assets/images/loco.jpg",
        route: "/confirmation_status"),
    SliderCard(
        title: "꿀팁 저장소",
        image: "assets/images/loco.jpg",
        route: "/tip_storage"),
  ];

  RetrofitHelper helper;
  final _scrollController = ScrollController();
  int itemCount = Consts.showItemCount;

  List<NotificationVO> noticeList = [];

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
        if (itemCount != noticeList.length) {
          if ((noticeList.length - itemCount) ~/ Consts.showItemCount <= 0) {
            itemCount = noticeList.length;
          } else {
            itemCount += Consts.showItemCount;
          }
        }
      });
    }
  }

  backPressed() async {
    return showDialog(
        context: context,
        builder: (context) => StdDialog(
          msg: "앱을 종료하시겠습니까?",
          size: Size(320, 120),
          btnName1: "아니요",
          btnCall1: () {
            Navigator.pop(context, false);
          },
          btnName2: "네",
          btnCall2: () {
            Navigator.pop(context, true);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BackButtonWidget.backButtonWidget(
      context: context,
      child: Scaffold(
        appBar: buildAppBar("취준타임", context),
        drawer: buildDrawer(context),
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18, right: 26, left: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "취준타임",
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff4F9ECB)),
                        ),
                        Text(
                          "과 함께",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "취업 준비 해요",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              makeSlider(sliderList),
              Container(
                height: 12,
                color: Color(0xffEFEFEF),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 16),
                child: Text(
                  "공지사항",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: _getNotice(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        var result = snapshot.data as List<NotificationVO>;
                        noticeList = result;
                        if (noticeList.length <= 10) {
                          itemCount = noticeList.length;
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
                                            "등록된 공지사항이 없습니다.",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
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
                                return buildItemNotification(context, index);
                              }
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<NotificationVO>> _getNotice() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getNoticeList();
      if (res.success) {
        return res.list;
      } else {
        return null;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Widget buildItemNotification(BuildContext context, int index) {
    var tempDate = DateFormat("yyyy-MM-dd").parse(noticeList[index].date);
    var strDate = DateFormat("yyyy년 MM월 dd일").format(tempDate);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
      child: GestureDetector(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (BuildContext context) => NotificationDialog(
                  index: noticeList[index].index,
                  size: Size(346, 400),
                  role: User.role));

          setState(() {
            _getNotice();
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "${noticeList[index].title}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Container(
                  height: 60,
                  child: AutoSizeText(
                    "${noticeList[index].content}",
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
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "등록일: ${strDate}",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget makeSlider(List<SliderCard> list) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 30),
    child: CarouselSlider(
        items: list.map((card) {
          return Builder(builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, card.route, (route) => false);
              },
              child: Container(
                width: 357,
                height: 250,
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 2),
                          blurRadius: 3,
                          spreadRadius: 2)
                    ]),
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/loco.jpg",
                      fit: BoxFit.cover,
                      width: 357,
                      height: 250,
                      color: Colors.black,
                      colorBlendMode: BlendMode.softLight,
                    ),
                    Center(
                        child: Text(
                      card.title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    )),
                  ],
                ),
              ),
            );
          });
        }).toList(),
        options: CarouselOptions(
          autoPlayAnimationDuration: Duration(seconds: 2),
          autoPlayInterval: Duration(seconds: 4),
          autoPlayCurve: Curves.ease,
          autoPlay: true,
          height: 150,
        )),
  );
}

class SliderCard {
  String title;
  String image;
  String route;

  SliderCard(
      {@required this.title, @required this.image, @required this.route});
}
