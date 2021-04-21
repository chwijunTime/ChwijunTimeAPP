import 'package:app_user/model/confirmation_status_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/screens/detail_page/confirmation_status_detail.dart';
import 'package:app_user/screens/write_page/confirmation_status_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../search_page.dart';

class ConfirmationStatusPage extends StatefulWidget {
  String role;

  @override
  _ConfirmationStatusPageState createState() => _ConfirmationStatusPageState();
}

enum Select { YEAR, TAG, TITLE }
enum Year { y2018, y2019, y2020, y2021 }

class _ConfirmationStatusPageState extends State<ConfirmationStatusPage> {
  final scafforldkey = GlobalKey<ScaffoldState>();

  PanelController panelController = PanelController();
  Select _select = Select.YEAR;
  Year _year = Year.y2021;
  final tagC = TextEditingController();
  final titleC = TextEditingController();
  List<String> _list;
  List<String> tagList = [];

  final List<ConfirmationStatusVO> confList = [];
  final List<bool> checkList = [];

  _onCheckPressed(int index) {
    setState(() {
      checkList[index] = !checkList[index];
    });
  }

  initList() {
    for (int i = 0; i < 12; i++) {
      if (i % 2 == 0) {
        confList.add(ConfirmationStatusVO(
            title: "${i}.title",
            grade: i % 3 + 1,
            area: "광주광역시",
            address: "광주광역시 광산구 광주소프트웨어마이스터고등학교"));
      } else {
        confList.add(ConfirmationStatusVO(
            title: "${i}.title",
            grade: i % 3 + 1,
            area: "광주광역시",
            address: "광주광역시 광산구 광주소프트웨어마이스터고등학교",
            etc:
                "이것은 비고란 입니당앙ㄴ리;망러;밍나러;ㅣㅁㅇ나 아야아ㅇ아야아야아야어여오ㅇ요오유으이ㅣ아링ㄹ가나다라마바사아자차카타ㅠㅏ사",
            siteUrl: "https://www.naver.com/"));
      }
      checkList.add(false);
    }
  }

