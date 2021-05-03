import 'package:app_user/model/confirmation/confirmation_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationStatusModify extends StatefulWidget {
  ConfirmationVO list;
  int index;

  ConfirmationStatusModify({@required this.index});

  @override
  _ConfirmationStatusModifyState createState() =>
      _ConfirmationStatusModifyState();
}

class _ConfirmationStatusModifyState extends State<ConfirmationStatusModify> {
  RetrofitHelper helper;

  var titleC = TextEditingController();
  var siteUrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      titleC.text = widget.list.title;
      siteUrl.text = widget.list.siteUrl;
    });
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
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              margin: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 25,
              ),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 20, right: 20, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "지역: ${widget.list.area}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.list.address,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24,),
            Center(
                child: Text(
              "업체명과 사이트 url만 변경이 가능합니다.",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            )),
            Padding(
              padding: const EdgeInsets.only(right: 33, left: 33, top: 24),
              child: buildTextField("업체명", titleC),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 33, left: 33, top: 10),
              child: buildTextField("회사 사이트 주소", siteUrl),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              margin: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 25,
              ),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "비고",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      widget.list.etc == null
                          ? Text("비고를 작성하지 않았습니다.")
                          : Text(widget.list.etc)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  EdgeInsets.only(right: 33, left: 33, top: 10, bottom: 30),
              child: makeGradientBtn(
                  msg: "수정하기",
                  onPressed: () {
                    onStatusModify();
                  },
                  mode: 4,
                  icon: Icon(
                    Icons.note_add,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  onStatusModify() async {
    if (titleC.text.isEmpty || siteUrl.text.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      var vo = ConfirmationVO(
          title: titleC.text,
          area: widget.list.area,
          siteUrl: siteUrl.text,
          address: widget.list.address,
          etc: widget.list.etc);

      try {
        final pref = await SharedPreferences.getInstance();
        var token = pref.getString("accessToken");
        var res = await helper.putConf(token, widget.index, vo.toJson());
        if (res.success) {
          Navigator.pop(context, true);
        } else {
          snackBar("서버 에러", context);
          print("error: ${res.msg}");
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
