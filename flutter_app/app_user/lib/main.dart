import 'package:app_user/model/user.dart';
import 'package:app_user/screens/find_acount_page.dart';
import 'package:app_user/screens/join_page.dart';
import 'package:app_user/screens/list_page/company_notice.dart';
import 'package:app_user/screens/list_page/confirmation_status.dart';
import 'package:app_user/screens/list_page/contracting_company.dart';
import 'package:app_user/screens/list_page/counseling_apply.dart';
import 'package:app_user/screens/list_page/counseling_manage.dart';
import 'package:app_user/screens/list_page/interview_review.dart';
import 'package:app_user/screens/list_page/notification.dart';
import 'package:app_user/screens/list_page/tag_list.dart';
import 'package:app_user/screens/list_page/tip_storage.dart';
import 'package:app_user/screens/login_page.dart';
import 'package:app_user/screens/main_page.dart';
import 'package:app_user/screens/my_page.dart';
import 'package:app_user/screens/success_join_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(UserApp());
  var prefs = await SharedPreferences.getInstance();
  var role = prefs.getString("role") ?? "user";
  print("role, main: ${role}");
  User.role = role;
}

class UserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChwijunTimeApp",
      initialRoute: "/login",
      routes: {
        "/": (context) => MainPage(),
        "/contracting_company": (context) => ContractingCompPage(),
        "/company_notice": (context) => CompanyNoticePage(),
        "/login": (context) => LoginPage(),
        "/join": (context) => JoinPage(),
        "/success_join": (context) => SuccessJoinPage(),
        "/find_acount": (context) => FindAcountPage(),
        "/interview_review": (context) => InterviewReviewPage(),
        "/notification": (context) => NotificationPage(),
        "/confirmation_status": (context) => ConfirmationStatusPage(),
        "/counseling_apply": (context) => CounselingApplyPage(),
        "/tip_storage": (context) => TipStoragePage(),
        "/my_page": (context) => MyPage(),
        "/counseling_manage": (context) => CounselingManage(),
        "/tag_list" : (context) => TagList(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
