import 'package:app_user/consts.dart';
import 'package:app_user/model/consulting/consulting_admin_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/back_button.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/counseling_apply_dialog.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CounselingApplyPage extends StatefulWidget {
  @override
  _CounselingApplyPageState createState() => _CounselingApplyPageState();
}

class _CounselingApplyPageState extends State<CounselingApplyPage> {
  List<ConsultingAdminVO> counAdminList = [];
  final _scrollController = ScrollController();
  RetrofitHelper helper;
  int itemCount = Consts.showItemCount;

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
        if (itemCount != counAdminList.length) {
          if ((counAdminList.length - itemCount) ~/ Consts.showItemCount <= 0) {
            itemCount = counAdminList.length;
          } else {
            itemCount += Consts.showItemCount;
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
        appBar: buildAppBar("취준타임", context),
        drawer: buildDrawer(context),
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
                      "취진부 상담신청",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: FutureBuilder(
                future: getCounselingAdminList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    counAdminList = snapshot.data;
                    if (counAdminList.length < Consts.showItemCount) {
                      itemCount = counAdminList.length;
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: itemCount + 1,
                      itemBuilder: (context, index) {
                        if (index == itemCount) {
                          if (counAdminList.length == 0) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              elevation: 5,
                              margin: EdgeInsets.fromLTRB(25, 13, 25, 13),
                              child: Center(
                                child: Padding(
                                    padding: EdgeInsets.all(Consts.padding),
                                    child: Text(
                                      "등록된 상담이 없습니다.",
                                      style:
                                          TextStyle(fontWeight: FontWeight.w700),
                                    )),
                              ),
                            );
                          } else if (index == counAdminList.length) {
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
                          return buildCounseling(context, index);
                        }
                      },
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<ConsultingAdminVO>> getCounselingAdminList() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getConsultingAdminList();
      if (res.success) {
            return res.list;
      } else {
        return null;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Widget buildCounseling(BuildContext context, int index) {
    var tempDate =
        DateFormat("yyyy-MM-ddTHH:mm").parse(counAdminList[index].applyDate);
    var strDate = DateFormat("yyyy년 MM월 dd일 HH시 mm분").format(tempDate);
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18))),
        elevation: 5,
        margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: Padding(
          padding: EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strDate,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              counAdminList[index].status == "No_Application"
                  ? InkWell(
                      child: Icon(
                        Icons.outgoing_mail,
                        color: Color(0xff4687ff),
                      ),
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CounselingApplyDialog(counAdminList[index]));
                        setState(() {
                          getCounselingAdminList();
                        });
                      },
                    )
                  : Container(
                      width: 48,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          border: Border.all(color: Color(0xffFF7777))),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2, top: 2),
                        child: Text(
                          "마감",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffFF7777)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}
