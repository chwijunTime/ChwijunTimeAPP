import 'package:app_user/model/correction/correction_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcceptDialog extends StatefulWidget {
  CorrectionVO vo;

  AcceptDialog({this.vo});

  @override
  _AcceptDialog createState() => _AcceptDialog();
}

class _AcceptDialog extends State<AcceptDialog> {
  var contentsC = TextEditingController();
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
    return SingleChildScrollView(
      child: Container(
        width: 385,
        height: 600,
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
                "해당 ${widget.vo.type == "Portfolio" ? "포트폴리오 첨삭" : "이력서 첨삭"}을 \n 진행하기",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              buildTextField("첨삭 내용을 입력해주세요!", contentsC,
                  maxLine: 20, maxLength: 32500, multiLine: true, type: TextInputType.multiline),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    makeBtn(
                        msg: "아니요",
                        onPressed: () {
                          Navigator.pop(context,);
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
                        onPressed: _postAccept,
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
      ),
    );
  }

  _postAccept() async {
    if (contentsC.text.isEmpty) {
      snackBar("첨삭내용을 입력해주세요", context);
    } else {
      final pref = await SharedPreferences.getInstance();
      var token = pref.getString("accessToken");
      try {
        var res = await helper.postCorrectionApproval(
            token,
            {
              "classNumber": widget.vo.member.classNumber,
              "correctionContent": contentsC.text
            },
            widget.vo.index);
        if (res.success) {
          snackBar("첨삭을 완료했습니다.", context);
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
}
