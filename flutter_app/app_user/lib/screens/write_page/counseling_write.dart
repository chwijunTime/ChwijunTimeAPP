import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:flutter/material.dart';

class CounselingWrite extends StatefulWidget {
  @override
  _CounselingWriteState createState() => _CounselingWriteState();
}

class _CounselingWriteState extends State<CounselingWrite> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String strDate = "날짜";
  String strTime = "시간";
  String date, time = "";

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
                          "상담이 가능한 날짜와 시간, 장소를 입력해주세요!",
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
                                strDate = "${selectedDate.year}년 ${selectedDate
                                    .month}월 ${selectedDate.day}일";
                              });
                              date = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
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
                            initialEntryMode: TimePickerEntryMode.dial);
                            if (pickTime != null) {
                              setState(() {
                                selectedTime = pickTime;
                                if (pickTime.hour <12) {
                                  strTime = "오전 ${pickTime.hour == 0 ? 12 : pickTime.hour}시 ${pickTime.minute}분";
                                } else {
                                  strTime = "오후 ${pickTime.hour == 12 ? 12 : pickTime.hour -12 }시 ${pickTime.minute}분";
                                }
                              });
                              time = "${selectedTime.hour}:${selectedTime.minute}";
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

  _onCounselingWrite() {
    if (date == "" || time == "") {
      snackBar("빈칸이 없도록 작성해주세요", context);
    } else {
      Navigator.pop(context);
    }
  }
}
