import 'package:app_user/model/contracting_company/contracting_vo.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ContractingCompanyModify extends StatefulWidget {
  final ContractingVO list;

  ContractingCompanyModify({@required this.list});

  @override
  _ContractingCompanyModifyState createState() =>
      _ContractingCompanyModifyState();
}

class _ContractingCompanyModifyState extends State<ContractingCompanyModify> {
  var titleC = TextEditingController();
  var areaC = TextEditingController();
  var addressC = TextEditingController();
  var priceC = TextEditingController();
  var infoC = TextEditingController();
  var tagList = [];

  @override
  void initState() {
    super.initState();
    infoC.text = widget.list.info;
    priceC.text = widget.list.salary;
    titleC.text = widget.list.title;
    // Todo ContractingVO area 추가 되면 -> areaC.text = widget.list.area
    addressC.text = widget.list.address;
    tagList = widget.list.tag;
  }

  @override
  void dispose() {
    titleC.dispose();
    areaC.dispose();
    addressC.dispose();
    priceC.dispose();
    infoC.dispose();
    super.dispose();
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
            padding: const EdgeInsets.only(right: 24, left: 24),
            child: ListView(children: [
              SizedBox(
                height: 24,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 15.0, left: 15, bottom: 15, top: 10),
                  child: Column(
                    children: [
                      buildTextField("업체명", titleC,
                          deco: false, autoFocus: false),
                      buildTextField("지역", areaC,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "회사 설명",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildTextField("협약을 맺은 업체를 설명해 주세요!.", infoC,
                          maxLine: 8, maxLength: 300, autoFocus: false),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100),
                child: makeBtn(
                    msg: "태그 선택하러 가기",
                    onPressed: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage()));
                      setState(() {
                        if (result != null) {
                          tagList = result;
                        }
                      });
                      print("tagList: $tagList");
                    },
                    mode: 2),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Align(
                    alignment: Alignment.center,
                    child: makeTagWidget(
                        tag: tagList, size: Size(360, 27), mode: 1)),
              ),
              SizedBox(
                height: 19,
              ),
              makeGradientBtn(
                  msg: "수정하기",
                  onPressed: () {
                    onContractingModify();
                  },
                  mode: 4,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )),
              SizedBox(
                height: 24,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  onContractingModify() {
    if (priceC.text.isEmpty || infoC.text.isEmpty || tagList.isEmpty ||
        titleC.text.isEmpty || addressC.text.isEmpty
      // TODO || area.text.isEmpty
    ) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      widget.list.salary = priceC.text;
      widget.list.info = infoC.text;
      widget.list.tag = tagList;
      widget.list.address = addressC.text;
      widget.list.title = titleC.text;
      // widget.list.area = areaC.text;
      Navigator.pop(context, widget.list);
    }
  }

  Future<bool> _onBackPressed() {
    Navigator.pop(context, false);
  }
}
