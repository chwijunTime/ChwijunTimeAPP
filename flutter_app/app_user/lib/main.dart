import 'file:///D:/ChwijunTime/flutter_app/app_user/lib/screens/list_page/company_notice.dart';
import 'file:///D:/ChwijunTime/flutter_app/app_user/lib/screens/list_page/contracting_company.dart';
import 'package:app_user/screens/find_acount_page.dart';
import 'package:app_user/screens/join_page.dart';
import 'package:app_user/screens/login_page.dart';
import 'package:app_user/screens/main_page.dart';
import 'package:app_user/screens/success_join_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(UserApp());

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
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
