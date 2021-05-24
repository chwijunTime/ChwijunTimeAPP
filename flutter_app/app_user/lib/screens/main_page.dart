import 'package:app_user/model/notice/notification_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/dialog/notification_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  String role;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<SliderCard> sliderList = [
    SliderCard(title: "협약업체", image: "images/loco.jpg", route: "/contracting_company"),
    SliderCard(title: "취업공고", image: "images/loco.jpg", route: "/company_notice"),
    SliderCard(title: "면접후기", image: "images/loco.jpg", route: "/interview_review"),
    SliderCard(title: "취업 확정 현황", image: "images/loco.jpg", route: "/confirmation_status"),
    SliderCard(title: "꿀팁 저장소", image: "images/loco.jpg", route: "/tip_storage"),
  ];

  RetrofitHelper helper;

  List<NotificationVO> notiList = [];

  @override
  void initState() {
    super.initState();
    init();
    widget.role = User.role;
  }

  init() {
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
      drawer: buildDrawer(context),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18, right: 26, left: 26 ),
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
                            fontWeight: FontWeight.w500,
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
                        fontWeight: FontWeight.w500,
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
                    notiList = result;
                    return ListView.builder(
                      itemCount: notiList.length,
                      itemBuilder: (context, index) {
                        return buildItemNotification(context, index);
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                    );
                  }
                  else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<NotificationVO>> _getNotice() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    var res = await helper.getNoticeList("Bearer ${token}");
    print("res.msg: ${res.list}");
    if (res.success) {
      return res.list.reversed.toList();
    } else {
      return null;
    }
  }

  Widget buildItemNotification(BuildContext context, int index) {
    DateTime dt = DateTime.parse(notiList[index].date);
    String strDate = "${dt.year}.${dt.month}.${dt.day}";
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
      child: GestureDetector(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (BuildContext context) => NotificationDialog(index: notiList[index].index, size: Size(346, 502), role: widget.role));

          setState(() {
            _getNotice();
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${notiList[index].title}",
                style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Container(
                  height: 60,
                  child: AutoSizeText(
                    "${notiList[index].content}",
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
                Navigator.pushNamedAndRemoveUntil(context, card.route, (route) => false);
              },
              child: Container(
                width: 357,
                height: 250,
                margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
                      "images/loco.jpg",
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
