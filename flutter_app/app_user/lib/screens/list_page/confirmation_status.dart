import 'package:app_user/consts.dart';
import 'package:app_user/model/confirmation/confirmation_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/detail_page/confirmation_status_detail.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/write_page/confirmation_status_write.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/back_button.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:app_user/widgets/drop_down_button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ConfirmationStatusPage extends StatefulWidget {
  String role;

  @override
  _ConfirmationStatusPageState createState() => _ConfirmationStatusPageState();
}

class _ConfirmationStatusPageState extends State<ConfirmationStatusPage> {
  final scafforldkey = GlobalKey<ScaffoldState>();
  RetrofitHelper helper;

  final _scrollController = ScrollController();
  final titleC = TextEditingController();
  int itemCount = Consts.showItemCount;
  List<String> valueList = ['전체보기', '검색하기'];
  String selectValue = "전체보기";
  String msg = "등록된 취업확정현황이 없습니다.";

  List<ConfirmationVO> confList = [];
  List<ConfirmationVO> searchConfList = [];
  List<bool> checkList = [];

  _onCheckPressed(int index) {
    setState(() {
      checkList[index] = !checkList[index];
    });
  }

  @override
  void initState() {
    super.initState();
    widget.role = User.role;
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    titleC.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        if (selectValue == valueList[0]) {
          if (itemCount != confList.length) {
            if ((confList.length - itemCount) ~/ Consts.showItemCount <= 0) {
              itemCount = confList.length;
            } else {
              itemCount += Consts.showItemCount;
            }
          }
        } else {
          if (itemCount != searchConfList.length) {
            if ((searchConfList.length - itemCount) ~/ Consts.showItemCount <=
                0) {
              itemCount = searchConfList.length;
            } else {
              itemCount += Consts.showItemCount;
            }
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackButtonWidget.backButtonWidget(
      context: context,
      child: Scaffold(
        key: scafforldkey,
        appBar: buildAppBar("취준타임", context),
        drawer: buildDrawer(context),
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
                          "취업확정 현황",
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
                            checkList.clear();
                            if (selectValue == valueList[1]) {
                              titleC.text = "";
                              itemCount = 0;
                              searchConfList.clear();
                              msg = "회사명, 기수, 지역으로 검색하기";
                            } else {
                              msg = "등록된 취업확정현황이 없습니다.";
                              itemCount = Consts.showItemCount;
                            }
                          });
                        },
                        hint: "보기"),
                  ],
                ),
              ),
              widget.role == User.user
                  ? SizedBox()
                  : Padding(
                      padding:
                          const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          makeGradientBtn(
                              msg: "취업 현황 등록",
                              onPressed: () async {
                                print("등록하자");
                                var res = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ConfirmationStatusWrite()));

                                setState(() {
                                  _getComfirmation();
                                });
                              },
                              mode: 1,
                              icon: Icon(
                                Icons.note_add,
                                color: Colors.white,
                              )),
                          makeGradientBtn(
                              msg: "선택된 현황 삭제",
                              onPressed: () {
                                _onDeleteConfirmation();
                              },
                              mode: 1,
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
              selectValue == valueList[1]
                  ? Padding(
                      padding: EdgeInsets.only(
                          right: 33, left: 33, bottom: 15, top: 15),
                      child: buildTextField("회사명, 기수, 지역", titleC,
                          autoFocus: false,
                          prefixIcon: Icon(Icons.search),
                          textInput: (String key) {
                            _onSearchList(key);
                          }))
                  : SizedBox(),
              Expanded(
                child: selectValue == valueList[1]
                    ? ListView.separated(
                        controller: _scrollController,
                        itemCount: itemCount + 1,
                        itemBuilder: (context, index) {
                          print("checkList: ${checkList.length}");
                          if (index == itemCount) {
                            if (searchConfList.length == 0) {
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
                            } else if (index == searchConfList.length) {
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
                            return buildState(context, index, searchConfList);
                          }
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
                      )
                    : FutureBuilder(
                        future: _getComfirmation(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            confList = snapshot.data;
                            for (int i = 0; i < confList.length; i++) {
                              checkList.add(false);
                            }
                            if (confList.length <= Consts.showItemCount) {
                              itemCount = confList.length;
                            }
                            return ListView.separated(
                              controller: _scrollController,
                              itemCount: itemCount + 1,
                              itemBuilder: (context, index) {
                                if (index == itemCount) {
                                  if (confList.length == 0) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      elevation: 5,
                                      margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                                      child: Center(
                                        child: Padding(
                                            padding:
                                                EdgeInsets.all(Consts.padding),
                                            child: Text(
                                              msg,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            )),
                                      ),
                                    );
                                  } else if (index == confList.length) {
                                    return Padding(
                                      padding: EdgeInsets.all(Consts.padding),
                                      child: makeGradientBtn(
                                          msg: "맨 처음으로",
                                          onPressed: () {
                                            _scrollController.animateTo(
                                                _scrollController
                                                    .position.minScrollExtent,
                                                duration:
                                                    Duration(milliseconds: 200),
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
                                  return buildState(context, index, confList);
                                }
                              },
                              separatorBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, right: 20),
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<ConfirmationVO>> _getComfirmation() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getConfList();
      if (res.success) {
        return res.list;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  _onSearchList(String key) async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getConfListKeyword(key);
      if (res.success) {
        setState(() {
          searchConfList = res.list;
          for (int i = 0; i < searchConfList.length; i++) {
            checkList.add(false);
          }
          if (searchConfList.length <= Consts.showItemCount) {
            itemCount = searchConfList.length;
            print(searchConfList.length);
            msg = "검색된 취업확정현황이 없습니다.";
          } else {
            itemCount = Consts.showItemCount;
          }
        });
      } else {
        snackBar(res.msg, context);
      }
    } catch (e) {
      print("error: $e");
    }
  }

  _onDeleteConfirmation() async {
    List<int> arr = [];
    for (int i = 0; i < confList.length; i++) {
      if (checkList[i]) {
        arr.add(confList[i].index);
      }
    }

    if (arr.isEmpty) {
      snackBar("삭제할 업체를 선택해주세요.", context);
    } else {
      var res = await showDialog(
          context: context,
          builder: (BuildContext context) => StdDialog(
                msg: "선택된 취업현황을 삭제하시겠습니까?",
                size: Size(326, 124),
                btnName1: "아니요",
                btnCall1: () {
                  Navigator.pop(context, false);
                },
                btnName2: "삭제하기",
                btnCall2: () async {
                  helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
                    setState(() {});
                  }));
                  try {
                    for (int i = 0; i < arr.length; i++) {
                      final res = await helper.deleteConf(arr[i]);
                      if (res.success) {
                        Navigator.pop(context, true);
                        itemCount--;
                      } else {
                        print("error: ${res.msg}");
                      }
                    }
                  } catch (e) {
                    print("err: ${e}");
                    snackBar("이미 삭제된 취업현황입니다.", context);
                  }
                },
              ),
          barrierDismissible: false);
      if (res != null && res) {
        setState(() {
          _getComfirmation();
          checkList.clear();
        });
      }
    }
  }

  Widget buildState(BuildContext context, int index, List<ConfirmationVO> vo) {
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ConfirmationStatusDetail(
                        index: vo[index].index,
                      )));
          setState(() {
            print("이?잉");
            _getComfirmation();
          });
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                "${vo[index].jockey} ${vo[index].name} - ${vo[index].title}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              "${vo[index].area}",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
            SizedBox(
              width: 10,
            ),
            User.role == User.user
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmationStatusDetail(
                                    index: vo[index].index,
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
}
