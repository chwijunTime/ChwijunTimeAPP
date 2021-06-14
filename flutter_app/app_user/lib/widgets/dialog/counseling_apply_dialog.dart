import 'package:app_user/model/consulting/consulting_admin_vo.dart';
import 'package:app_user/model/consulting/post_consulting_user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class CounselingApplyDialog extends StatefulWidget {
  ConsultingAdminVO list;

  CounselingApplyDialog(this.list);

  @override
  _CounselingApplyDialogState createState() => _CounselingApplyDialogState();
}

class _CounselingApplyDialogState extends State<CounselingApplyDialog> {
  var nameC = TextEditingController();
  var classNumber = TextEditingController();

  RetrofitHelper helper;

  @override
  void initState() {
    super.initState();
    initRetrofit();
  }

  @override
  void dispose() {
    nameC.dispose();
    classNumber.dispose();
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
    var tempDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(widget.list.applyDate);
    var strDate = DateFormat("yyyy년 MM월 dd일 HH시 mm분").format(tempDate);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: 340,
        height: 300,
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
              Text(
                strDate,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text("상담신청하기"),
              SizedBox(
                height: 20,
              ),
              buildTextField("이름", nameC,
                  autoFocus: false, type: TextInputType.name),
              SizedBox(
                height: 10,
              ),
              buildTextField("학번", classNumber, type: TextInputType.number, autoFocus: false),
              SizedBox(
                height: 20,
              ),
              makeGradientBtn(
                  msg: "신청하기",
                  onPressed: postConsultingApply,
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

  postConsultingApply() async {
    if (nameC.text.isEmpty || classNumber.text.isEmpty) {
      snackBar("이름과 학번을 입력해주세요.", context);
    } else {
      final pref = await SharedPreferences.getInstance();
      var token = pref.getString("accessToken");
      var res = await helper.postConsultingUser(
          token,
          widget.list.index,
          PostConsultingUser(classNumber: classNumber.text, name: nameC.text)
              .toJson());
      if (res.success) {
        snackBar("성공적으로 신청했습니다!", context);
        Navigator.pop(context);
      } else {
        snackBar(res.msg, context);
        print("error: ${res.msg}");
      }
    }
  }
}
