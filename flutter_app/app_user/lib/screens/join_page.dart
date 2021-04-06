import 'package:flutter/material.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Image.asset(
                      "images/top.png",
                      fit: BoxFit.fill,
                    )),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "정보입력",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      ),
                      Text(
                        "취준타임과 취업준비해요.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Text(
                        "아직 계정이 없으신가요?",
                        style: TextStyle(color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      )),
                  GestureDetector(
                      onTap: () {},
                      child: Text(
                        "계정이 기억나지 않으시나요?",
                        style: TextStyle(color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      )),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Image.asset(
                  "images/bottom.png",
                  fit: BoxFit.fill,
                ))
          ],
        ),
      ),
    );
  }
}
