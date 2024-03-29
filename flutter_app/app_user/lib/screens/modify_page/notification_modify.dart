import 'package:app_user/model/notice/notification_vo.dart';
import 'package:app_user/model/notice/s_notice_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class NotificationModify extends StatefulWidget {
  NotificationVO list;

  NotificationModify({@required this.list});

  @override
  _NotificationModifyState createState() => _NotificationModifyState();
}

class _NotificationModifyState extends State<NotificationModify> {
  var titleC = TextEditingController();
  var contentsC = TextEditingController();

  RetrofitHelper helper;

  @override
  void initState() {
    super.initState();
    setState(() {
      titleC.text = widget.list.title;
      contentsC.text = widget.list.content;
    });
  }

  @override
  void dispose() {
    titleC.dispose();
    contentsC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar("취준타임", context),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(right: 34, left: 34, top: 24),
            child: Column(
              children: [
                buildTextField("제목", titleC, disable: true,),
                SizedBox(
                  height: 24,
                ),
                buildTextField("공지사항 내용을 입력해주세요.", contentsC,
                    maxLine: 15, maxLength: 20000, type: TextInputType.multiline, multiLine: true),
                SizedBox(
                  height: 24,
                ),
                makeGradientBtn(
                    msg: "수정하기",
                    onPressed: () {
                      _onNotificationModify();
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
      ),
    );
  }

  _onNotificationModify() async {
    if (contentsC.text.isEmpty || titleC.text.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
      print(widget.list.index);
      final res = await helper.putNotice(
          index: widget.list.index,
          noticeSaveDto:
              SNoticeVO(title: titleC.text, content: contentsC.text).toJson());
      if (res.success) {
        Navigator.pop(context, true);
      } else {
        Navigator.pop(context, false);
        snackBar(res.msg, context);
        print("e: ${res.msg}");
      }
    }
  }

  Future<bool> _onBackPressed() {
    Navigator.pop(context, false);
  }
}
