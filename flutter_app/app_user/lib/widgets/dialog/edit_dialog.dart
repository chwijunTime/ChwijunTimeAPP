import 'package:app_user/model/resume_portfolio/portfolio_vo.dart';
import 'package:app_user/model/resume_portfolio/resume_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditDialog extends StatefulWidget {
  String mode;
  int index;

  EditDialog({this.mode, this.index});

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  RetrofitHelper helper;

  var urlC = TextEditingController();

  @override
  void initState() {
    super.initState();
    initRetrofit();
  }

  @override
  void dispose() {
    urlC.dispose();
    super.dispose();
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
  build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
        width: 311,
        height: 224,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 60),
        decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 1,
                offset: const Offset(0.0, 0.0),
              )
            ]),
        child: Center(
            child: FutureBuilder(
              future: widget.mode == "portfolio"
                  ? _getPortpolio()
                  : _getResume(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (widget.mode == "portfolio") {
                    PortfolioVO vo = snapshot.data;
                    urlC.text = vo.portfolioUrl;
                  } else {
                    ResumeVO vo = snapshot.data;
                    urlC.text = vo.resResumeUrl;
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text: "수정할 ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            TextSpan(
                                text: widget.mode == "portfolio"
                                    ? "포트폴리오"
                                    : "이력서",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff4F9ECB))),
                            TextSpan(
                                text: " url을 작성해주세요. ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          ])),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      buildTextField(
                          widget.mode == "portfolio" ? "포트폴리오 url" : "이력서 url",
                          urlC,
                          autoFocus: false),
                      SizedBox(
                        height: 10,
                      ),
                      makeGradientBtn(
                          msg: "수정하기",
                          onPressed: widget.mode == "portfolio"
                              ? modifyPortfolio
                              : modifyResume,
                          mode: 1,
                          icon: Icon(
                            Icons.note_add,
                            color: Colors.white,
                          ))
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )));
  }

  Future<PortfolioVO> _getPortpolio() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print("token: ${token}");
    try {
      var res = await helper.getPortfolio(token, widget.index);
      print("res.success: ${res.success}");
      if (res.success) {
        return res.data;
      } else {
        return null;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Future<ResumeVO> _getResume() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print("token resume: ${token}");
    try {
      var res = await helper.getResume(token, widget.index);
      print("res.success: ${res.success}");
      if (res.success) {
        return res.data;
      } else {
        return null;
      }
    } catch (e) {
      print("err: $e");
    }
  }

  modifyPortfolio() async {
    if (urlC.text.isEmpty) {
      snackBar("URL을 작성해주세요", context);
    } else {
      final pref = await SharedPreferences.getInstance();
      var token = pref.getString("accessToken");
      try {
        var res = await helper.putPortfolio(
            token, widget.index, {"notionPortfolioURL": urlC.text});
        if (res.success) {
          snackBar("수정하였습니다.", context);
          Navigator.pop(context);
        } else {
          snackBar(res.msg, context);
          Navigator.pop(context);
        }
      } catch (e) {
        print("err: $e");
      }
    }
  }

  modifyResume() async {
    if (urlC.text.isEmpty) {
      snackBar("URL을 작성해주세요", context);
    } else {
      final pref = await SharedPreferences.getInstance();
      var token = pref.getString("accessToken");
      try {
        var res = await helper.putResume(
            token, widget.index, {"resumeFileURL": urlC.text});
        if (res.success) {
          snackBar("수정하였습니다.", context);
          Navigator.pop(context);
        } else {
          snackBar(res.msg, context);
          Navigator.pop(context);
        }
      } catch (e) {
        print("err: $e");
      }
    }
  }
}