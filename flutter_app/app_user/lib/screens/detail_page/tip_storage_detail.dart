import 'package:app_user/model/tip/tip_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/modify_page/tip_storage_modify.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:flutter/material.dart';

class TipStorageDetail extends StatefulWidget {
  TipVO list;
  int index;

  TipStorageDetail({@required this.index});

  @override
  _TipStorageDetailState createState() => _TipStorageDetailState();
}

class _TipStorageDetailState extends State<TipStorageDetail> {
  RetrofitHelper helper;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 24),
          child: FutureBuilder(
            future: _getTip(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                widget.list = snapshot.data;
                return Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.list.title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text("주소: ${widget.list.address}",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18))),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "꿀팁 정보",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                widget.list.tipInfo,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: makeTagWidget(
                              tag: widget.list.tag,
                              size: Size(360, 27),
                              mode: 1)),
                      SizedBox(
                        height: 25,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            makeGradientBtn(
                                msg: "수정하기",
                                onPressed: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TipStorageModify(
                                              list: widget.list)));
                                  setState(() {
                                    _getTip();
                                  });
                                },
                                mode: 1,
                                icon: Icon(
                                  Icons.note_add,
                                  color: Colors.white,
                                )),
                            makeGradientBtn(
                                msg: "삭제하기",
                                onPressed: _deleteTip,
                                mode: 1,
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<TipVO> _getTip() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getTip(widget.index);
      if (res.success) {
        return res.data;
      } else {
        print("err: ${res.msg}");
      }
    } catch (e) {
      print("err: $e");
    }
  }

  _deleteTip() async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) => StdDialog(
          msg: "해당 꿀팁을 삭제하시겠습니까?",
          size: Size(326, 124),
          btnName1: "아니요",
          btnCall1: () {
            Navigator.pop(context, "no");
          },
          btnName2: "삭제하기",
          btnCall2: () async {
            helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
              setState(() {});
            }));
            try {
              var res = await helper.deleteTip(widget.index);
              if (res.success) {
                Navigator.pop(context, "yes");
              } else {
                snackBar(res.msg, context);
                print("error: ${res.msg}");
              }
            } catch (e) {
              print(e);
            }
          },
        ),
        barrierDismissible: false);

    if (result == "yes") {
      Navigator.pop(context, true);
    }
  }
}
