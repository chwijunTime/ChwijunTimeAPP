import 'package:app_user/model/counseling_vo.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class CounselingApplyDetail extends StatefulWidget {
  CounselingVO list;

  CounselingApplyDetail({this.list});

  @override
  _CounselingApplyDetailState createState() => _CounselingApplyDetailState();
}

class _CounselingApplyDetailState extends State<CounselingApplyDetail> {
  var reasonC = TextEditingController();

  List<String> _list = [];
  List<String> tagList = [];

  initList() {
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
    initList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임"),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              margin: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 25,
              ),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 20, right: 20, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.list.date}, ${widget.list.time}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${widget.list.place}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              margin: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 25,
              ),
              child: Container(
                width: 361,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "신청한 이유를 작성해주세요!",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildTextField("이곳에 작성하면 됩니당.", reasonC,
                          maxLine: 8, maxLength: 150, autoFocus: false)
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 26, bottom: 26),
                child: Text(
                  "상담 신청은 모두를 위해 장난으로 작성하지 말아주세요.",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage(
                              list: _list,
                            )));
                setState(() {
                  tagList = result;
                  if (tagList == null) tagList = [];
                });
                print("tagList: $tagList");
              },
              child: Padding(
                padding: EdgeInsets.only(right: 33, left: 33, bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, top: 16, bottom: 16),
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
            ),
            Align(
                alignment: Alignment.center,
                child:
                    makeTagWidget(tag: tagList, size: Size(360, 27), mode: 1)),
            Padding(
              padding:
                  EdgeInsets.only(right: 33, left: 33, top: 10, bottom: 30),
              child: makeGradientBtn(
                  msg: "신청하기",
                  onPressed: () {
                    onApply();
                  },
                  mode: 2,
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }

  onApply() {
    if (reasonC.text.isEmpty) {
      snackBar("상담신청 이유를 적어주세요!", context);
    } else {
      CounselingVO vo = CounselingVO(
          date: widget.list.date,
          time: widget.list.time,
          place: widget.list.place,
          tag: tagList,
          reason: reasonC.text);

      print(vo.toString());
    }
  }
}
