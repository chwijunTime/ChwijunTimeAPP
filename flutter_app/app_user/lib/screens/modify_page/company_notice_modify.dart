import 'package:app_user/screens/list_page/company_notice.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompanyNoticeModifyPage extends StatefulWidget {
  CompNotice list;

  CompanyNoticeModifyPage({@required this.list});

  @override
  _CompanyNoticeModifyPageState createState() =>
      _CompanyNoticeModifyPageState();
}

class _CompanyNoticeModifyPageState extends State<CompanyNoticeModifyPage> {
  var fieldC = TextEditingController();
  var infoC = TextEditingController();
  var preferentialInfoC = TextEditingController();
  var etcC = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      fieldC.text = widget.list.field;
      infoC.text = widget.list.compInfo;
      preferentialInfoC.text = widget.list.preferentialInfo;
      etcC.text = widget.list.etc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 25,
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.list.title,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "주소: ${widget.list.address}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "공고일: ${widget.list.startDate}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "마감일: ${widget.list.endDate}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
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
                          "회사 설명",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        buildTextField("회사 설명을 적어주세용", infoC,
                            maxLine: 10, maxLength: 500)
                      ],
                    ),
                  ),
                ),
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
                          "우대 조건",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        buildTextField("우대 조건을 적어주세용", preferentialInfoC,
                            maxLine: 10, maxLength: 500)
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                margin: EdgeInsets.all(25),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "기타",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        buildTextField("기타 설명을 적어주세요. (필수가 아닙니다.)", etcC,
                            maxLine: 10, maxLength: 500)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Align(
                    alignment: Alignment.center,
                    child: makeTagWidget(
                        tag: widget.list.tag, size: Size(360, 27), mode: 1)),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 34, left: 34, bottom: 25),
                child: makeGradientBtn(
                    msg: "수정하기",
                    onPressed: _onModify,
                    mode: 4,
                    icon: Icon(
                      Icons.note_add,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onModify() {
    if (
        fieldC.text.isEmpty ||
        infoC.text.isEmpty ||
        preferentialInfoC.text.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      CompNotice vo = CompNotice(
          title: widget.list.title,
          startDate: widget.list.startDate,
          endDate: widget.list.endDate,
          field: fieldC.text,
          address: widget.list.address,
          compInfo: infoC.text,
          preferentialInfo: preferentialInfoC.text,
          isBookMark: false,
          tag: widget.list.tag,
          etc: etcC.text.isEmpty ? "" : etcC.text);

      print(vo);
      Navigator.pop(context, vo);
    }
  }
}
