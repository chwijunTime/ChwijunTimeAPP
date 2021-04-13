import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class TipStorageWrite extends StatefulWidget {
  @override
  _TipStorageWriteState createState() => _TipStorageWriteState();
}

class _TipStorageWriteState extends State<TipStorageWrite> {
  var titleC = TextEditingController();
  var addressC = TextEditingController();
  var tipC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임"),
      drawer: buildDrawer(context),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 34, right: 34, top: 24),
          child: ListView(
            children: [
              buildTextField("회사명", titleC, autoFocus: false),
              SizedBox(
                height: 10,
              ),
              buildTextField("회사주소", addressC, autoFocus: false),
              SizedBox(
                height: 24,
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
                        "꿀팁 정보를 공유해 주세요.",
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
                    msg: "둥륵하기",
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
