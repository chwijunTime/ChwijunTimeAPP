import 'package:app_user/model/tag/tag_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class PortfolioResumeDialog extends StatefulWidget {
  String mode;
  TagVO vo;

  PortfolioResumeDialog({this.mode});

  @override
  _PortfolioResumeDialogState createState() => _PortfolioResumeDialogState();
}

class _PortfolioResumeDialogState extends State<PortfolioResumeDialog> {
  RetrofitHelper helper;

  var titleC = TextEditingController();

  @override
  void dispose() {
    titleC.dispose();
    super.dispose();
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
            height: 190,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 0),
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
                  textAlign: TextAlign.center,
                    text: TextSpan(children: [
                  TextSpan(
                      text: "등록할 ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  TextSpan(
                      text:
                          '${widget.mode == "portfolio" ? "포트폴리오" : "이력서"} URL을',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4F9ECB))),
                  TextSpan(
                      text: "\n작성해주세요. ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ])),
                SizedBox(
                  height: 5,
                ),
                buildTextField(
                    "${widget.mode == "portfolio" ? "포트폴리오" : "이력서"} URL",
                    titleC,
                    autoFocus: false),
                SizedBox(
                  height: 10,
                ),
                makeGradientBtn(
                    msg: "등록하기",
                    onPressed: () {
                      widget.mode == "portfolio"
                          ? postPortfolio()
                          : postResume();
                    },
                    mode: 1,
                    icon: Icon(
                      Icons.note_add,
                      color: Colors.white,
                    ))
              ],
            ))));
  }

  postPortfolio() async {
    if (titleC.text.isEmpty) {
      snackBar("URL 입력해주세요.", context);
    } else {
      helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
        setState(() {});
      }));
      try {
        var res =
        await helper.postPortfolio({"notionPortfolioURL": titleC.text});
        if (res.success) {
          Navigator.pop(context);
          snackBar("포트폴리오를 등록했습니다.", context);
        } else {
          print("error: ${res.msg}");
          snackBar(res.msg, context);
          Navigator.pop(context);
        }
      } catch (e) {
        print("err: $e");
      }
    }
  }

  postResume() async {
    if (titleC.text.isEmpty) {
      snackBar("URL 입력해주세요.", context);
    } else {
      helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
        setState(() {});
      }));
      try {
        var res =
        await helper.postResume({"resumeFileURL": titleC.text});
        if (res.success) {
          Navigator.pop(context);
          snackBar("포트폴리오를 등록했습니다.", context);
        } else {
          print("error: ${res.msg}");
          snackBar(res.msg, context);
          Navigator.pop(context);
        }
      } catch (e) {
        print("err: $e");
      }
    }
  }
}
