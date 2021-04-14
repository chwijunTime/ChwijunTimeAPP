import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  bool isCreated;

  MyProfile({@required this.isCreated});

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var phoneC = TextEditingController();
  var addressC = TextEditingController();
  var classC = TextEditingController();
  var numberC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임"),
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
                    "프로필 생성",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 34, left: 34),
                child: Column(
                  children: [
                    buildTextField("전화번호", phoneC),
                    SizedBox(
                      height: 10,
                    ),
                    buildTextField("집주소", addressC),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(flex: 2, child: buildTextField("반", classC)),
                        SizedBox(width: 10,),
                        Expanded(flex: 3, child: buildTextField("번호", numberC))
                      ],
                    ),
                  ],
                )
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
