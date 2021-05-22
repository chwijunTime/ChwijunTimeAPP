import 'package:app_user/model/portfolio_vo.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/show_web_view.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/dialog/request_dialog.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  List<PortfolioVO> portList = [];

  @override
  void initState() {
    super.initState();
    portList.add(
        PortfolioVO(user: "오잉", state: "approve", url: "https://naver.com"));
    portList.add(
        PortfolioVO(user: "오잉", state: "approve", url: "https://naver.com"));
    portList.add(
        PortfolioVO(user: "오잉", state: "approve", url: "https://naver.com"));
    portList.add(
        PortfolioVO(user: "오잉", state: "approve", url: "https://naver.com"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                "포트폴리오",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return buildPortfolio(context, index);
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 1,
                          color: Colors.grey,
                        );
                      },
                      itemCount: portList.length))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPortfolio(BuildContext context, int index) {
    return Container(
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "포트폴리오 ${index + 1}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            RequestDialog(
                                vo: portList[index], mode: "portfolio"));
                  },
                  child: Icon(Icons.mail),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ShowWebView(url: portList[index].url)));
                  },
                  child: Icon(Icons.search),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    showDialog(context: context,
                        builder: (BuildContext context) => StdDialog(
                            msg: "선택한 포트폴리오를 삭제하시겠습니까?",
                            size: Size(326, 124),
                          btnName1: "아니요",
                          btnCall1: () {
                            Navigator.pop(context, false);
                          },
                          btnName2: "삭제하기",
                          btnCall2: () async {
                            final pref = await SharedPreferences.getInstance();
                            var token = pref.getString("accessToken");
                            try {
                              // TODO: 포트폴리오 삭제 요청보내기
                            } catch (e) {
                              print("err: ${e}");
                              Navigator.pop(context, false);
                              snackBar("이미 삭제된 포트폴리오 입니다.", context);
                            }
                          },
                        ));
                  },
                  child: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ));
  }
}
