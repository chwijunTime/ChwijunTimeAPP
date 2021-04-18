import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class NotificationDialog extends StatefulWidget {
  final String msg, content;
  final Size size;
  final List<String> tag;
  String role;
  bool isFavorite;
  Icon icon;

  NotificationDialog({
    @required this.msg,
    @required this.content,
    @required this.size,
    @required this.tag,
    @required this.isFavorite,
    @required this.role,
    this.icon,
  });

  @override
  _NotificationDialog createState() => _NotificationDialog();
}

class _NotificationDialog extends State<NotificationDialog> {
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

  _onHeartPressed() {
    setState(() {
      widget.isFavorite = !widget.isFavorite;
    });
  }

  dialogContent(BuildContext context) {
    return Container(
      width: widget.size.width,
      height:
          widget.role == "user" ? widget.size.height : widget.size.height + 20,
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
            children: [
              Expanded(
                child: Text(
                  widget.msg,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              widget.role == "user"
                  ? IconButton(
                      icon: widget.isFavorite
                          ? Icon(
                              Icons.favorite,
                              size: 28,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.favorite_border_outlined,
                              size: 28,
                            ),
                      onPressed: () => _onHeartPressed(),
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 28,
                      ),
                      onPressed: () {}),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView(
              children: [
                AutoSizeText(
                  widget.content,
                  minFontSize: 16,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child:
                  makeTagWidget(tag: widget.tag, size: Size(360, 50), mode: 2)),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.bottomRight,
            child: makeGradientBtn(
                msg: "공지 사항 수정하기",
                onPressed: () {},
                mode: 2,
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 30.0;
  static const double avataRadius = 60.0;
}
