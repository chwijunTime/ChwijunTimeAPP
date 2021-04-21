import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class TagDialog extends StatefulWidget {
  String mode;
  String tag;

  TagDialog({this.mode, this.tag});

  @override
  _TagDialogState createState() => _TagDialogState();
}

class _TagDialogState extends State<TagDialog> {
  var titleC = TextEditingController();

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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: 311,
        height: widget.mode != "post" ? 224 : 214,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: widget.mode == "post" ? "등록할 " : "수정할 ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                TextSpan(
                    text: "태그명",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4F9ECB))),
                TextSpan(
                    text: "을 작성해주세요. ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
              ])),
              SizedBox(
                height: 5,
              ),
              widget.tag != null
                  ? Text(
                      "기존 태그명: ${widget.tag}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    )
                  : SizedBox(),
              SizedBox(height: 5,),
              buildTextField("태그명", titleC, autoFocus: false),
              SizedBox(
                height: 10,
              ),
              makeGradientBtn(
                  msg: widget.mode == "post" ? "등록하기" : "수정하기",
                  onPressed: () {
                    widget.mode == "post" ? postTag() : modifyTag();
                  },
                  mode: 1,
                  icon: Icon(
                    Icons.note_add,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  postTag() {
    if (titleC.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return RichAlertDialog(
              alertTitle: richTitle("입력 오류"),
              alertSubtitle: richSubtitle("태그명을 입력해주세요!"),
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
      Navigator.pop(context);

      if (true) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RichAlertDialog(
                alertTitle: richTitle("요청 완료!"),
                alertSubtitle: richSubtitle("성공적으로 태그가 추가 되었습니다."),
                alertType: RichAlertType.SUCCESS,
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "확인",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green[400],
                  )
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RichAlertDialog(
                alertTitle: richTitle("ERROR"),
                alertSubtitle: richSubtitle("잠시후 다시 요청해주세요."),
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
      }
    }
  }

  modifyTag() {
    if (titleC.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return RichAlertDialog(
              alertTitle: richTitle("입력 오류"),
              alertSubtitle: richSubtitle("태그명을 입력해주세요!"),
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
      Navigator.pop(context);

      if (true) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RichAlertDialog(
                alertTitle: richTitle("요청 완료!"),
                alertSubtitle: richSubtitle("성공적으로 태그가 수정 되었습니다."),
                alertType: RichAlertType.SUCCESS,
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "확인",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green[400],
                  )
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RichAlertDialog(
                alertTitle: richTitle("ERROR"),
                alertSubtitle: richSubtitle("잠시후 다시 요청해주세요."),
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
      }
    }
  }
}
