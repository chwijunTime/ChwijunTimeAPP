import 'package:app_user/model/contracting_company/contracting_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kopo/kopo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContractingCompanyWrite extends StatefulWidget {
  @override
  _ContractingCompanyWriteState createState() =>
      _ContractingCompanyWriteState();
}

class _ContractingCompanyWriteState extends State<ContractingCompanyWrite> {
  RetrofitHelper helper;

  var titleC = TextEditingController();
  var fieldC = TextEditingController();
  var addressC = TextEditingController();
  var priceC = TextEditingController();
  var infoC = TextEditingController();
  List<String> tagList = [];

  @override
  void initState() {
    super.initState();
    initRetrofit();
  }

  @override
  void dispose() {
    titleC.dispose();
    fieldC..dispose();
    addressC.dispose();
    priceC.dispose();
    infoC.dispose();
    super.dispose();
  }

  initRetrofit() {
    Dio dio = Dio(BaseOptions(
        connectTimeout: 5 * 1000,
        receiveTimeout: 5 * 1000,
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        }));
    helper = RetrofitHelper(dio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(right: 24, left: 24),
          child: ListView(
            children: [
              SizedBox(
                height: 35,
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
                      buildTextField("사업분야", fieldC,
                          deco: false,
                          autoFocus: false),
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
                          type: TextInputType.number,
                          suffixText: "만원"),
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
                        "협약 업체 설명",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      buildTextField("협약을 맺은 업체를 설명해 주세요!", infoC,
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
                padding: const EdgeInsets.only(left: 50, right: 50, bottom: 10),
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
                    mode: 4,
                    icon: Icon(
                      Icons.tag,
                      color: Colors.white,
                    )),
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
                  msg: "등록하기",
                  onPressed: () {
                    onContractingPost();
                  },
                  mode: 4,
                  icon: Icon(
                    Icons.note_add,
                    color: Colors.white,
                  )),
              SizedBox(
                height: 35,
              ),
            ],
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

  onContractingPost() async {
    if (titleC.text.isEmpty ||
        addressC.text.isEmpty ||
        addressC.text.isEmpty ||
        fieldC.text.isEmpty ||
        infoC.text.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      ContractingVO vo = ContractingVO(
          info: infoC.text,
          address: addressC.text,
          salary: "${priceC.text}만원",
          title: titleC.text,
          fieldC: fieldC.text,
          postTag: tagList);
      final pref = await SharedPreferences.getInstance();
      var token = pref.getString("accessToken");
      print("token: ${token}");
      try {
        var res = await helper.postCont(token, vo.toJson());
        if (res.success) {
          Navigator.pop(context, true);
        } else {
          snackBar(res.msg, context);
          print("error: ${res.msg}");
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
