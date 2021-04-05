import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/tag.dart';

class CustomDialog extends StatefulWidget {
  final String msg, content;
  final Size size;
  final List<String> tag;
  bool isFavorite;

  CustomDialog({
    @required this.msg,
    @required this.content,
    @required this.size,
    @required this.tag,
    @required this.isFavorite,
  });

  @override
  _CustomDialog createState() => _CustomDialog();
}

class _CustomDialog extends State<CustomDialog> {


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
      height: widget.size.height,
      padding: EdgeInsets.only(
          top: Consts.padding,
          bottom: Consts.padding,
          left: Consts.padding,
          right: Consts.padding),
      margin: EdgeInsets.only(top: Consts.avataRadius),
      decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(Consts.padding-10),
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
              IconButton(
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
              ),
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
                  style: TextStyle(fontSize: 16,),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: makeTagWidget(tag: widget.tag, size: Size(360, 50), mode: 2)
          ),
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
