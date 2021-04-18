import 'package:app_user/screens/find_password_page.dart';
import 'package:app_user/widgets/button.dart';
import 'package:flutter/material.dart';

class StdDialog extends StatefulWidget {
  final String msg;
  final Size size;
  Icon icon, btnIcon1, btnIcon2;
  String btnName1, btnName2;
  VoidCallback btnCall1, btnCall2;

  StdDialog(
      {@required this.msg,
      @required this.size,
      this.icon,
      this.btnIcon1,
      this.btnIcon2,
      this.btnName1,
      this.btnName2,
      this.btnCall1,
      this.btnCall2,});

  @override
  _StdDialog createState() => _StdDialog();
}

class _StdDialog extends State<StdDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.size.height,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 60),
      decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 1,
              offset: const Offset(0.0, 0.0),
            )
          ]),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.icon != null ? widget.icon : SizedBox(),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.msg,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.btnName1 != null
                      ? Row(
                        children: [
                          makeBtn(
                          msg: widget.btnName1,
                          onPressed: widget.btnCall1,
                          mode: 2,
                          icon: widget.btnIcon1),
                          SizedBox(width: 20,)
                        ],
                      )
                      : SizedBox(),
                  widget.btnName2 != null
                      ? makeGradientBtn(
                          msg: widget.btnName2,
                          onPressed: widget.btnCall2,
                          mode: 5,
                          icon: widget.btnIcon2)
                      : SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
