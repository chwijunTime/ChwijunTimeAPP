import 'package:flutter/material.dart';

class FindIdDialog extends StatefulWidget {
  final String name, email;

  FindIdDialog(
      {@required this.name,
      @required this.email,});

  @override
  _FindIdDialogState createState() => _FindIdDialogState();
}

class _FindIdDialogState extends State<FindIdDialog> {
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
      width: 346,
      height: 138,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 60),
      decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              textAlign: TextAlign.center,
                text: TextSpan(
              children: [
                TextSpan(text: widget.name, style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Colors.black
                )),
                TextSpan(text: "님\n", style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5BC7F5)
                )),
                TextSpan(text: "아이디는 ", style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5BC7F5)
                )),
                TextSpan(text: widget.email,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
                )),
                TextSpan(text: "입니다", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff5BC7F5)
                )),
              ]
            ))
          ],
        ),
      ),
    );
  }
}