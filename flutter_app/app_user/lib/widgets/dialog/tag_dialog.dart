import 'package:app_user/model/tag/tag_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class TagDialog extends StatefulWidget {
  String mode;
  int index;
  TagVO vo;

  TagDialog({this.mode, this.index});

  @override
  _TagDialogState createState() => _TagDialogState();
}

class _TagDialogState extends State<TagDialog> {
  RetrofitHelper helper;

  var titleC = TextEditingController();

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
                widget.index != null
                    ? FutureBuilder(
                        future: _getTag(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            widget.vo = snapshot.data;
                            return Text(
                              "기존 태그명: ${widget.vo.name}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            );
                          } else {
                            return SizedBox();
                          }
                        })
                    : SizedBox(),
                SizedBox(
                  height: 5,
                ),
                buildTextField("태그명", titleC, autoFocus: false),
                SizedBox(
                  height: 10,
                ),
                makeGradientBtn(
                    msg: widget.mode == "post" ? "등록하기" : "수정하기",
                    onPressed: ()  {
                      widget.mode == "post" ? postTag() : modifyTag();
                    },
                    mode: 1,
                    icon: Icon(
                      Icons.note_add,
                      color: Colors.white,
                    ))
              ],
            ))));
  }

  Future<TagVO> _getTag() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print("token: ${token}");
    try {
      var res = await helper.getTag(token, widget.index);
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

  postTag() async {
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
                  onPressed: () async {
                    final pref = await SharedPreferences.getInstance();
                    var token = pref.getString("accessToken");
                    print("token: ${token}");
                    var res = await helper.postTag(
                        token, TagVO(name: titleC.text).toJson());
                    if (res.success) {
                      Navigator.pop(context, true);
                    }
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
      print("token: ${token}");
      try {
        var res = await helper.postTag(token, TagVO(name: titleC.text).toJson());
        if (res.success) {
          Navigator.pop(context, true);
          snackBar("성공적으로 태그가 추가되었습니다.", context);
        } else {
          Navigator.pop(context, false);
          snackBar(res.msg, context);
          print("error: ${res.msg}");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  modifyTag() async {
    if (titleC.text.isEmpty) {
      snackBar("태그명을 입력해주세요", context);
    } else {
      final pref = await SharedPreferences.getInstance();
      var token = pref.getString("accessToken");
      print("token: ${token}");
      try {
        var res = await helper.putTag(
            token, widget.index, TagVO(name: titleC.text).toJson());
        if (res.success) {
          Navigator.pop(context, true);
          snackBar("성공적으로 태그가 수정되었습니다.", context);
        } else {
          Navigator.pop(context, false);
          snackBar(res.msg, context);
          print("error: ${res.msg}");
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
