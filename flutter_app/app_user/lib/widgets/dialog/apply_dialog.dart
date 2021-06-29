import 'package:app_user/model/comp_notice/comp_apply_status_vo.dart';
import 'package:app_user/model/comp_notice/comp_status_detail_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/show_web_view.dart';
import 'package:app_user/widgets/button.dart';
import 'package:flutter/material.dart';

class ApplyDialog extends StatefulWidget {
  CompStatusDetailVO vo;
  CompApplyStatusVO statusVo;
  int index;

  ApplyDialog({@required this.index, @required this.statusVo});

  @override
  _ApplyDialog createState() => _ApplyDialog();
}

class _ApplyDialog extends State<ApplyDialog> {
  RetrofitHelper helper;

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
      height: 200,
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
          child: FutureBuilder(
        future: _getApply(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            widget.vo = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${widget.vo.data.member.classNumber}_${widget.vo.data.compNotice.title} 신청",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowWebView(
                                      url: widget.vo.data.githubUrl)));
                        },
                        child: Text(
                          "해당 github 바로 보기",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff5bc7f5)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowWebView(
                                      url: widget.vo.data.resumeUrl)));
                        },
                        child: Text(
                          "해당 이력서 바로 보기",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff5bc7f5)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowWebView(
                                      url: widget.vo.data.portfolioUrl)));
                        },
                        child: Text(
                          "해당 포트폴리오 바로 보기",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff5bc7f5)),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: widget.vo.data.status == "Wait"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            makeGradientBtn(
                                msg: "요청 승인",
                                onPressed: _postAccept,
                                mode: 5,
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            makeGradientBtn(
                                msg: "요청 거절",
                                onPressed: _postReject,
                                mode: 5,
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.white,
                                )),
                          ],
                        )
                      : Text(
                          '이미 ${widget.vo.data.status == "Approve" ? "승인" : "거절"}된 요청입니다.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }

  Future<CompStatusDetailVO> _getApply() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getCompApplyStatus(widget.index);
      if (res.success) {
        return res.data;
      } else {
        print("error: ${res.msg}");
      }
    } catch (e) {
      print("err: $e");
    }
  }

  _postAccept() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.postCompNoticeAcc(widget.index);
      if (res.success) {
        snackBar("수락되었습니다.", context);
      } else {
        print("error: ${res.msg}");
        snackBar(res.msg, context);
      }
      Navigator.pop(context);
    } catch (e) {
      print("err: $e");
    }
  }

  _postReject() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.postCompNoticeRej(widget.index);
      if (res.success) {
        snackBar("거절되었습니다.", context);
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
