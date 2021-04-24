import 'package:app_user/model/user.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/tag_add_req_dialog.dart';
import 'package:flutter/material.dart';

Widget buildDrawer(BuildContext context) {
  String role;

  role = User.role;
  print("User.role: ${role}");
  return Drawer(
    child: Column(
      mainAxisSize: MainAxisSize.max,
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
        customListTile(
            title: "협약업체",
            leading: Icon(
              Icons.assignment,
              color: Colors.grey,
              size: 28,
            ),
            page: "/contracting_company",
            context: context),
        customListTile(
            title: "취업공고",
            leading:
                Icon(Icons.account_box_outlined, color: Colors.grey, size: 28),
            page: "/company_notice",
            context: context),
        customListTile(
            title: "면접후기",
            leading: Icon(Icons.book, color: Colors.grey, size: 28),
            page: "/interview_review",
            context: context),
        role == "user"
            ? customListTile(
                title: "상담 신청",
                leading: Icon(Icons.account_box_outlined,
                    color: Colors.grey, size: 28),
                page: "/counseling_apply",
                context: context)
            : customListTile(
                title: "상담 관리",
                leading: Icon(
                  Icons.comment,
                  color: Colors.grey,
                  size: 28,
                ),
                page: "/counseling_manage",
                context: context),
        customListTile(
            title: "취업 확정 현황",
            leading: Icon(Icons.school, color: Colors.grey, size: 28),
            page: "/confirmation_status",
            context: context),
        customListTile(
            title: "공지사항",
            leading: Icon(Icons.calendar_today_outlined,
                color: Colors.grey, size: 28),
            page: "/notification",
            context: context),
        customListTile(
            title: "꿀팁 저장소",
            leading: Icon(Icons.thumb_up, color: Colors.grey, size: 28),
            page: "/tip_storage",
            context: context),
        role == "user"
            ? customListTile(
                title: "태그 추가 요청",
                leading: Icon(Icons.tag, color: Colors.grey, size: 28),
                page: "",
                context: context)
            : customListTile(
                title: "태그 추가 요청",
                leading: Icon(
                  Icons.tag,
                  color: Colors.grey,
                  size: 28,
                ),
                page: "/tag_list",
                context: context),
        role != "user"
            ? customListTile(
                title: "포트폴리오 첨삭",
                leading: Icon(
                  Icons.event_note_outlined,
                  color: Colors.grey,
                  size: 28,
                ),
                page: "/portfolio",
                context: context)
            : SizedBox(),
        role != "user"
            ? customListTile(
                title: "자기소개서 첨삭",
                leading: Icon(
                  Icons.sticky_note_2_outlined,
                  color: Colors.grey,
                  size: 28,
                ),
                page: "/introduction",
                context: context)
            : SizedBox(),
        Expanded(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  makeGradientBtn(
                      msg: "마이페이지",
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, "/my_page"),
                      mode: 1,
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  makeBtn(
                      msg: "로그아웃",
                      onPressed: () {},
                      mode: 1,
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget customListTile(
    {@required String title,
    @required Icon leading,
    @required String page,
    @required BuildContext context}) {
  return InkWell(
    onTap: () {
      page == ""
          ? showDialog(
              context: context,
              builder: (BuildContext context) => TagAddReqDialog())
          : Navigator.pushReplacementNamed(context, page);
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          leading,
          SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
