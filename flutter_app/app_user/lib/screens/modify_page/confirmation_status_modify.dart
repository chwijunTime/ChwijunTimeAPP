import 'package:app_user/model/confirmation_status_vo.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../search_page.dart';

class ConfirmationStatusModify extends StatefulWidget {
  ConfirmationStatusVO list;

  ConfirmationStatusModify({@required this.list});

  @override
  _ConfirmationStatusModifyState createState() => _ConfirmationStatusModifyState();
}

class _ConfirmationStatusModifyState extends State<ConfirmationStatusModify> {
  var titleC = TextEditingController();
  var siteUrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      titleC.text = widget.list.title;
      siteUrl.text = widget.list.siteUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임"),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 33, left: 33, top: 24),
              child: buildTextField("업체명", titleC),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 33, left: 33, top: 10),
              child: Row(
                children: [
                  Container(
                    child: Text("${widget.list.grade}학년"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: buildTextField("회사 사이트 주소", siteUrl),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 33, left: 33, top: 10),
              child:  Text(widget.list.area),
            ),
            Padding(
              padding: EdgeInsets.only(right: 33, left: 33, top: 10),
              child: Text(widget.list.address),
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
                      widget.list.etc == null ? Text("비고를 작성하지 않았습니다."):
                      Text(widget.list.etc)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
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
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  onStatusModify() {
    if (titleC.text.isEmpty ||
        siteUrl.text.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      var conf = ConfirmationStatusVO(title: titleC.text, grade: widget.list.grade, area: widget.list.area, siteUrl: siteUrl.text, address: widget.list.address, etc: widget.list.etc);
      print(conf.toString());

      Navigator.pop(context);
    }
  }
}
