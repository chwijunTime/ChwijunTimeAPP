import 'package:app_user/model/notice/member_vo.dart';
import 'package:app_user/model/notice/notification_vo.dart';
import 'package:app_user/model/notice/s_notice_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationWrite extends StatefulWidget {
  @override
  _NotificationWriteState createState() => _NotificationWriteState();
}

class _NotificationWriteState extends State<NotificationWrite> {
  var titleC = TextEditingController();
  var contentsC = TextEditingController();
  List<String> tagList = [];
  List<String> _list = [];

  RetrofitHelper helper;

  init() {
    _list.add("Google");
    _list.add("IOS");
    _list.add("Android");
    _list.add("Dart");
    _list.add("Flutter");
    _list.add("Python");
    _list.add("React");
    _list.add("Xamarin");
    _list.add("Kotlin");
    _list.add("Java");
    _list.add("RxAndroid");
  }

  @override
  void initState() {
    super.initState();
    init();
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
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(right: 34, left: 34, top: 24),
          child: Column(
            children: [
              buildTextField("제목", titleC),
              SizedBox(height: 24,),
              buildTextField("공지사항 내용을 입력해주세요.", contentsC, maxLine: 16, maxLength: 1000),
              SizedBox(height: 24,),
              makeBtn(msg: "태그 선택하러 가기", onPressed: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage(
                          list: _list,
                        )));
                setState(() {
                  if (result != null) {
                    tagList = result;
                  }
                });
                print("tagList: $tagList");
              }, mode: 1),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Align(
                    alignment: Alignment.center,
                    child: makeTagWidget(
                        tag: tagList, size: Size(360, 27), mode: 1)),
              ),
              SizedBox(height: 19,),
              makeGradientBtn(
                  msg: "등록하기",
                  onPressed: () {
                    _onNotificationPost();
                  },
                  mode: 4,
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

  _onNotificationPost() async {
    if(titleC.text.isEmpty || contentsC.text.isEmpty || tagList.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      SNoticeVO vo = SNoticeVO(title: titleC.text, content: contentsC.text);
      final pref = await SharedPreferences.getInstance();
      var token = pref.getString("accessToken");
      print(vo.toJson());
      try {
        final res = await helper.postNotice(token, vo.toJson());
        if (res.success) {
          Navigator.pop(context, true);
        } else {
          print("error: ${res.msg}");
        }
      } catch(e) {
        print("error: ${e}");
      }

    }
  }
}
