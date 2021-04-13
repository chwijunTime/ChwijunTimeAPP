import 'package:app_user/model/tip_storage_vo.dart';
import 'package:app_user/screens/modify_page/tip_storage_modify.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:flutter/material.dart';

class TipStorageDetail extends StatefulWidget {
  TipVO list;


  TipStorageDetail({@required this.list});

  @override
  _TipStorageDetailState createState() => _TipStorageDetailState();
}

class _TipStorageDetailState extends State<TipStorageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임"),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 24),
          child: ListView(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                child: Padding(padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.list.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                    Text("주소: ${widget.list.address}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
                  ],
                ),),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "꿀팁 정보",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(widget.list.tip,
                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              widget.list.isMine ?
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        makeGradientBtn(
                              msg: "수정하기",
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TipStorageModify(list: widget.list)));
                              },
                              mode: 1,
                              icon: Icon(
                                Icons.note_add,
                                color: Colors.white,)),
                        makeGradientBtn(
                            msg: "삭제하기",
                            onPressed: () {},
                            mode: 1,
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,))
                      ],
                    ),
                  ): SizedBox(),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
