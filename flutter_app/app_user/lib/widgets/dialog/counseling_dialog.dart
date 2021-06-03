import 'package:app_user/model/consulting/consulting_admin_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    super.initState();
    initRetrofit();
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

  @override
  build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: FutureBuilder (
        future: _getConsulting(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            widget.list = snapshot.data;
            var tempDate = DateFormat("yyyy-MM-dd hh:mm").parse(widget.list.applyDate);
            strDate = DateFormat("yyyy년 MM월 dd일 hh시 mm분").format(tempDate);
            return buildDialog(context);
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
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
                  widget.list.type == "No_Application" ? "해당 상담은 아직 신청자가 없습니다." : "해당 상담은 마감되었습니다.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              )),
          Align(
            alignment: Alignment.bottomRight,
            child: widget.list.type == "No_Application" ? Container(
              width: 48,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(color: Color(0xff5BC7F5))),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2, top: 2),
                child: Text(
                  "진행중",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff5BC7F5)),
                  textAlign: TextAlign.center,
                ),
              ),
            ) :Container(
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
          ),
        ],
      ),
    );
  }

  Future<ConsultingAdminVO> _getConsulting() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    var res = await helper.getConsultingAdmin(token, widget.index);
    if (res.success) {
      return res.data;
    } else {
      snackBar(res.msg, context);
      print("error: ${res.msg}");
    }
  }
}
