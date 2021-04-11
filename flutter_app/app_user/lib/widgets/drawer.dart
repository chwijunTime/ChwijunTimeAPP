import 'package:app_user/widgets/dialog/tag_add_req_dialog.dart';
import 'package:flutter/material.dart';
import 'package:app_user/widgets/button.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff4FB8F3),
                    Color(0xff9342FA),
                    Color(0xff2400FF)
                  ])),
          padding: EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "3210 안수빈님!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "취준타임",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "과 함께 취업 준비해요",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  )
                ],
              ),
            ],
          ),
        ),
        ListTile(
          title: Text(
            "협약업체",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: Icon(Icons.assignment),
          onTap: () {
            print("협약 업체로 가자");
            Navigator.pushNamedAndRemoveUntil(context, "/contracting_company", (route) => false);
            // Navigator.pushNamed(context, "/contracting_company");
          },
        ),
        ListTile(
          title: Text(
            "취업공고",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: Icon(Icons.account_box_outlined),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, "/company_notice", (route) => false);
          },
        ),
        ListTile(
          title: Text(
            "면접후기",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: Icon(Icons.book),
          onTap: () {
            print("면접후기로 가자");
            Navigator.pushNamedAndRemoveUntil(context, "/interview_review", (route) => false);
          },
        ),
        ListTile(
          title: Text(
            "상담신청",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: Icon(Icons.comment),
          onTap: () {
            print("상담신청으로 가자");
          },
        ),
        ListTile(
          title: Text(
            "취업 확정 현황",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: Icon(Icons.school),
          onTap: () {
            print("취업 확정 현황으로 가자");
          },
        ),
        ListTile(
          title: Text(
            "공지사항",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: Icon(Icons.calendar_today_outlined),
          onTap: () {
            print("공지사항으로 가자");
            Navigator.pushNamedAndRemoveUntil(context, "/notification", (route) => false);
          },
        ),
        ListTile(
          title: Text(
            "꿀팁 저장소",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: Icon(Icons.thumb_up),
          onTap: () {
            print("꿀팁 저장소로 가자");
          },
        ),
        ListTile(
          title: Text(
            "태그 추가 요청",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: Icon(Icons.tag),
          onTap: () {
            print("태그 추가 요청 하자");
            showDialog(context: context, builder: (BuildContext context) => TagAddReqDialog());
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 80, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              makeGradientBtn(msg: "마이페이지", onPressed: () => print("마이페이지 눌림"), mode: 1, icon: Icon(Icons.person, color: Colors.white,)),
              SizedBox(
                height: 8,
              ),
              makeBtn(msg: "로그아웃", onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false), mode: 1, icon: Icon(Icons.exit_to_app, color: Colors.white,))
            ],
          ),
        ),
      ],
    ),
  );
}
