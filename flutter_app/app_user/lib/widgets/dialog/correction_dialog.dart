import 'package:app_user/model/correction/correction_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/show_web_view.dart';
import 'package:app_user/widgets/button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CorrectionDialog extends StatefulWidget {
  String mode;
  int index;
  CorrectionVO vo;

  CorrectionDialog({@required this.index, @required this.mode});

  @override
  _CorrectionDialog createState() => _CorrectionDialog();
}

class _CorrectionDialog extends State<CorrectionDialog> {
  RetrofitHelper helper;

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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      width: 385,
      height: 200,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 60),
      decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
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
        future: _getCorrection(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            widget.vo = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${widget.vo.member.classNumber}_${widget.mode == "portfolio" ? "포트폴리오" : "이력서"}${widget.vo.index} 신청",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowWebView(
                                  url: widget.mode == "portfolio"
                                      ? widget.vo.portfolio.portfolioUrl
                                      : widget.vo.resume.resumeUrl)));
                    },
                    child: Text(
                      "해당 ${widget.mode == "portfolio" ? "포트폴리오" : "이력서"} 바로 보기",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xff5bc7f5)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                User.role == User.user
                    ? Expanded(
                        child: Text(
                            '${widget.vo.status == "Approve" ? "승인" : "거절"}된 요청입니다'))
                    : Expanded(
                        child: widget.vo.status == "Wait"
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  makeGradientBtn(
                                      msg: "요청 승인",
                                      onPressed: _postAccept,
                                      mode: 5,
                                      icon: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  makeGradientBtn(
                                      msg: "요청 거절",
                                      onPressed: _postReject,
                                      mode: 5,
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.white,
                                      )),
                                ],
                              )
                            : Text(
                                '이미 ${widget.vo.status == "Approve" ? "승인" : "거절"}된 요청입니다.',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                      )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }

  Future<CorrectionVO> _getCorrection() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    try {
      var res = await helper.getCorrection(token, widget.index);
      if (res.success) {
        return res.data;
      } else {
        return null;
      }
    } catch (e) {
      print("err: $e");
    }
  }

  _postAccept() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    try {
      var res =
          await helper.postCorrectionApproval(token, {"": ""}, widget.index);
      if (res.success) {
        snackBar("승인되었습니다.", context);
      } else {
        print("error: ${res.msg}");
        snackBar(res.msg, context);
      }
      Navigator.pop(context);
    } catch (e) {
      print("err: $e");
    }
  }

  _postReject() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    try {
      var res =
          await helper.postCorrectionReject(token, {"": ""}, widget.index);
      if (res.success) {
        snackBar("거절되었습니다.", context);
      } else {
        print("error: ${res.msg}");
        snackBar(res.msg, context);
      }
      Navigator.pop(context);
    } catch (e) {
      print("err: $e");
    }
  }
}
