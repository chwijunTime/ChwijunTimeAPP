import 'package:app_user/model/user.dart';
import 'package:app_user/model/user/profile_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/my_page/my_list.dart';
import 'package:app_user/screens/my_page/my_profile_create.dart';
import 'package:app_user/screens/my_page/my_profile_modify.dart';
import 'package:app_user/screens/my_page/portfolio.dart';
import 'package:app_user/screens/my_page/resume.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPage extends StatefulWidget {
  bool isCreated = false;

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  RetrofitHelper helper;

  ProfileVO vo;

  @override
  void initState() {
    super.initState();
    initRetrofit();
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
      drawer: buildDrawer(context),
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: _getProfile(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              vo = snapshot.data;
              widget.isCreated = vo.tag.isNotEmpty;
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Container(
                        color: Color(0xff5BC7F5),
                        height: 110,
                        width: constraints.maxWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${vo.member.classNumber} ${vo.member.roles.contains(User.user) ? "학생" : "선생"}님!",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: "취준타임",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900)),
                                TextSpan(
                                    text: "과 함께 취업 준비해요.",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ]))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    margin: EdgeInsets.fromLTRB(25, 22, 25, 22),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text("이메일(ID): ${vo.member.email}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                ),
                              ],
                            ),
                            widget.isCreated
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "TEL. ${vo.member.phone}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "소개: ${vo.member.etc}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      makeTagList(vo.tag, Size(370, 0))
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      "프로필을 작성해주세요.",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  )
                          ],
                        )),
                  ),
                  Card(
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 22),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "이력서 보러가기",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 28,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResumePage()));
                              })
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 22),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "포트폴리오 보러가기",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 28,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PortfolioPage()));
                              })
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 22),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "마이 리스트 보러가기",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 28,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyListPage()));
                              })
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                              padding: EdgeInsets.only(right: 25, bottom: 40),
                              child: makeGradientBtn(
                                  msg: widget.isCreated
                                      ? "프로필 수정하기"
                                      : "프로필 생성하기",
                                  onPressed: widget.isCreated
                                      ? _moveProfileModif
                                      : _moveProfileCreate,
                                  mode: 1,
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ))))),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<ProfileVO> _getProfile() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    try {
      var res = await helper.getProfile(token);
      if (res.success) {
        return res.data;
      } else {
        return null;
      }
    } catch (e) {
      print("err: $e");
    }
  }

  _moveProfileCreate() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyProfileCreate()));
    setState(() {
      _getProfile();
    });
  }

  _moveProfileModif() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyProfileModify(
                  vo: vo,
                )));
    setState(() {
      _getProfile();
    });
  }
}
