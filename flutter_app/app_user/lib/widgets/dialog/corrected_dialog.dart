import 'package:app_user/consts.dart';
import 'package:app_user/model/correction/corrected_vo.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CorrectedDialog extends StatefulWidget {
  CorrectedVO list;

  CorrectedDialog({this.list});

  @override
  _CorrectedDialog createState() => _CorrectedDialog();
}

class _CorrectedDialog extends State<CorrectedDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
        width: 320,
        height: 360,
        padding: EdgeInsets.only(
            top: Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding),
        margin: EdgeInsets.only(top: Consts.avataRadius),
        decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding - 10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 1,
                offset: const Offset(0.0, 0.0),
              )
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.list.classNumber}_${widget.list.type == "Portfolio" ? "포트폴리오 ${widget.list.portfolioIdx}" : "이력서 ${widget.list.resumeIdx}"}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                makeTag(widget.list.status)
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView(
                children: [
                  AutoSizeText(
                    "${widget.list.status == "Correction_Successful" ? widget.list.content : widget.list.rejectReason}",
                    minFontSize: 16,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget makeTag(String str) {
    String msg;
    Color color;

    if (str == "Correction_Successful") {
      msg = "완료함";
      color = Color(0xff5BC7F5);
    } else {
      msg = "거절함";
      color = Color(0xffFF7777);
    }

    return Container(
      width: 48,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: Border.all(color: color)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2, top: 2),
        child: Text(
          msg,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: color),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
