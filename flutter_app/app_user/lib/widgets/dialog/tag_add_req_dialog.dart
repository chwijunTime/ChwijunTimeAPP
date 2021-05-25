import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class TagAddReqDialog extends StatefulWidget {
  @override
  _TagAddReqDialogState createState() => _TagAddReqDialogState();
}

class _TagAddReqDialogState extends State<TagAddReqDialog> {
  var titleC = TextEditingController();

  RetrofitHelper helper;

  @override
  void initState() {
    super.initState();
    initRetrofit();
  }

  @override
  void dispose() {
    titleC.dispose();
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: 340,
        height: 200,
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
                    text: "등록하고 싶은 ",
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
                    text: "을 작성해주세요.",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
              ])),
              SizedBox(
                height: 10,
              ),
              buildTextField("태그명", titleC, autoFocus: false),
              SizedBox(
                height: 10,
              ),
              makeGradientBtn(
                  msg: "요청해요!",
                  onPressed: () {
                    postAddTagReq();
                  },
                  mode: 1,
                  icon: Icon(
                    Icons.add_box_rounded,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  postAddTagReq() async {
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
      final pref = await SharedPreferences.getInstance();
      var token = pref.getString("accessToken");
      var res = await helper.postReqTag(token, {"tagName": titleC.text});
      Navigator.pop(context);
      if (res.success) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RichAlertDialog(
                alertTitle: richTitle("요청 완료!"),
                alertSubtitle: richSubtitle("성공적으로 태그가 요청되었습니다."),
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
