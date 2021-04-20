import 'package:app_user/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowWebView extends StatefulWidget {
  final String url;

  ShowWebView({@required this.url});

  @override
  _ShowWebViewState createState() => _ShowWebViewState();
}

class _ShowWebViewState extends State<ShowWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임"),
      body: SafeArea(
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
