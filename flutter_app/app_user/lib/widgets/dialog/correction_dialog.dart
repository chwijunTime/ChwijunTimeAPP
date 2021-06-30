import 'package:app_user/model/correction/admin_correction_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/show_web_view.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/accept_dialog.dart';
import 'package:app_user/widgets/dialog/reject_dialog.dart';
import 'package:flutter/material.dart';

class CorrectionDialog extends StatefulWidget {
  int index;
  AdminCorrectionVO vo;

  CorrectionDialog({@required this.index});

  @override
  _CorrectionDialog createState() => _CorrectionDialog();
}

class _CorrectionDialog extends State<CorrectionDialog> {
  RetrofitHelper helper;

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
      height: 150,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${widget.vo.member.classNumber}_${widget.vo.type == "Portfolio" ? "포트폴리오 ${widget.vo.portfolio.index}" : "이력서 ${widget.vo.resume.index}"}",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
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
                                  url: widget.vo.type == "Portfolio"
                                      ? widget.vo.portfolio.portfolioUrl
                                      : widget.vo.resume.resumeUrl)));
                    },
                    child: Text(
                      "해당 ${widget.vo.type == "Portfolio" ? "포트폴리오" : "이력서"} 바로 보기",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xff5bc7f5)),
                    ),
                  ),
                ),
                widget.vo.status == "Correction_Applying"
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
                        '${widget.vo.status == "Correction_Successful" ? "승인된" : "거절된"} 요청입니다',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
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

  Future<AdminCorrectionVO> _getCorrection() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getCorrection(widget.index);
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
    await showDialog(
        context: context,
        builder: (BuildContext context) => AcceptDialog(
              vo: widget.vo,
            ));
    setState(() {
      _getCorrection();
    });
  }

  _postReject() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => RejectDialog(vo: widget.vo));
    setState(() {
      _getCorrection();
    });
  }
}
