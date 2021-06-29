import 'package:app_user/model/confirmation/confirmation_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:kopo/kopo.dart';

class ConfirmationStatusWrite extends StatefulWidget {
  @override
  _ConfirmationStatusWriteState createState() =>
      _ConfirmationStatusWriteState();
}

class _ConfirmationStatusWriteState extends State<ConfirmationStatusWrite> {
  var titleC = TextEditingController();
  var areaC = TextEditingController();
  var stdNameC = TextEditingController();
  var generationC = TextEditingController();
  var addressC = TextEditingController();
  var siteUrl = TextEditingController();
  var etcC = TextEditingController();
  List<String> tagList = [];

  RetrofitHelper helper;

  @override
  void dispose() {
    titleC.dispose();
    areaC.dispose();
    stdNameC.dispose();
    generationC.dispose();
    addressC.dispose();
    siteUrl.dispose();
    etcC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
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
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    buildTextField("업체명", titleC, deco: false),
                    buildTextField("학생 이름", stdNameC, deco: false),
                    buildTextField("회사 사이트 주소", siteUrl, deco: false),
                    buildTextField("지역명", areaC, deco: false),
                    GestureDetector(
                        onTap: (){
                          _onKopo(addressC);
                        },
                        child: buildTextField("상세 주소", addressC,
                            deco: false, disable: true)),
                    buildTextField("기수", generationC,
                        suffixText: "기",
                        type: TextInputType.number,
                        deco: false),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              margin: EdgeInsets.all(25),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "비고",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      buildTextField("비고를 적어주세요", etcC,
                          maxLine: 15,
                          maxLength: 500,
                          multiLine: true,
                          type: TextInputType.multiline)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: makeBtn(
                  msg: "태그 선택하러 가기",
                  onPressed: () async {
                    final result = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchPage()));
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
              height: 20,
            ),
            Padding(
              padding:
                  EdgeInsets.only(right: 33, left: 33, top: 10, bottom: 30),
              child: makeGradientBtn(
                  msg: "등록하기",
                  onPressed: () {
                    onConfirmationPost();
                  },
                  mode: 4,
                  icon: Icon(
                    Icons.note_add,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: 20,
            )
          ],
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

  onConfirmationPost() async {
    if (titleC.text.isEmpty ||
        addressC.text.isEmpty ||
        areaC.text.isEmpty ||
        stdNameC.text.isEmpty ||
        generationC.text.isEmpty ||
        tagList.isEmpty) {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      var vo = ConfirmationVO(
          title: titleC.text,
          area: areaC.text,
          siteUrl: siteUrl.text,
          etc: etcC.text,
          jockey: "${generationC.text}기",
          address: addressC.text,
          name: stdNameC.text,
          postTag: tagList);
      try {
        helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
          setState(() {});
        }));
        var res = await helper.postConf(vo.toJson());
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
