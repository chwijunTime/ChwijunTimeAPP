import 'package:app_user/consts.dart';
import 'package:app_user/model/contracting_company/contracting_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/detail_page/contracting_company_detail.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/write_page/contracting_company_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/drop_down_button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContractingCompPage extends StatefulWidget {
  String role;

  @override
  _ContractingCompPageState createState() => _ContractingCompPageState();
}

class _ContractingCompPageState extends State<ContractingCompPage> {
  final scafforldkey = GlobalKey<ScaffoldState>();
  RetrofitHelper helper;
  final _scrollController = ScrollController();

  List<ContractingVO> contractingList = [];
  List<ContractingVO> searchContractingList = [];
  final titleC = TextEditingController();
  List<bool> deleteList = [];
  var itemCount = Consts.showItemCount;
  List<String> valueList = ['전체보기', '검색하기'];
  String selectValue = "전체보기";
  String msg = "검색된 협약업체가 없습니다.";

  @override
  void initState() {
    super.initState();
    initRetrofit();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    titleC.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        if (selectValue == valueList[0]) {
          if (itemCount != contractingList.length) {
            if ((contractingList.length - itemCount) ~/ Consts.showItemCount <=
                0) {
              itemCount = contractingList.length;
              print("으잉: ${contractingList.length}");
            } else {
              itemCount += Consts.showItemCount;
            }
          }
        } else {
          if (itemCount != searchContractingList.length) {
            if ((searchContractingList.length - itemCount) ~/ Consts.showItemCount <=
                0) {
              itemCount = searchContractingList.length;
              print("으잉: ${searchContractingList.length}");
            } else {
              itemCount += Consts.showItemCount;
            }
          }
        }
      });
    }
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

  _onCheckPressed(int index) {
    setState(() {
      deleteList[index] = !deleteList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.role = User.role;
    return Scaffold(
      key: scafforldkey,
      drawer: buildDrawer(
        context,
      ),
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                  makeDropDownBtn(
                      valueList: valueList,
                      selectedValue: selectValue,
                      onSetState: (value) {
                        setState(() {
                          selectValue = value;
                          deleteList.clear();
                          if (selectValue == valueList[1]) {
                            titleC.text = "";
                            itemCount = 0;
                            searchContractingList.clear();
                            msg = "회사명, 지역명으로 검색하기";
                          } else {
                            itemCount = Consts.showItemCount;
                          }
                        });
                      },
                      hint: "보기"),
                ],
              ),
            ),
            User.role == User.admin
                ? Padding(
                    padding:
                        const EdgeInsets.only(right: 26, left: 26, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        makeGradientBtn(
                            msg: "협약 업체 등록",
                            onPressed: () async {
                              var res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ContractingCompanyWrite()));
                              if (res != null && res) {
                                setState(() {
                                  _getContractingList();
                                });
                              }
                            },
                            mode: 1,
                            icon: Icon(
                              Icons.note_add,
                              color: Colors.white,
                            )),
                        makeGradientBtn(
                            msg: "선택된 업체 삭제",
                            onPressed: () {
                              _onDeleteCompany();
                            },
                            mode: 1,
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  )
                : SizedBox(),
            selectValue == valueList[1]
                ? Padding(
                    padding: EdgeInsets.only(
                        right: 33, left: 33, bottom: 15, top: 15),
                    child: buildTextField("협약 업체명, 지역", titleC,
                        autoFocus: false, prefixIcon: Icon(Icons.search),
                        textInput: (String key)  {
                          _onSearchList(key);
                        }
                      ))
                : SizedBox(),
            selectValue == valueList[1]
                ? Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: itemCount + 1,
                        itemBuilder: (context, index) {
                          for (int i = 0; i < contractingList.length; i++) {
                            deleteList.add(false);
                          }
                          print(
                              "index: $index, searchContractingList.length: ${searchContractingList.length}, itemCount: $itemCount");
                          if (index == itemCount) {
                            if (searchContractingList.length == 0) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                elevation: 5,
                                margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                                child: Center(
                                  child: Padding(
                                      padding: EdgeInsets.all(Consts.padding),
                                      child: Text(
                                        msg,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      )),
                                ),
                              );
                            } else if (index == searchContractingList.length) {
                              return Padding(
                                padding: EdgeInsets.all(Consts.padding),
                                child: makeGradientBtn(
                                    msg: "맨 처음으로",
                                    onPressed: () {
                                      _scrollController.animateTo(
                                          _scrollController
                                              .position.minScrollExtent,
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.elasticOut);
                                    },
                                    mode: 1,
                                    icon: Icon(
                                      Icons.arrow_upward,
                                      color: Colors.white,
                                    )),
                              );
                            } else {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                elevation: 5,
                                margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(Consts.padding),
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              );
                            }
                          } else {
                            return buildItemCompany(
                                context, index, searchContractingList);
                          }
                        }))
                : Expanded(
                    child: Align(
                      child: FutureBuilder(
                          future: _getContractingList(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              contractingList = snapshot.data;
                              for (int i = 0; i < contractingList.length; i++) {
                                deleteList.add(false);
                              }
                              if (contractingList.length <=
                                  Consts.showItemCount) {
                                itemCount = contractingList.length;
                              }
                              return ListView.builder(
                                  controller: _scrollController,
                                  itemCount: itemCount + 1,
                                  itemBuilder: (context, index) {
                                    if (index == itemCount) {
                                      if (index == 0) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18)),
                                          elevation: 5,
                                          margin: EdgeInsets.fromLTRB(
                                              25, 13, 25, 13),
                                          child: Center(
                                            child: Padding(
                                                padding: EdgeInsets.all(
                                                    Consts.padding),
                                                child: Text(
                                                  "등록된 협약업체가 없습니다.",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )),
                                          ),
                                        );
                                      } else if (index ==
                                          contractingList.length) {
                                        return Padding(
                                          padding:
                                              EdgeInsets.all(Consts.padding),
                                          child: makeGradientBtn(
                                              msg: "맨 처음으로",
                                              onPressed: () {
                                                _scrollController.animateTo(
                                                    _scrollController.position
                                                        .minScrollExtent,
                                                    duration: Duration(
                                                        milliseconds: 200),
                                                    curve: Curves.elasticOut);
                                              },
                                              mode: 1,
                                              icon: Icon(
                                                Icons.arrow_upward,
                                                color: Colors.white,
                                              )),
                                        );
                                      } else {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18)),
                                          elevation: 5,
                                          margin: EdgeInsets.fromLTRB(
                                              25, 13, 25, 13),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  Consts.padding),
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        );
                                      }
                                    } else {
                                      return buildItemCompany(
                                          context, index, contractingList);
                                    }
                                  });
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Future<List<ContractingVO>> _getContractingList() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print("token: ${token}");
    try {
      var res = await helper.getContList(token);
      if (res.success) {
        return res.list;
      } else {
        return null;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Widget buildItemCompany(
      BuildContext context, int index, List<ContractingVO> list) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ContractingCompanyDetailPage(
                        index: list[index].index,
                      )));
          setState(() {
            if (selectValue == valueList[0]) {
              _getContractingList();
            } else {
              _onSearchList(titleC.text);
            }
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
                      "${list[index].title}",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                  ),
                  widget.role == User.user
                      ? SizedBox()
                      : IconButton(
                          icon: deleteList[index]
                              ? Icon(
                                  Icons.check_box_outlined,
                                  size: 28,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  size: 28,
                                ),
                          onPressed: () => _onCheckPressed(index)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Text(
                  "${list[index].info}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 22,
                child: Row(
                  children: [
                    list[index].tag.length == 0
                        ? SizedBox()
                        : buildItemTag(list[index].tag, 0),
                    list[index].tag.length > 1
                        ? Container(
                            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.blue[400],
                                )),
                            child: Center(
                              child: Text(
                                "외 ${list[index].tag.length - 1}개",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        : SizedBox(),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "평균 연봉: ${list[index].salary.isEmpty ? "미입력" : list[index].salary}",
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

  _onSearchList(String key) async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    var res = await helper.getContListKeyword(token, key);
    if (res.success)
      setState(() {
        searchContractingList = res.list;
        if (searchContractingList.length <=
            Consts.showItemCount) {
          itemCount = searchContractingList.length;
          print(searchContractingList.length);
          msg = "검색된 협약업체가 없습니다.";
        } else {
          itemCount = Consts.showItemCount;
        }
      });
  }

  _onDeleteCompany() {
    List<int> deleteComp = [];
    for (int i = 0; i < contractingList.length; i++) {
      if (deleteList[i]) {
        deleteComp.add(contractingList[i].index);
      }
    }

    if (deleteComp.isEmpty) {
      snackBar("삭제할 업체를 선택해주세요.", context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => StdDialog(
                msg: "선택된 협약 업체를 삭제하시겠습니까?",
                size: Size(326, 124),
                btnName1: "아니요",
                btnCall1: () {
                  Navigator.pop(context);
                },
                btnName2: "삭제하기",
                btnCall2: () async {
                  final pref = await SharedPreferences.getInstance();
                  var token = pref.getString("accessToken");
                  print("token: ${token}");
                  try {
                    for (int i = 0; i < deleteComp.length; i++) {
                      var res = await helper.deleteCont(token, deleteComp[i]);
                      if (res.success) {
                        setState(() {
                          print("삭제함: ${res.msg}");
                          itemCount--;
                        });
                      } else {
                        snackBar(res.msg, context);
                        print("errorr: ${res.msg}");
                      }
                    }
                    Navigator.pop(context, true);
                  } catch (e) {
                    print(e);
                  }
                  deleteList.clear();
                },
              ),
          barrierDismissible: false);
    }
  }
}
