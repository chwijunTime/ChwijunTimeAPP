import 'package:app_user/model/comp_notice/comp_notice_vo.dart';
import 'package:app_user/model/comp_notice/post_apply_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ApplyWriteDialog extends StatefulWidget {
  CompNoticeVO vo;

  ApplyWriteDialog({
    @required this.vo,
  });

  @override
  _ApplyWriteDialog createState() => _ApplyWriteDialog();
}

class _ApplyWriteDialog extends State<ApplyWriteDialog> {
  RetrofitHelper helper;
  var portfolioC = TextEditingController();
  var resumeC = TextEditingController();
  var githubC = TextEditingController();

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
    return Container(
      width: 385,
      height: 340,
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "${widget.vo.title}에 지원 신청하기",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildTextField("포트폴리오 URL", portfolioC),
            SizedBox(height: 10,),
            buildTextField("이력서 URL", resumeC),
            SizedBox(height: 10,),
            buildTextField("GitHub URL", githubC),
            SizedBox(height: 10,),
            makeGradientBtn(msg: "지원 신청하기", onPressed: _postApply, mode: 1)
          ],
        ),
      ),
    );
  }

  _postApply() async {
    if (portfolioC.text.isEmpty || resumeC.text.isEmpty || githubC.text.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
        setState(() {});
      }));
      try {
        var vo = PostApplyVO(portfolioURL: portfolioC.text, resumeURL: resumeC.text, gitHubURL: githubC.text);
        var res = await helper.postCompApply(widget.vo.index, vo.toJson());
        if (res.success) {
          snackBar("성공적으로 지원 신청했습니다.", context);
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          snackBar(res.msg, context);
        }
      } catch (e) {
        print("error: $e");
      }
    }
  }
}
