import 'package:app_user/screens/search_page.dart';
import 'package:flutter/material.dart';

class BackButtonWidget {
  static DateTime currentBackPressTime;

  static Widget backButtonWidget({@required Widget child, @required BuildContext context}) {
    print("호잇: ${currentBackPressTime}");
    return WillPopScope(child: child, onWillPop: () async {
        bool result = _isEnd(context);
        return await Future.value(result);
      }
    );
  }

  static _isEnd(BuildContext context) {
    DateTime now = DateTime.now();
    print("now: ${now}, currTime: ${currentBackPressTime}");
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      snackBar("뒤로가기 버튼을 한번 더 누르면 종료됩니다.", context);
      return false;
    }
    return true;
  }
}