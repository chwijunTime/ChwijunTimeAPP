import 'package:app_user/screens/find_password_page.dart';
import 'package:app_user/screens/join_page.dart';
import 'package:app_user/screens/list_page/company_notice.dart';
import 'package:app_user/screens/list_page/confirmation_status.dart';
import 'package:app_user/screens/list_page/contracting_company.dart';
import 'package:app_user/screens/list_page/counseling_apply.dart';
import 'package:app_user/screens/list_page/counseling_manage.dart';
import 'package:app_user/screens/list_page/interview_review.dart';
import 'package:app_user/screens/list_page/introduction.dart';
import 'package:app_user/screens/list_page/notification.dart';
import 'package:app_user/screens/list_page/portfolio.dart';
import 'package:app_user/screens/list_page/tag_list.dart';
import 'package:app_user/screens/list_page/tip_storage.dart';
import 'package:app_user/screens/login_page.dart';
import 'package:app_user/screens/main_page.dart';
import 'package:app_user/screens/my_page/my_page.dart';
import 'package:app_user/screens/splash.dart';
import 'package:app_user/screens/success_join_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(UserApp());

class UserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChwijunTimeApp",
      initialRoute: "/splash",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ko', 'KR'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Nixgon',
      ),
      routes: {
        "/": (context) => MainPage(),
        "/splash": (context) => SplashPage(),
        "/login": (context) => LoginPage(),
        "/join": (context) => JoinPage(),
        "/success_join": (context) => SuccessJoinPage(),
        "/password_change": (context) => FindPasswordPage(),
        "/contracting_company": (context) => ContractingCompPage(),
        "/company_notice": (context) => CompanyNoticePage(),
        "/interview_review": (context) => InterviewReviewPage(),
        "/notification": (context) => NotificationPage(),
        "/confirmation_status": (context) => ConfirmationStatusPage(),
        "/counseling_apply": (context) => CounselingApplyPage(),
        "/tip_storage": (context) => TipStoragePage(),
        "/my_page": (context) => MyPage(),
        "/counseling_manage": (context) => CounselingManage(),
        "/tag_list" : (context) => TagList(),
        "/portfolio": (context) => PortfolioPage(),
        "/introduction": (context) => IntroductionPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
