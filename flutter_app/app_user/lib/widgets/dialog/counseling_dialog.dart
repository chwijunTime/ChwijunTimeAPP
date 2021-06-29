import 'package:app_user/model/consulting/consulting_admin_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CounselingDialog extends StatefulWidget {
  ConsultingAdminVO list;
  int index;

  CounselingDialog({@required this.index});

  @override
  _CounselingDialogState createState() => _CounselingDialogState();
}

class _CounselingDialogState extends State<CounselingDialog> {
  RetrofitHelper helper;

  String strDate;

  @override
  build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: FutureBuilder(
          future: _getConsulting(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              widget.list = snapshot.data;
              var tempDate = DateFormat("yyyy-MM-ddTHH:mm:ss")
                  .parse(widget.list.applyDate);
              strDate = DateFormat("yyyy년 MM월 dd일 HH시 mm분").format(tempDate);
              return buildDialog(context);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  buildDialog(BuildContext context) {
    return Container(
      width: 311,
      height: 140,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 60),
      decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 1,
              offset: const Offset(0.0, 0.0),
            )
          ]),
      child: Column(
        children: [
          Text(
            strDate,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Expanded(
              child: Center(
            child: Text(
              widget.list.status == "No_Application"
                  ? "해당 상담은 아직 신청자가 없습니다."
                  : "해당 상담은 마감되었습니다.",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              makeTag(widget.list.status),
              GestureDetector(
                onTap: _onDelete,
                child: Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onDelete() async {
    var res = await showDialog(
      context: context,
      builder: (context) => StdDialog(
        msg: "선택된 상담을 삭제하시겠습니까?",
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
            var res = await helper.deleteConsulting(widget.index);
            if (res.success) {
              snackBar("성공적으로 삭제되었습니다.", context);
              Navigator.pop(context, "delete");
            } else {
              snackBar(res.msg, context);
              print("err: ${res.msg}");
              Navigator.pop(context);
            }
          } catch (e) {
            print("error: $e");
          }
        },
      ),
      barrierDismissible: false
    );
    Navigator.pop(context, res);
  }

  Widget makeTag(String str) {
    String msg;
    Color color;

    if (str == "No_Application") {
      msg = "진행중";
      color = Color(0xff5BC7F5);
    } else {
      msg = "마감";
      color = Color(0xffFF7777);
    }

    return Container(
      width: 48,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: Border.all(color: color)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2, top: 2),
        child: Text(
          msg,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: color),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<ConsultingAdminVO> _getConsulting() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getConsultingAdmin(widget.index);
      if (res.success) {
        return res.data;
      } else {
        snackBar(res.msg, context);
        print("err: ${res.msg}");
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
