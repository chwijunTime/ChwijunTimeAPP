import 'package:app_user/model/user.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/write_page/company_notice_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../detail_page/company_notice_detail.dart';

class CompanyNoticePage extends StatefulWidget {
  @override
  _CompanyNoticePageState createState() => _CompanyNoticePageState();

  final List<CompNotice> notiList = [];
  String role;
}

enum Select { YEAR, TAG, TITLE }
enum Year { y2018, y2019, y2020, y2021 }

class _CompanyNoticePageState extends State<CompanyNoticePage> {
  final scafforldkey = GlobalKey<ScaffoldState>();

  PanelController panelController = PanelController();
  Select _select = Select.YEAR;
  Year _year = Year.y2021;
  final tagC = TextEditingController();
  final titleC = TextEditingController();
  List<String> _list;
  List<String> tagList = [];

  @override
  void initState() {
    super.initState();
    initList();
    init();
    searchState();
    widget.role = User.role;
  }

  initList() {
    for (int i = 0; i < 8; i++) {
      widget.notiList.add(CompNotice(
          title: "${i}.title",
          startDate: "2021.03.31",
          endDate: "2021.04.01",
          field: "모바일 앱, 웹",
          address: "광주광역시 광산구 목련로 273번길 76",
          compInfo:
              "printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it ",
          preferentialInfo:
              "우대 조건 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it ",
          isBookMark: false,
          tag: List.generate(10, (i) => "${i}.tag")));
    }
  }

  void init() {
    _list = [];
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

  searchState() {
    tagC.addListener(() {
      print(_IsSearching);
      if (tagC.text.isEmpty) {
        setState(() {
          _IsSearching = false;
        });
      } else {
        setState(() {
          _IsSearching = true;
        });
      }
    });
  }

  _onBookMarkPressed(int index) {
    setState(() {
      widget.notiList[index].isBookMark = !widget.notiList[index].isBookMark;
      print(widget.notiList[index].isBookMark);
    });
  }

  @override
  Widget build(BuildContext context) {
    initList();
    return Scaffold(
      key: scafforldkey,
      appBar: buildAppBar("appBar", context),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      "취업 공고",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              widget.role == "user"
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(
                          right: 26, left: 26, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          makeGradientBtn(
                              msg: "취업 공고 등록",
                              onPressed: () {
                                print("등록하자");
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => CompanyNoticeWritePage()));
                              },
                              mode: 1,
                              icon: Icon(
                                Icons.note_add,
                                color: Colors.white,
                              )),
                          makeGradientBtn(
                              msg: "선택된 공고 삭제",
                              onPressed: () {
                                _onDeleteCompNotice();
                              },
                              mode: 1,
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.notiList.length,
                  itemBuilder: (context, index) {
                    return buildItemCompany(context, index);
                  },
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onDeleteCompNotice() {
    List<CompNotice> deleteComp = [];
    for (int i = 0; i < widget.notiList.length; i++) {
      if (widget.notiList[i].isBookMark) {
        deleteComp.add(widget.notiList[i]);
      }
    }

    if (deleteComp.isEmpty) {
      snackBar("삭제할 공고를 선택해주세요.", context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => StdDialog(
                msg: "선택된 공고 업체를 삭제하시겠습니까?",
                size: Size(326, 124),
                btnName1: "아니요",
                btnCall1: () {
                  Navigator.pop(context);
                },
                btnName2: "삭제하기",
                btnCall2: () {
                  print("삭제할 공고들================================");
                  print(deleteComp.toString());
                  Navigator.pop(context);
                },
              ),
          barrierDismissible: false);
    }
  }

  Widget buildItemCompany(BuildContext context, int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CompanyNoticeDetailPage(list: widget.notiList[index])));
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
                      "${widget.notiList[index].title}",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                  ),
                  widget.role == "user"
                      ? IconButton(
                          icon: widget.notiList[index].isBookMark
                              ? Icon(
                                  Icons.bookmark,
                                  size: 28,
                                  color: Color(0xff4687FF),
                                )
                              : Icon(
                                  Icons.bookmark_border,
                                  size: 28,
                                ),
                          onPressed: () => _onBookMarkPressed(index),
                        )
                      : IconButton(
                          icon: widget.notiList[index].isBookMark
                              ? Icon(
                                  Icons.check_box_outlined,
                                  size: 28,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  size: 28,
                                ),
                          onPressed: () => _onBookMarkPressed(index)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Container(
                  height: 60,
                  child: AutoSizeText(
                    "${widget.notiList[index].compInfo}, ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    minFontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 22,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: List.generate(2, (indextag) {
                        return buildItemTag(
                            widget.notiList[index].tag, indextag);
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
                          "외 ${widget.notiList[index].tag.length - 2}개",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "마감일: ${widget.notiList[index].endDate}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
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
}

class CompNotice {
  String title;
  String startDate, endDate;
  String field;
  String address;
  String compInfo;
  String preferentialInfo;
  String etc;
  bool isBookMark;
  List<String> tag;

  CompNotice(
      {@required this.title,
      @required this.startDate,
      @required this.endDate,
      @required this.field,
      @required this.address,
      @required this.compInfo,
      @required this.preferentialInfo,
      this.etc = "",
      @required this.isBookMark,
      @required this.tag});

  @override
  String toString() {
    return 'CompNotice{title: $title, startDate: $startDate, endDate: $endDate, field: $field, address: $address, compInfo: $compInfo, preferentialInfo: $preferentialInfo, etc: $etc, isBookMark: $isBookMark, tag: $tag}';
  }
}
