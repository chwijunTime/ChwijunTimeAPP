import 'package:app_user/model/portfolio_vo.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/drawer.dart';
import 'package:flutter/material.dart';

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  List<PortfolioVO> portList = [];
  
  init() {
    for(int i=0; i<10; i++) {
      portList.add(PortfolioVO(user: "3210_안수빈", state: i%2 == 0 ? "처리전":"처리후", url: "https://naver.com"));
    }
  }
  
  @override
  void initState() {
    super.initState();
    init();
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
                    "포트폴리오 첨삭 요청",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Expanded(child: ListView.separated(
              itemCount: portList.length,
              itemBuilder: (context, index) {
                return buildPortfolio(context, index);
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
              physics: ScrollPhysics(),
            ),)
          ],
        ),
      ),
    );
  }

  Widget buildPortfolio(BuildContext context, int index) {
    return Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: GestureDetector(
            onTap: () {
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${portList[index].user}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  portList[index].state == "처리전" ?
                  Container(
                    width: 48,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(color: Color(0xff5BC7F5))),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        "처리전",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff5BC7F5)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ) :
                  Container(
                    width: 48,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(color: Color(0xffFF7777))),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        "처리후",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffFF7777)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
