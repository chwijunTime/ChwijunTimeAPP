import 'package:app_user/model/tip_storage_vo.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class TipStorageModify extends StatefulWidget {
  TipVO list;


  TipStorageModify({@required this.list});

  @override
  _TipStorageModifyState createState() => _TipStorageModifyState();
}

class _TipStorageModifyState extends State<TipStorageModify> {
  var tipC = TextEditingController();

  @override
  void initState() {
    super.initState();
    tipC.text = widget.list.tip;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임"),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 34, right: 34, top: 24),
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
                        "꿀팁 정보를 수정해 주세요.",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      buildTextField("이곳에 작성하면 됩니당", tipC,
                          maxLine: 10, maxLength: 500, autoFocus: false)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "허위 정보를 기록하지 말아주세요!",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 12),
                  )),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: makeGradientBtn(
                    msg: "수정하기",
                    onPressed: () {},
                    mode: 4,
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    )),
              ),
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
