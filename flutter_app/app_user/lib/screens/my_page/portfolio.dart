import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: makeGradientBtn(
                  msg: "첨삭 요청하기",
                  onPressed: () {},
                  mode: 1,
                  icon: Icon(
                    Icons.outgoing_mail,
                    color: Colors.white,
                  )),
            ),
            Expanded(
                child: WebView(
              initialUrl:
                  "https://www.notion.so/An-Su-Bin-bf515c3c6eb34081b5f9b2c31457d7a2",
              javascriptMode: JavascriptMode.unrestricted,
            ))
          ],
        ),
      ),
    );
  }
}
