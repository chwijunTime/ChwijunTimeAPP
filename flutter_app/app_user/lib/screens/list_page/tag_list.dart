import 'package:app_user/model/user.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/dialog/tag_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:flutter/material.dart';

import '../search_page.dart';

class TagList extends StatefulWidget {
  String role;

  @override
  _TagListState createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  List<String> tagList = [];
  List<bool> deleteTag = [];

  initList() {
    for (int i = 0; i < 15; i++) {
      tagList.add("${i}.모야");
      deleteTag.add(false);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.role = User.role;
    initList();
  }

  _onCheckPressed(int index) {
    setState(() {
      deleteTag[index] = !deleteTag[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      drawer: buildDrawer(context),
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
                    "태그(분야)",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            widget.role == "user"
                ? Padding(
                    padding: EdgeInsets.only(right: 20, left: 20, bottom: 10),
                    child: makeGradientBtn(
                        msg: "태그 등록 요청",
                        onPressed: () {},
                        mode: 1,
                        icon: Icon(
                          Icons.mail,
                          color: Colors.white,
                        )),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        makeGradientBtn(
                            msg: "태그 등록",
                            onPressed: () {
                              print("등록하자");
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => TagDialog(
                                        mode: "post",
                                      ));
                            },
                            mode: 1,
                            icon: Icon(
                              Icons.note_add,
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
                    ),
                  ),
            Expanded(
              child: ListView.separated(
                itemCount: tagList.length,
                itemBuilder: (context, index) {
                  return buildTag(context, index);
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTag(BuildContext context, int index) {
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => TagDialog(
                mode: "modify",
                tag: tagList[index],
              ));
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                "${tagList[index]}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            widget.role == "user"
                ? InkWell(
                    onTap: () {},
                    child: Icon(Icons.tag),
                  )
                : InkWell(
                    onTap: () {
                      _onCheckPressed(index);
                    },
                    child: deleteTag[index]
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

  _onDeleteTag() {
    List<String> deleteList = [];
    for (int i = 0; i < tagList.length; i++) {
      if (deleteTag[i]) {
        deleteList.add(tagList[i]);
      }
    }

    if (deleteList.isEmpty) {
      snackBar("삭제할 업체를 선택해주세요.", context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => StdDialog(
                msg: "선택된 태그를 삭제하시겠습니까?",
                size: Size(326, 124),
                btnName1: "아니요",
                btnCall1: () {
                  Navigator.pop(context);
                },
                btnName2: "삭제하기",
                btnCall2: () {
                  print("삭제할 태그들================================");
                  print(deleteList.toString());
                  Navigator.pop(context);
                },
              ),
          barrierDismissible: false);
    }
  }
}
