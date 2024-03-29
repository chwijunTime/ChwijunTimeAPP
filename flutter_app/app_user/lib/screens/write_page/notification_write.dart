import 'package:app_user/model/notice/s_notice_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class NotificationWrite extends StatefulWidget {
  @override
  _NotificationWriteState createState() => _NotificationWriteState();
}

class _NotificationWriteState extends State<NotificationWrite> {
  var titleC = TextEditingController();
  var contentsC = TextEditingController();

  RetrofitHelper helper;

  @override
  void dispose() {
    titleC.dispose();
    contentsC.dispose();
    super.dispose();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTextField("제목", titleC),
              SizedBox(
                height: 24,
              ),
              buildTextField("공지사항 내용을 입력해주세요.", contentsC,
                  maxLine: 15,
                  maxLength: 20000,
                  multiLine: true,
                  type: TextInputType.multiline),
              SizedBox(
                height: 19,
              ),
              makeGradientBtn(
                  msg: "등록하기",
                  onPressed: () {
                    _onNotificationPost();
                  },
                  mode: 4,
                  icon: Icon(
                    Icons.note_add,
                    color: Colors.white,
                  )),
              SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }

  _onNotificationPost() async {
    if (titleC.text.isEmpty || contentsC.text.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      SNoticeVO vo = SNoticeVO(title: titleC.text, content: contentsC.text);
      helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
        setState(() {});
      }));
      print(vo.toJson());
      try {
        final res = await helper.postNotice(vo.toJson());
        if (res.success) {
          Navigator.pop(context, true);
        } else {
          print("error: ${res.msg}");
        }
      } catch (e) {
        print("error!: ${e}");
      }
    }
  }
}
