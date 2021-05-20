import 'package:app_user/model/contracting_company/contracting_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContractingCompanyWrite extends StatefulWidget {
  @override
  _ContractingCompanyWriteState createState() =>
      _ContractingCompanyWriteState();
}

class _ContractingCompanyWriteState extends State<ContractingCompanyWrite> {
  RetrofitHelper helper;

  var titleC = TextEditingController();
  var areaC = TextEditingController();
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
    areaC..dispose();
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
                  child: buildTextField("협약을 맺은 업체를 설명해 주세요!.", infoC,
                      maxLine: 8, maxLength: 150, autoFocus: false),
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

  onContractingPost() async {
    if (titleC.text.isEmpty ||
        addressC.text.isEmpty ||
        priceC.text.isEmpty ||
        infoC.text.isEmpty ||
        areaC.text.isEmpty ||
        tagList.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      ContractingVO vo = ContractingVO(
          info: infoC.text,
          address: addressC.text,
          salary: priceC.text,
          title: titleC.text,
          // Todo: ContractingVO에 area 추가해야함, field 삭제해야함
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
