import 'package:app_user/model/contracting_company/contracting_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:kopo/kopo.dart';

class ContractingCompanyModify extends StatefulWidget {
  final ContractingVO list;

  ContractingCompanyModify({@required this.list});

  @override
  _ContractingCompanyModifyState createState() =>
      _ContractingCompanyModifyState();
}

class _ContractingCompanyModifyState extends State<ContractingCompanyModify> {
  RetrofitHelper helper;

  var titleC = TextEditingController();
  var fieldC = TextEditingController();
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
    fieldC.text = widget.list.fieldC;
    addressC.text = widget.list.address;
    tagList = widget.list.tag;
  }

  @override
  void dispose() {
    titleC.dispose();
    fieldC.dispose();
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
                      buildTextField("사업 분야", fieldC,
                          deco: false, autoFocus: false),
                      GestureDetector(
                        onTap: () {
                          _onKopo(addressC);
                        },
                        child: buildTextField("주소", addressC,
                            deco: false, autoFocus: false, disable: true),
                      ),
                      buildTextField("평균 연봉", priceC,
                          deco: false,
                          autoFocus: false,
                          suffixText: "만원",
                          type: TextInputType.number),
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
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildTextField("협약을 맺은 업체를 설명해 주세요!.", infoC,
                          maxLine: 15,
                          maxLength: 5000,
                          autoFocus: false,
                          multiLine: true,
                          type: TextInputType.multiline),
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
                  onPressed: onContractingModify,
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

  _onKopo(TextEditingController controller) async {
    KopoModel model = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Kopo()));

    if (model != null) {
      setState(() {
        controller.text = model.address;
      });
    }
  }

  onContractingModify() async {
    if (tagList.isEmpty ||
        titleC.text.isEmpty ||
        addressC.text.isEmpty ||
        fieldC.text.isEmpty ||
        infoC.text.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
        setState(() {});
      }));
      ContractingVO vo = ContractingVO(
          salary: priceC.text,
          info: infoC.text,
          postTag: tagList,
          title: titleC.text,
          address: addressC.text,
          fieldC: fieldC.text);
      try {
        final res = await helper.putCont(widget.list.index, vo.toJson());
        if (res.success) {
          Navigator.pop(context, true);
        } else {
          Navigator.pop(context, false);
          snackBar(res.msg, context);
          print("error: ${res.msg}");
        }
      } catch (e) {
        print("err: $e");
      }
    }
  }

  Future<bool> _onBackPressed() {
    Navigator.pop(context, false);
  }
}
