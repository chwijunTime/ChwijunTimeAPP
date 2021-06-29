import 'package:app_user/model/user.dart';
import 'package:app_user/model/user/profile_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/my_page/my_list.dart';
import 'package:app_user/screens/my_page/my_profile_create.dart';
import 'package:app_user/screens/my_page/my_profile_modify.dart';
import 'package:app_user/screens/my_page/portfolio.dart';
import 'package:app_user/screens/my_page/resume.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/back_button.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/edit_password_dialog.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:flutter/cupertino.dart';
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
  Widget build(BuildContext context) {
    return BackButtonWidget.backButtonWidget(
      context: context,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    User.role == User.user
                        ? Column(
                            children: [
                              Card(
                                margin: EdgeInsets.fromLTRB(25, 0, 25, 22),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "이력서 보러가기",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
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
                                                    builder: (context) =>
                                                        ResumePage()));
                                          })
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.fromLTRB(25, 0, 25, 22),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "포트폴리오 보러가기",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
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
                                                    builder: (context) =>
                                                        PortfolioPage()));
                                          })
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.fromLTRB(25, 0, 25, 22),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "마이 리스트 보러가기",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
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
                                                    builder: (context) =>
                                                        MyListPage()));
                                          })
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                                padding: EdgeInsets.only(right: 25, bottom: 40),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    makeBtn(
                                        msg: '계정 권한 확인하기',
                                        onPressed: () async {
                                          try {
                                            var res = await helper
                                                .getPermission(vo.member.email);
                                            if (res.contains("유저")) {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          StdDialog(
                                                            msg:
                                                                "이 계정은 유저 계정입니다.",
                                                            size: Size(180, 100),
                                                            icon: Icon(
                                                              Icons.person,
                                                              color: Colors
                                                                  .blueAccent,
                                                            ),
                                                          ));
                                            } else {
                                              if (User.role == User.admin) {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        StdDialog(
                                                          msg: "이 계정은 어드민 계정입니다.",
                                                          size: Size(180, 100),
                                                          icon: Icon(
                                                            Icons.person,
                                                            color:
                                                                Colors.blueAccent,
                                                          ),
                                                        ));
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        StdDialog(
                                                          msg:
                                                              "이 계정은 어드민 계정입니다. \n다시 로그인해주세요.",
                                                          size: Size(200, 150),
                                                          icon: Icon(
                                                            Icons
                                                                .admin_panel_settings,
                                                            color:
                                                                Colors.blueAccent,
                                                          ),
                                                          btnIcon2: Icon(
                                                            Icons.check,
                                                            color: Colors.white,
                                                          ),
                                                          btnCall2: () async {
                                                            try {
                                                              helper = RetrofitHelper(
                                                                  await TokenInterceptor
                                                                      .getApiClient(
                                                                          context,
                                                                          () {
                                                                setState(() {});
                                                              }));
                                                              var res = await helper
                                                                  .postLogout();
                                                              if (res.success) {
                                                                SharedPreferences
                                                                    pref =
                                                                    await SharedPreferences
                                                                        .getInstance();
                                                                await pref
                                                                    .clear();
                                                                Navigator
                                                                    .pushReplacementNamed(
                                                                        context,
                                                                        "/login");
                                                              } else {
                                                                print(
                                                                    "error: ${res.msg}");
                                                              }
                                                            } catch (e) {
                                                              print("err: ${e}");
                                                            }

                                                            Navigator
                                                                .pushReplacementNamed(
                                                                    context,
                                                                    "/login");
                                                          },
                                                          btnName2: "다시 로그인",
                                                        ),
                                                    barrierDismissible: false);
                                              }
                                            }
                                          } catch (e) {
                                            print("err: $e");
                                          }
                                        },
                                        mode: 1,
                                        icon: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    makeBtn(
                                        msg: "비밀번호 변경하기",
                                        onPressed: _modifyPassword,
                                        mode: 1,
                                        icon: Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    makeGradientBtn(
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
                                        )),
                                  ],
                                )))),
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
      ),
    );
  }

  Future<ProfileVO> _getProfile() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getProfile();
      if (res.success) {
        return res.data;
      } else {
        return null;
      }
    } catch (e) {
      print("err: $e");
    }
  }

  _modifyPassword() {
    showDialog(
        context: context,
        builder: (BuildContext context) => EditPasswordDialog());
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
