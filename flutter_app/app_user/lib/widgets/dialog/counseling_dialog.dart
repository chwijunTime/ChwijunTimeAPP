import 'package:app_user/model/counseling_vo.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CounselingDialog extends StatefulWidget {
  CounselingVO list;
  int index;

  CounselingDialog({@required this.index});

  @override
  _CounselingDialogState createState() => _CounselingDialogState();
}

class _CounselingDialogState extends State<CounselingDialog> {
  @override
  build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: widget.list.done
          ? dialogDeadline(context)
          : dialogProceeding(context),
    );
  }

  dialogProceeding(BuildContext context) {
    return Container(
      width: 311,
      height: 233,
      padding: EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.list.date}, ${widget.list.time}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(
            widget.list.place,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Expanded(
              child: Center(
            child: Text(
              "해당 상담은 아직 신청자가 없습니다.",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          )),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 48,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(color: Color(0xff5BC7F5))),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  "진행중",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff5BC7F5)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  dialogDeadline(BuildContext context) {
    return Container(
      width: 311,
      height: 320,
      padding: EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.list.date}, ${widget.list.time}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.list.place,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  widget.list.user,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                width: 48,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    border: Border.all(color: Color(0xffFF7777))),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    "마감",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffFF7777)),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "신청이유",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: AutoSizeText(
              widget.list.reason,
              maxLines: 8,
              minFontSize: 14,
              style: TextStyle(fontSize: 14),
            ),
          ),
          makeTagWidget(tag: widget.list.tag, size: Size(360, 24), mode: 1)
        ],
      ),
    );
  }
}