  @override
  void initState() {
    super.initState();
    initList();
    setState(() {
      widget.role = User.role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafforldkey,
      appBar: buildAppBar("appBar"),
      drawer: buildDrawer(context),
      body: SlidingUpPanel(
        panelBuilder: (scrollController) =>
            buildSlidingPanel(scrollController: scrollController),
        controller: panelController,
        minHeight: 80,
        maxHeight: 600,
        backdropEnabled: true,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        margin: EdgeInsets.only(left: 2, right: 2),
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(0, -2),
              blurRadius: 10,
              spreadRadius: 2)
        ],
        body: Container(
          color: Colors.white,
          child: ListView(
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
                      "취업확정 현황",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              widget.role == "user" ? SizedBox() :
              Padding(
                padding: const EdgeInsets.only(right: 20, left:20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    makeGradientBtn(
                        msg: "취업 현황 등록",
                        onPressed: () {
                          print("등록하자");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ConfirmationStatusWrite()));
                        },
                        mode: 1,
                        icon: Icon(
                          Icons.note_add,
                          color: Colors.white,
                        )),
                    makeGradientBtn(
                        msg: "선택된 현황 삭제",
                        onPressed: () {
                          _onDeleteStatus();
                        },
                        mode: 1,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              ListView.separated(
                itemCount: confList.length,
                itemBuilder: (context, index) {
                  return buildState(context, index);
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  );
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildState(BuildContext context, int index) {
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmationStatusDetail(list: confList[index],)));
        },
        child: Row(
          children: [
            Text(
              "${confList[index].title}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: Text(
                "/${confList[index].grade.toString()}학년",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              "${confList[index].area}",
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
            ),
            SizedBox(
              width: 10,
            ),
            widget.role == "user"
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmationStatusDetail(
                                    list: confList[index],
                                  )));
                    },
                    child: Icon(Icons.arrow_forward_ios_rounded),
                  )
                : InkWell(
                    onTap: () {
                      _onCheckPressed(index);
                    },
                    child: checkList[index]
                        ? Icon(
                            Icons.check_box_outlined,
                            color: Colors.red,
                          )
                        : Icon(Icons.check_box_outline_blank),
                  )
          ],
        ),
      ),
    ));
  }

  Widget buildSlidingPanel({
    @required ScrollController scrollController,
  }) =>
      Panel(scrollController);

  Widget Panel(ScrollController scrollController) {
    return ListView(
      padding: EdgeInsets.all(16),
      controller: scrollController,
      children: [
        Text(
          '협약업체 검색하기',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
        ),
        Row(
          children: [
            Expanded(
                child: Row(children: [
              Radio(
                value: Select.YEAR,
                groupValue: _select,
                onChanged: (value) {
                  setState(() {
                    _select = value;
                  });
                },
              ),
              Text(
                "년도별 검색하기",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ])),
            Expanded(
                child: Row(children: [
              Radio(
                value: Select.TAG,
                groupValue: _select,
                onChanged: (value) {
                  setState(() {
                    _select = value;
                  });
                },
              ),
              Text(
                "태그별 검색하기",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ])),
          ],
        ),
        Row(children: [
          Radio(
            value: Select.TITLE,
            groupValue: _select,
            onChanged: (value) {
              setState(() {
                _select = value;
              });
            },
          ),
          Text(
            "업체명 검색하기",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ]),
        SizedBox(
          height: 15,
        ),
        if (_select == Select.YEAR) selectYearWidget(),
        if (_select == Select.TAG) selectTagWidget(),
        if (_select == Select.TITLE) selectTitleWidget(),
      ],
    );
  }

  Widget selectYearWidget() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          height: 1,
          color: Colors.grey,
        ),
        SizedBox(
          height: 15,
        ),
        Center(
          child: Text(
            "년도를 선택하세요",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Radio(
            value: Year.y2018,
            groupValue: _year,
            onChanged: (value) {
              setState(() {
                _year = value;
              });
            },
          ),
          title: Text("2018"),
        ),
        ListTile(
          leading: Radio(
            value: Year.y2019,
            groupValue: _year,
            onChanged: (value) {
              setState(() {
                _year = value;
              });
            },
          ),
          title: Text("2019"),
        ),
        ListTile(
          leading: Radio(
            value: Year.y2020,
            groupValue: _year,
            onChanged: (value) {
              setState(() {
                _year = value;
              });
            },
          ),
          title: Text("2020"),
        ),
        ListTile(
          leading: Radio(
            value: Year.y2021,
            groupValue: _year,
            onChanged: (value) {
              setState(() {
                _year = value;
              });
            },
          ),
          title: Text("2021"),
        ),
        SizedBox(
          height: 100,
        ),
        makeGradientBtn(
            msg: "조회하기",
            onPressed: () {
              print("selectRadio: ${_year}");
              panelController.close();
            },
            mode: 4,
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ))
      ],
    );
  }

  bool _IsSearching = false;

  Widget selectTagWidget() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: buildTextField("TAG", tagC, autoFocus: false),
        ),
        SingleChildScrollView(
          child: Container(
            height: 220,
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: Colors.black54,
                      blurRadius: 10,
                      spreadRadius: 2)
                ],
                color: Colors.white),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8),
              children: _buildSearchList(),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
            height: 58,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "태그",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 1,
                  width: 360,
                  color: Colors.grey[500],
                  margin: EdgeInsets.only(bottom: 5, top: 5),
                ),
                SizedBox(
                  width: 360,
                  height: 22,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: tagList.length,
                      itemBuilder: (context, index) {
                        return buildModifyItemTag(tagList, index);
                      }),
                )
              ],
            )),
        SizedBox(
          height: 5,
        ),
        makeGradientBtn(
            msg: "조회하기",
            onPressed: () {
              print("tagList: ${tagList}");
              panelController.close();
            },
            mode: 4,
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ))
      ],
    );
  }

  Widget buildModifyItemTag(List<String> tag, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tagList.removeAt(index);
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.blue[400],
            )),
        child: Row(
          children: [
            Text(
              "#${tagList[index]}",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            Icon(
              Icons.highlight_remove_rounded,
              size: 10,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  List<ListTile> _buildSearchList() {
    if (tagC.text.isEmpty) {
      return _list
          .map((contact) => ListTile(
                title: Text(contact),
                onTap: () {
                  print("눌림");
                  if (!tagList.contains(contact)) {
                    setState(() {
                      tagList.add(contact);
                    });
                  } else {
                    scafforldkey.currentState
                        .showSnackBar(SnackBar(content: Text("중복된 태그입니다.")));
                  }
                },
              ))
          .toList();
    } else {
      List<String> _searchList = [];
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(tagC.text.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList
          .map((contact) => ListTile(
                title: Text(contact),
                onTap: () {
                  print("눌림");
                  if (!tagList.contains(contact)) {
                    setState(() {
                      tagList.add(contact);
                    });
                  } else {
                    scafforldkey.currentState
                        .showSnackBar(SnackBar(content: Text("중복된 태그입니다.")));
                  }
                },
              ))
          .toList();
    }
  }

  Widget selectTitleWidget() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          height: 1,
          color: Colors.grey,
        ),
        SizedBox(
          height: 15,
        ),
        Center(
          child: Text(
            "업체명을 입력해주세요.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: buildTextField("TAG", titleC, autoFocus: false),
        ),
        SizedBox(
          height: 250,
        ),
        makeGradientBtn(
            msg: "조회하기",
            onPressed: () {
              print("titleC = ${titleC.text}");
              panelController.close();
            },
            mode: 4,
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ))
      ],
    );
  }

  _onDeleteStatus() {
    List<ConfirmationStatusVO> deleteComp = [];
    for (int i = 0; i < checkList.length; i++) {
      if (checkList[i]) {
        deleteComp.add(confList[i]);
      }
    }

    if(deleteComp.isEmpty) {
      snackBar("삭제할 업체를 선택해주세요.", context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => StdDialog(
            msg: "선택된 취업현황을 삭제하시겠습니까?",
            size: Size(326, 124),
            btnName1: "아니요",
            btnCall1: () {Navigator.pop(context);},
            btnName2: "삭제하기",
            btnCall2: () {
              print("삭제할 업체들================================");
              print(deleteComp.toString());
              Navigator.pop(context);
            },),
          barrierDismissible: false);
    }
  }
}
