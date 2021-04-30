import 'package:app_user/model/notice/notification_vo.dart';
import 'package:app_user/model/notice/response_notice.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/modify_page/notification_modify.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationDialog extends StatefulWidget {
  final Size size;
  String role;
  int index;
  NotificationVO list;

  NotificationDialog({this.size, this.role, this.index});

  @override
  _NotificationDialog createState() => _NotificationDialog();
}

class _NotificationDialog extends State<NotificationDialog> {
  RetrofitHelper helper;

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
  void initState() {
    super.initState();
    initRetrofit();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Future<ResponseNotice> _getNotice() async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("accessToken");
    print("index: ${widget.index}");
    print("token: ${token}");
    final res = await helper.getNotice(token, widget.index);
    print(res.toJson());
    if (res.success) {
      return res;
    } else {
      Navigator.pop(context);
      snackBar("서버 에러", context);
      print("error: ${res.msg}");
    }
  }

  _onHeartPressed() {
    setState(() {
      widget.list.isFavorite = !widget.list.isFavorite;
    });
  }

  dialogContent(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.role == User.user
          ? widget.size.height
          : widget.size.height + 20,
      padding: EdgeInsets.only(
          top: Consts.padding,
          bottom: Consts.padding,
          left: Consts.padding,
          right: Consts.padding),
      margin: EdgeInsets.only(top: Consts.avataRadius),
      decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(Consts.padding - 10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 1,
              offset: const Offset(0.0, 0.0),
            )
          ]),
      child: FutureBuilder(
          future: _getNotice(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var result = snapshot.data as ResponseNotice;
              widget.list = result.data;
              widget.list.tag = ["욍", "이건", "태그"];
              print("widget: ${widget.list}");
              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.list.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      widget.role == User.user
                          ? IconButton(
                              icon: widget.list.isFavorite
                                  ? Icon(
                                      Icons.favorite,
                                      size: 28,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite_border_outlined,
                                      size: 28,
                                    ),
                              onPressed: () => _onHeartPressed(),
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 28,
                              ),
                              onPressed: () {
                                _onDeleteNoti();
                              }),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        AutoSizeText(
                          widget.list.content,
                          minFontSize: 16,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: makeTagWidget(
                          tag: widget.list.tag, size: Size(360, 50), mode: 2)),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: makeGradientBtn(
                        msg: "공지 사항 수정하기",
                        onPressed: () {
                          _moveModify();
                        },
                        mode: 2,
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  _moveModify() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotificationModify(list: widget.list)));

    if (result != null && result == true) {
      setState(() {
        _getNotice();
      });
    }
  }

  _onDeleteNoti() async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) => StdDialog(
              msg: "해당 공지사항을 삭제하시겠습니까?",
              size: Size(326, 124),
              btnName1: "아니요",
              btnCall1: () {
                Navigator.pop(context, "no");
              },
              btnName2: "삭제하기",
              btnCall2: () async {
                print("삭제할 Comp: ${widget.list}");
                final pref = await SharedPreferences.getInstance();
                var token = pref.getString("accessToken");
                try {
                  final res = await helper.deleteNotice(
                      token: token, index: widget.index);
                  if (res.success) {
                    Navigator.pop(context, "yes");
                  } else {
                    Navigator.pop(context, "no");
                    snackBar("서버 오류", context);
                    print("error: ${res.msg}");
                  }
                } catch (e) {
                  print("error: ${e}");
                  Navigator.pop(context,"yes");
                }

              },
            ),
        barrierDismissible: false);

    if (result == "yes") {
      Navigator.pop(context);
    }
  }
}

class Consts {
  Consts._();

  static const double padding = 30.0;
  static const double avataRadius = 60.0;
}
