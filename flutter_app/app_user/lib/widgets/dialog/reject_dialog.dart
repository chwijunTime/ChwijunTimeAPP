import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class RejectDialog extends StatefulWidget {
  String mode;

  RejectDialog({@required this.mode});

  @override
  _RejectDialog createState() => _RejectDialog();
}

class _RejectDialog extends State<RejectDialog> {
  var reasonC = TextEditingController();

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
      height: 300,
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
            Text(
              "해당 ${widget.mode == "portfolio" ? "포트폴리오" : "자기소개서"} 첨삭을 거절 하시겠습니까?",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            Text(
              "거절 사유를 입력해주세요.",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            buildTextField("거절 사유를 간단하게 입력해주세요!", reasonC,
                maxLine: 6, maxLength: 300),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  makeBtn(
                      msg: "아니요",
                      onPressed: () {
                        Navigator.pop(context, "no");
                      },
                      mode: 2,
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  makeGradientBtn(
                      msg: "확인",
                      onPressed: () {
                        if (reasonC.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return RichAlertDialog(
                                  alertTitle: richTitle("거절 사유를 입력해주세요!"),
                                  alertSubtitle: richSubtitle(
                                      "${widget.mode == "portfolio" ? "포트폴리오" : "자기소개서"} 거절 사유를 작성해주세요."),
                                  alertType: RichAlertType.ERROR,
                                  actions: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "확인",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.orange[800],
                                    )
                                  ],
                                );
                              });
                        } else {
                          Navigator.pop(context, "yes");
                        }
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
}
