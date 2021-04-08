import 'package:app_user/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingPanel extends StatefulWidget {
  @override
  _SlidingPanelState createState() => _SlidingPanelState();
}

class _SlidingPanelState extends State<SlidingPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("title"),
      body: SlidingUpPanel(
        panel: Center(child: Text("향;ㅣ러밀"),),
        body: Center(child:  Text("호잇"),),
      ),
    );
  }
}
