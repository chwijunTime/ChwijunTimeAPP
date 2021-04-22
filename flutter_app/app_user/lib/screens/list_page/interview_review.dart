import 'package:app_user/model/review_vo.dart';
import 'package:app_user/screens/detail_page/interview_review_detail.dart';
import 'package:app_user/screens/write_page/interview_review_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class InterviewReviewPage extends StatefulWidget {
  String role;

  @override
  _InterviewReviewPageState createState() => _InterviewReviewPageState();
}

enum Select { YEAR, TAG, TITLE }
enum Year { y2018, y2019, y2020, y2021 }

class _InterviewReviewPageState extends State<InterviewReviewPage> {
  final scafforldkey = GlobalKey<ScaffoldState>();

  PanelController panelController = PanelController();

  List<ReviewVO> compList = [];
  final tagC = TextEditingController();
  final titleC = TextEditingController();
  List<String> _list;
  List<String> tagList = [];

  Select _select = Select.YEAR;
  Year _year = Year.y2021;

  @override
  void initState() {
    super.initState();
    _listSetting();
    init();
    searchState();
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

  _onHeartPressed(int index) {
    setState(() {
      compList[index].isFavorite = !compList[index].isFavorite;
    });
  }

  void _listSetting() {
    for (int i = 1; i <= 8; i++) {
      compList.add(ReviewVO(
          isMine: i % 2 == 0,
          title: "${i}. 업체명",
          review:
              "${i}. content printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scr",
          tag: List.generate(5, (index) => "${index}.태그"),
          applyDate: "2021.03.21",
          grade: (i % 3) + 1,
          price: i * 1000,
          isFavorite: false,
          address: "광주광역시 광산구 목련로 273번길",
          question:
              "질문1, 이런 질문이 나왔어요 신기하더라구요 아니... 그런 질문은 생각도 못했어요 하지만 생각해 보니 그 질문은 이 길을 가는데 적합한 사람인지 확인하기 위해 참 좋던 질문이더라구용"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scafforldkey,
        drawer: buildDrawer(context),
        appBar: buildAppBar("취준타임" , context),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            "면접후기 & 회사후기",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => InterviewReviewWrite()));
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xff4FB8F3),
                                    Color(0xff9342FA),
                                    Color(0xff2400FF)
                                  ]),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[500],
                                    offset: Offset(2, 4),
                                    blurRadius: 5,
                                    spreadRadius: 0.5)
                              ]),
                          child: Icon(
                            Icons.note_add,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Align(
                    child: ListView.builder(
                        itemCount: compList.length,
                        itemBuilder: (context, index) {
                          return buildItemCompany(context, index);
                        }),
                  ),
                )
              ],
            ),
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
          print("눌림");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (countext) => InterviewReviewDetail(
                        list: compList[index],
                      )));
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
                      "${compList[index].title}",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
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
                  "${compList[index].review}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 22,
                child: Row(
                  children: [
                    Row(
                      children: List.generate(2, (indextag) {
                        return buildItemTag(compList[index].tag, indextag);
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
                          "지원날짜: ${compList[index].applyDate}",
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
              print("눌려버림");
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
              print("눌려버림");
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
                  print(contact);
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
                  print(contact);
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
}
