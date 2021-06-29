import 'package:app_user/consts.dart';
import 'package:app_user/model/tag/tag_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:flutter/material.dart';

class ReqTagList extends StatefulWidget {
  @override
  _ReqTagListState createState() => _ReqTagListState();
}

class _ReqTagListState extends State<ReqTagList> {
  RetrofitHelper helper;
  List<TagVO> reqTagList = [];
  List<bool> selectTag = [];

  int itemCount = Consts.showItemCount;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        if (itemCount != reqTagList.length) {
          if ((reqTagList.length - itemCount) ~/ Consts.showItemCount <= 0) {
            itemCount = reqTagList.length;
          } else {
            itemCount += Consts.showItemCount;
          }
        }
      });
    }
  }

  _onCheckPressed(int index) {
    setState(() {
      selectTag[index] = !selectTag[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
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
                    "요청 태그 보기",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    makeGradientBtn(
                        msg: "선택된 태그 저장",
                        onPressed: () {
                          _onPostTag();
                        },
                        mode: 1,
                        icon: Icon(
                          Icons.save_alt,
                          color: Colors.white,
                        )),
                    makeGradientBtn(
                        msg: "선택된 태그 삭제",
                        onPressed: () {
                          _onDeleteTag();
                        },
                        mode: 1,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ))
                  ],
                )),
            Expanded(
              child: FutureBuilder(
                  future: _getReqTagList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      reqTagList = snapshot.data;
                      for (int i = 0; i < reqTagList.length; i++) {
                        selectTag.add(false);
                      }
                      if (reqTagList.length <= Consts.showItemCount) {
                        itemCount = reqTagList.length;
                      }
                      return ListView.separated(
                        controller: _scrollController,
                        itemCount: itemCount + 1,
                        itemBuilder: (context, index) {
                          if (index == itemCount) {
                            if (index == 0) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                elevation: 5,
                                margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                                child: Center(
                                  child: Padding(
                                      padding: EdgeInsets.all(Consts.padding),
                                      child: Text(
                                        "요청된 태그가 없습니다.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      )),
                                ),
                              );
                            } else if (index == reqTagList.length) {
                              return Padding(
                                padding: EdgeInsets.all(20),
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
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          } else {
                            return buildTag(context, index);
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
    );
  }

  Future<List<TagVO>> _getReqTagList() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getReqTagList();
      if (res.success) {
        return res.list.reversed.toList();
      } else {
        return null;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Widget buildTag(BuildContext context, int index) {
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${reqTagList[index].name}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          User.role == User.user
              ? InkWell(
                  onTap: () {},
                  child: Icon(Icons.tag),
                )
              : InkWell(
                  onTap: () {
                    _onCheckPressed(index);
                  },
                  child: selectTag[index]
                      ? Icon(
                          Icons.check_box_outlined,
                          color: Colors.red,
                        )
                      : Icon(Icons.check_box_outline_blank),
                )
        ],
      ),
    ));
  }

  _onPostTag() async {
    List<TagVO> postList = [];
    for (int i = 0; i < reqTagList.length; i++) {
      if (selectTag[i]) {
        postList.add(reqTagList[i]);
      }
    }

    if (postList.isEmpty) {
      snackBar("저장할 태그를 선택해주세요.", context);
    } else {
      var res = await showDialog(
          context: context,
          builder: (BuildContext context) => StdDialog(
                msg: "선택된 태그를 저장하시겠습니까?",
                size: Size(326, 124),
                btnName1: "아니요",
                btnCall1: () {
                  Navigator.pop(context);
                },
                btnName2: "저장하기",
                btnCall2: () async {
                  try {
                    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
                      setState(() {});
                    }));
                    for (int i = 0; i < postList.length; i++) {
                      var res =
                          await helper.postTag(postList[i].toJson());
                      if (res.success) {
                        print("저장함: ${res.msg}");
                        selectTag.clear();
                      } else {
                        print("error: ${res.msg}");
                        snackBar(res.msg, context);
                        Navigator.pop(context,);
                        return;
                      }
                    }
                    Navigator.pop(context, true);
                  } catch (e) {
                    print(e);
                  }
                },
              ),
          barrierDismissible: false);
      if (res != null && res) {
        snackBar("태그가 저장되었습니다.", context);
      }
      setState(() {
        _getReqTagList();
      });
    }
  }

  _onDeleteTag() async {
    List<int> deleteList = [];
    for (int i = 0; i < reqTagList.length; i++) {
      if (selectTag[i]) {
        deleteList.add(reqTagList[i].index);
      }
    }

    if (deleteList.isEmpty) {
      snackBar("삭제할 태그를 선택해주세요.", context);
    } else {
      var res = await showDialog(
          context: context,
          builder: (BuildContext context) => StdDialog(
                msg: "선택된 태그를 삭제하시겠습니까?",
                size: Size(326, 124),
                btnName1: "아니요",
                btnCall1: () {
                  Navigator.pop(context);
                },
                btnName2: "삭제하기",
                btnCall2: () async {
                  try {
                    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
                      setState(() {});
                    }));
                    for (int i = 0; i < deleteList.length; i++) {
                      var res = await helper.deleteReqTag(deleteList[i]);
                      if (res.success) {
                        print("삭제함: ${res.msg}");
                        selectTag.clear();
                        itemCount --;
                      } else {
                        print("errorr: ${res.msg}");
                      }
                    }
                    Navigator.pop(context, true);
                  } catch (e) {
                    print(e);
                  }
                },
              ),
          barrierDismissible: false);
      if (res != null && res) {
        setState(() {
          _getReqTagList();
        });
      }
    }
  }
}
