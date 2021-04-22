import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContractingCompanyWrite extends StatefulWidget {
  @override
  _ContractingCompanyWriteState createState() =>
      _ContractingCompanyWriteState();
}

class _ContractingCompanyWriteState extends State<ContractingCompanyWrite> {
  var titleC = TextEditingController();
  var fieldC = TextEditingController();
  var addressC = TextEditingController();
  var priceC = TextEditingController();
  var infoC = TextEditingController();
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
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      buildTextField("업체명", titleC,
                          deco: false, autoFocus: false),
                      buildTextField("사업분야", fieldC,
                          deco: false, autoFocus: false),
                      buildTextField("주소", addressC,
                          deco: false, autoFocus: false),
                      buildTextField("평균 연봉", priceC,
                          deco: false, autoFocus: false),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: buildTextField("협약을 맺은 업체를 설명해 주세요!.", infoC,
                      maxLine: 8, maxLength: 150, autoFocus: false),
                ),
              ),
              SizedBox(
                height: 15,
              ),
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
                      padding: EdgeInsets.only(right: 10, left: 10, bottom: 20),
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
                    onContractingPost();
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

  onContractingPost() {
    if (titleC.text.isEmpty ||
        fieldC.text.isEmpty ||
        addressC.text.isEmpty ||
        priceC.text.isEmpty ||
        infoC.text.isEmpty ||
        tagList.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      Navigator.pop(context);
    }
  }
}
