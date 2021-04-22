import 'package:app_user/model/confirmation_status_vo.dart';
import 'package:app_user/screens/modify_page/confirmation_status_modify.dart';
import 'package:app_user/screens/show_web_view.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConfirmationStatusDetail extends StatefulWidget {
  final ConfirmationStatusVO list;
  Positioned position;

  ConfirmationStatusDetail({@required this.list});

  @override
  _ConfirmationStatusDetailState createState() =>
      _ConfirmationStatusDetailState();
}

class _ConfirmationStatusDetailState extends State<ConfirmationStatusDetail> {
  LatLng latLng;

  Future<LatLng> getCordinate() async {
    List<Location> location = await locationFromAddress(widget.list.address);
    latLng = LatLng(location[0].latitude, location[0].longitude);
    return latLng;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              margin: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 25,
              ),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 20, right: 20, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.list.title,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(child: Text("${widget.list.grade}학년")),
                          IconButton(icon: Icon(Icons.delete, size: 28,), onPressed: (){
                            showDialog(context: context, builder: (BuildContext context) => StdDialog(
                              msg: "해당 취업현황을 삭제하시겠습니까?",
                              size: Size(326, 124),
                              btnName1: "아니요",
                              btnCall1: () {Navigator.pop(context);},
                              btnName2: "삭제하기",
                              btnCall2: () {
                                print("삭제할 업체: ${widget.list.toString()}");
                                Navigator.pop(context);
                              },),
                                barrierDismissible: false);
                          })
                        ],
                      ),
                      Text(
                        "지역: ${widget.list.area}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowWebView(url: widget.list.siteUrl)));
                          },
                          child: Text(
                            "회사 사이트 바로가기",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xff5bc7f5)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              margin: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 25,
              ),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "주소",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.list.address,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      SizedBox(
                          width: 330,
                          height: 200,
                          child: FutureBuilder(
                              future: getCordinate(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData == false) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          latLng.latitude, latLng.longitude),
                                      zoom: 17,
                                    ),
                                    markers: _createMarker(),
                                  );
                                }
                              }))
                    ],
                  ),
                ),
              ),
            ),
            widget.list.etc != null
                ? Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    margin: EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 25,
                    ),
                    child: Container(
                      width: 361,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "비고",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            AutoSizeText(
                              widget.list.etc,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              minFontSize: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: makeGradientBtn(
                  msg: "취업 현황 수정하기",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ConfirmationStatusModify(list: widget.list)));
                  },
                  mode: 2, icon: Icon(Icons.arrow_forward, color: Colors.white,)),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Set<Marker> _createMarker() {
    return [
      Marker(
          markerId: MarkerId(widget.list.title),
          position: latLng,
          infoWindow: InfoWindow(
              title: widget.list.title, snippet: widget.list.address))
    ].toSet();
  }
}
