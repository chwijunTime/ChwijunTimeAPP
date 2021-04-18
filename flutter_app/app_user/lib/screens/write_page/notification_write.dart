import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class NotificationWrite extends StatefulWidget {
  @override
  _NotificationWriteState createState() => _NotificationWriteState();
}

class _NotificationWriteState extends State<NotificationWrite> {
  var titleC = TextEditingController();
  var contentsC = TextEditingController();
  List<String> tagList = [];
  List<String> _list = [];

  init() {
    _list.add("Google");
    _list.add("IOS");
    _list.add("Android");
    _list.add("Dart");
    _list.add("Flutter");
    _list.add("Python");
    _list.add("React");
    _list.add("Xamarin");
    _list.add("Kotlin");
    _list.add("Java");
    _list.add("RxAndroid");
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar("취준타임"),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(right: 34, left: 34, top: 24),
          child: Column(
            children: [
              buildTextField("제목", titleC),
              SizedBox(height: 24,),
              buildTextField("공지사항 내용을 입력해주세요.", contentsC, maxLine: 16, maxLength: 1000),
              SizedBox(height: 24,),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage(
                                list: _list,
                              )));
                      setState(() {
                        if (result.isEmpty) {
                          tagList = [];
                        } else {
                          tagList = result;
                        }
                      });
                      print("tagList: $tagList");
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25, top: 16, bottom: 16),
                          child: Text(
                            "태그 선택하러 가기",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Align(
                    alignment: Alignment.center,
                    child: makeTagWidget(
                        tag: tagList, size: Size(360, 27), mode: 1)),
              ),
              SizedBox(height: 19,),
              makeGradientBtn(
                  msg: "등록하기",
                  onPressed: () {
                    _onNotificationPost();
                  },
                  mode: 4,
                  icon: Icon(
                    Icons.note_add,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _onNotificationPost() {
    if(titleC.text.isEmpty || contentsC.text.isEmpty || tagList.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      Navigator.pop(context);
    }
  }
}
