import 'package:app_user/model/company_vo.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/drop_down_button.dart';

class ContractingCompPage extends StatefulWidget {
  @override
  _ContractingCompPageState createState() => _ContractingCompPageState();
}

class _ContractingCompPageState extends State<ContractingCompPage> {
  List<CompanyVO> compList = [];
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _listSetting();
  }

  _onHeartPressed(int index) {
    setState(() {
      compList[index].isFavorite = !compList[index].isFavorite;
    });
  }

  void _listSetting() {
    for (int i = 1; i <= 8; i++) {
      compList.add(CompanyVO(
          name: "${i}. name",
          content: "${i}. content",
          tag: List.generate(5, (index) => "${i}.태그"),
          minSalary: i * 1000,
          maxSalary: i * 1000 + 500,
          isFavorite: false));
    }
  }

  void onSetState(String value) {
    setState(() {
      selectedValue = value;
      print("onSetState: ${value}, ${selectedValue}");
    });
  }

  var valueList = ["첫번째", "두번째", "세번째"];
  var selectedValue = "첫번째";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: buildDrawer(context),
        appBar: buildAppBar("custom Appbar"),
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "취준타임",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0x832B8AC0)),
                        ),
                        Text(
                          "협약업체",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 26),
                    child: makeGradientBtn(msg: "좋아요 모아보기", onPressed: (){}, mode: 1, icon: Icon(Icons.favorite, color: Colors.white,)),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: compList.length,
                    itemBuilder: (context, index) {
                      return buildItemCompany(context, index);
                    }),
              )
            ],
          ),
        ));
  }

  Widget buildItemCompany(BuildContext context, int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
      child: GestureDetector(
        onTap: () {
          setState(() {

          });
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${compList[index].name}. 업체명",
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                  ),
                  IconButton(
                    icon: compList[index].isFavorite
                        ? Icon(
                      Icons.favorite,
                      size: 28,
                      color: Colors.red,
                    )
                        : Icon(
                      Icons.favorite_border_outlined,
                      size: 28,
                    ),
                    onPressed: () => _onHeartPressed(index),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Text(
                  "${compList[index].content}. 이것은 회사 설명입니다.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 22,
                child: Row(
                  children: [
                    Row(
                      children: List.generate(2, (indextag) {
                        return buildItemTag(
                            compList[index].tag, indextag);
                      }),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.blue[400],
                          )),
                      child: Center(
                        child: Text(
                          "외 ${compList[index].tag.length - 2}개",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "평균: ${compList[index].minSalary}~${compList[index].maxSalary}",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
