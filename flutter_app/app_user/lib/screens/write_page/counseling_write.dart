import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounselingWrite extends StatefulWidget {
  @override
  _CounselingWriteState createState() => _CounselingWriteState();
}

class _CounselingWriteState extends State<CounselingWrite> {
  RetrofitHelper helper;
  
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String strDate = "날짜";
  String strTime = "시간";
  String date, time = "";


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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar("취준타임", context),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(33),
            child: Center(
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "상담이 가능한 날짜와 시간을 입력해주세요!",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff4F9ECB)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2050));
                            if (picked != null) {
                              setState(() {
                                selectedDate = picked;
                                strDate = DateFormat("yyyy년 MM월 dd일").format(selectedDate);
                              });
                              date = DateFormat("yyyy-MM-dd").format(selectedDate);
                            }
                          },
                          child: Container(
                            width: constraints.maxWidth,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                strDate,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: strDate == "날짜" ? Colors.grey : Colors
                                        .black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final TimeOfDay pickTime = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            initialEntryMode: TimePickerEntryMode.input);
                            if (pickTime != null) {
                              setState(() {
                                selectedTime = pickTime;
                                strTime = DateFormat("HH시 mm분").format(selectedDate);
                              });
                              time = DateFormat("HH:mm").format(DateTime.now());
                              print(time);
                            }
                          },
                          child: Container(
                            width: constraints.maxWidth,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                strTime,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: strTime == "시간" ? Colors.grey : Colors
                                        .black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        makeGradientBtn(
                            msg: "등록하기",
                            onPressed: _onCounselingWrite,
                            mode: 4,
                            icon: Icon(
                              Icons.check,
                              color: Colors.white,
                            ))
                      ],
                    );
                  }),
            ),
          ),
        ));
  }

  _onCounselingWrite() async {
    if (date == "" || time == "") {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      final pref = await SharedPreferences.getInstance();
      var token = pref.getString("accessToken");
      var res = await helper.postConsultingAdmin(token, {"applicationDate": "${date}T${time}"});
      if (res.success) {
        Navigator.pop(context);
        print(res.msg);
      } else {
        snackBar(res.msg, context);
      }
    }
  }
}
