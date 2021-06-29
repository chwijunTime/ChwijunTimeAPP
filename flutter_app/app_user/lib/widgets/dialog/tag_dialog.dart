import 'package:app_user/model/tag/tag_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class TagDialog extends StatefulWidget {
  String mode;
  int index;
  TagVO vo;

  TagDialog({this.mode, this.index});

  @override
  _TagDialogState createState() => _TagDialogState();
}

class _TagDialogState extends State<TagDialog> {
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
            height: widget.mode != "post" ? 224 : 214,
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
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: widget.mode == "post" ? "등록할 " : "수정할 ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  TextSpan(
                      text: "태그명",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4F9ECB))),
                  TextSpan(
                      text: "을 작성해주세요. ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ])),
                SizedBox(
                  height: 5,
                ),
                widget.index != null
                    ? FutureBuilder(
                        future: _getTag(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            widget.vo = snapshot.data;
                            return Text(
                              "기존 태그명: ${widget.vo.name}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            );
                          } else {
                            return SizedBox();
                          }
                        })
                    : SizedBox(),
                SizedBox(
                  height: 5,
                ),
                buildTextField("태그명", titleC, autoFocus: false),
                SizedBox(
                  height: 10,
                ),
                makeGradientBtn(
                    msg: widget.mode == "post" ? "등록하기" : "수정하기",
                    onPressed: () {
                      widget.mode == "post" ? postTag() : modifyTag();
                    },
                    mode: 1,
                    icon: Icon(
                      Icons.note_add,
                      color: Colors.white,
                    ))
              ],
            ))));
  }

  Future<TagVO> _getTag() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getTag(widget.index);
      print("res.success: ${res.success}");
      if (res.success) {
        return res.data;
      } else {
        return null;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  postTag() async {
    if (titleC.text.isEmpty) {
      snackBar("태그명을 입력해주세요!", context);
    } else {
      helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
        setState(() {});
      }));
      try {
        var res = await helper.postTag(TagVO(name: titleC.text).toJson());
        if (res.success) {
          Navigator.pop(context, true);
          snackBar("성공적으로 태그가 추가되었습니다.", context);
        } else {
          Navigator.pop(context, false);
          snackBar(res.msg, context);
          print("error: ${res.msg}");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  modifyTag() async {
    if (titleC.text.isEmpty) {
      snackBar("태그명을 입력해주세요", context);
    } else {
      helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
        setState(() {});
      }));
      try {
        var res = await helper.putTag(
            widget.index, TagVO(name: titleC.text).toJson());
        if (res.success) {
          Navigator.pop(context, true);
          snackBar("성공적으로 태그가 수정되었습니다.", context);
        } else {
          Navigator.pop(context, false);
          snackBar(res.msg, context);
          print("error: ${res.msg}");
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
