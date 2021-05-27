import 'package:app_user/model/tip/tip_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TipStorageWrite extends StatefulWidget {
  @override
  _TipStorageWriteState createState() => _TipStorageWriteState();
}

class _TipStorageWriteState extends State<TipStorageWrite> {
  RetrofitHelper helper;

  var titleC = TextEditingController();
  var addressC = TextEditingController();
  var tipC = TextEditingController();
  List<String> tagList = [];


  @override
  void initState() {
    super.initState();
    initRetrofit();
  }

  @override
  void dispose() {
    titleC.dispose();
    addressC.dispose();
    tipC.dispose();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 34, right: 34, top: 24),
          child: ListView(
            children: [
              buildTextField("회사명", titleC, autoFocus: false),
              SizedBox(
                height: 10,
              ),
              buildTextField("회사주소", addressC, autoFocus: false),
              SizedBox(
                height: 24,
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "꿀팁 정보를 공유해 주세요.",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      buildTextField("이곳에 작성하면 됩니당", tipC,
                          maxLine: 10, maxLength: 500, autoFocus: false, multiLine: true, type: TextInputType.multiline)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: makeBtn(
                    msg: "태그 선택하러 가기",
                    onPressed: () async {
                      final result = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SearchPage()));
                      setState(() {
                        if (result != null) {
                          tagList = result;
                        }
                      });
                      print("tagList: $tagList");
                    },
                    mode: 2),
              ),
              Align(
                  alignment: Alignment.center,
                  child: makeTagWidget(
                      tag: tagList, size: Size(360, 27), mode: 1)),
              SizedBox(height: 20,),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "허위 정보를 기록하지 말아주세요!",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 12),
                  )),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: makeGradientBtn(
                    msg: "둥록하기",
                    onPressed: _postTip,
                    mode: 4,
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }

  _postTip() async {
    if (titleC.text.isEmpty || addressC.text.isEmpty || tipC.text.isEmpty || tagList.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요.", context);
    } else {
      final pref =
      await SharedPreferences.getInstance();
      var token = pref.getString("accessToken");
      TipVO vo = TipVO(tag: tagList, tipInfo: tipC.text, address: addressC.text, title: titleC.text);
      try {
        var res = await helper.postTip(token, vo.toJson());
        if (res.success) {
          snackBar("등록되었습니다", context);
          Navigator.pop(context);
        } else {
          print("err: ${res.msg}");
          snackBar(res.msg, context);
        }
      } catch (e) {
        print("error: $e");
      }
    }

  }
}
