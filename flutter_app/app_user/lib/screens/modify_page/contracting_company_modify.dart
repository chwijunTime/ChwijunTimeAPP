import 'package:app_user/model/company_vo.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../search_page.dart';

class ContractingCompanyModify extends StatefulWidget {
  final CompanyVO list;

  ContractingCompanyModify({@required this.list});

  @override
  _ContractingCompanyModifyState createState() =>
      _ContractingCompanyModifyState();
}

class _ContractingCompanyModifyState extends State<ContractingCompanyModify> {
  var priceC = TextEditingController();
  var infoC = TextEditingController();
  var tagList = [];
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
    infoC.text = widget.list.info;
    priceC.text =
        (widget.list.maxSalary + widget.list.minSalary / 2).toStringAsFixed(0);
    tagList = widget.list.tag;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar("취준타임", context),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.list.title,
                        style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.list.field,
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.list.address,
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "회사 설명",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10,),
                      buildTextField("협약을 맺은 업체를 설명해 주세요!.", infoC,
                          maxLine: 8, maxLength: 300, autoFocus: false),
                    ],
                  ),
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
                  msg: "수정하기",
                  onPressed: () {
                    onContractingModify();
                  },
                  mode: 4,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  onContractingModify() {
    if(priceC.text.isEmpty || infoC.text.isEmpty || tagList.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      widget.list.maxSalary = int.parse(priceC.text);
      widget.list.info = infoC.text;
      widget.list.tag = tagList;
      Navigator.pop(context, widget.list);
    }
  }

  Future<bool> _onBackPressed() {
    Navigator.pop(context, false);
  }

}
