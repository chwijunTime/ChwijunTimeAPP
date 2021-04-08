import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/tag.dart';

import '../detail_page/company_notice_detail.dart';

class CompanyNoticePage extends StatefulWidget {
  @override
  _CompanyNoticePageState createState() => _CompanyNoticePageState();

  final List<CompNotice> notiList = [];
}

class _CompanyNoticePageState extends State<CompanyNoticePage> {
  @override
  void initState() {
    super.initState();
    initList();
  }

  initList() {
    for (int i = 0; i < 8; i++) {
      widget.notiList.add(CompNotice(
          title: "${i}.title",
          startDate: "2021.03.31",
          endDate: "2021.04.01",
          field: "모바일 앱, 웹",
          address: "광주광역시 광산구 목련로 273번길 76",
          compInfo:
              "printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it ",
          preferentialInfo:
              "우대 조건 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it ",
          isBookMark: false,
          tag: List.generate(10, (i) => "${i}.tag")));
    }
  }

  _onBookMarkPressed(int index) {
    setState(() {
      widget.notiList[index].isBookMark = !widget.notiList[index].isBookMark;
      print(widget.notiList[index].isBookMark);
    });
  }

  @override
  Widget build(BuildContext context) {
    initList();
    return Scaffold(
      appBar: buildAppBar("appBar"),
      drawer: buildDrawer(context),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "취준타임",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0x832B8AC0)),
                  ),
                  Text(
                    "취업 공고",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            ListView.builder(
              itemCount: widget.notiList.length,
              itemBuilder: (context, index) {
                return buildItemCompany(context, index);
              },
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItemCompany(BuildContext context, int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CompanyNoticeDetailPage(list: widget.notiList[index] )));
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${widget.notiList[index].title}",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                  ),
                  IconButton(
                    icon: widget.notiList[index].isBookMark
                        ? Icon(
                            Icons.bookmark,
                            size: 28,
                            color: Color(0xff4687FF),
                          )
                        : Icon(
                            Icons.bookmark_border,
                            size: 28,
                          ),
                    onPressed: () => _onBookMarkPressed(index),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Container(
                  height: 60,
                  child: AutoSizeText(
                    "${widget.notiList[index].compInfo}, ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    minFontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 22,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: List.generate(2, (indextag) {
                        return buildItemTag(
                            widget.notiList[index].tag, indextag);
                      }),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.blue[400],
                          )),
                      child: Center(
                        child: Text(
                          "외 ${widget.notiList[index].tag.length - 2}개",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "마감일: ${widget.notiList[index].endDate}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CompNotice {
  String title;
  String startDate, endDate;
  String field;
  String address;
  String compInfo;
  String preferentialInfo;
  String etc;
  bool isBookMark;
  List<String> tag;

  CompNotice(
      {@required this.title,
      @required this.startDate,
      @required this.endDate,
      @required this.field,
      @required this.address,
      @required this.compInfo,
      @required this.preferentialInfo,
      this.etc = "",
      @required this.isBookMark,
      @required this.tag});
}
