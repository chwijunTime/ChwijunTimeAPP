import 'package:app_user/model/apply_vo.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/show_web_view.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/reject_dialog.dart';
import 'package:flutter/material.dart';

class ApplyDialog extends StatefulWidget {
  ApplyVO vo;

  ApplyDialog({@required this.vo,});

  @override
  _ApplyDialog createState() => _ApplyDialog();
}

class _ApplyDialog extends State<ApplyDialog> {
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
      height: 180,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "${widget.vo.user} 지원 신청",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ),
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShowWebView(url: widget.vo.introduction)));
                      },
                      child: Text(
                        "해당 자기소개서 바로 보기",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xff5bc7f5)),
                      ),
                    ))),
            Expanded(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShowWebView(url: widget.vo.portfolio)));
                      },
                      child: Text(
                        "해당 포트폴리오 바로 보기",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xff5bc7f5)),
                      ),
                    ))),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  makeGradientBtn(
                      msg: "요청 승인",
                      onPressed: () {
                        snackBar("요청을 승인했습니다.", context);
                        Navigator.pop(context, "approve");
                      },
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
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                RejectDialog(mode: "apply")).then((value) {
                          print(value);
                          if (value == "yes") {
                            Navigator.pop(context, "reject");
                            snackBar("거절되었습니다.", context);
                          }
                        });
                      },
                      mode: 5,
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.white,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  hi() async {}
}
