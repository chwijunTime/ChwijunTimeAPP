import 'package:app_user/model/apply_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/screens/list_page/company_notice.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/apply_dialog.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/dialog/tag_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:flutter/material.dart';

class CompanyNoticeApply extends StatefulWidget {
  CompNotice list;

  CompanyNoticeApply({@required this.list});

  @override
  _CompanyNoticeApplyState createState() => _CompanyNoticeApplyState();
}

class _CompanyNoticeApplyState extends State<CompanyNoticeApply> {
  List<ApplyVO> applyList = [];

  initList() {
    for (int i = 0; i < 15; i++) {
      applyList.add(ApplyVO(
          user: "3210안수빈",
          portfolio: "https://www.naver.com/",
          introduction: "https://www.naver.com/",
          status: "notDone"));
    }
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      drawer: buildDrawer(context),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(26),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.list.title,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,),
                  ),
                  Text(
                    "에 지원한 학생들",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: applyList.length,
                itemBuilder: (context, index) {
                  return buildTag(context, index);
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  );
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTag(BuildContext context, int index) {
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: InkWell(
        onTap: () {
          showDialog(context: context, builder: (BuildContext context) => ApplyDialog(vo: applyList[index]));
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                "${applyList[index].user}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    ));
  }
}
