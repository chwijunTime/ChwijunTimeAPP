import 'package:app_user/model/comp_notice/comp_notice_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/modify_page/company_notice_modify.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/apply_write_dialog.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyNoticeDetailPage extends StatefulWidget {
  int index;
  Positioned position;
  CompNoticeVO list;

  CompanyNoticeDetailPage({this.index});

  String role;

  @override
  _CompanyNoticeDetailPageState createState() =>
      _CompanyNoticeDetailPageState();
}

class _CompanyNoticeDetailPageState extends State<CompanyNoticeDetailPage> {
  LatLng latLng;

  RetrofitHelper helper;
  GoogleMapController mapController;

  Future<LatLng> getCordinate() async {
    List<Location> location = await locationFromAddress(widget.list.address);
    latLng = LatLng(location[0].latitude, location[0].longitude);
    return latLng;
  }

  moveCamera() async {
    try {
      List<Location> location = await locationFromAddress(widget.list.address);
      latLng = LatLng(location[0].latitude, location[0].longitude);
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 9)));
    } catch (e) {
      print(e);
    }
  }

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

  Future<CompNoticeVO> _getNotice() async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("accessToken");
    print("index: ${widget.index}");
    print("token: ${token}");
    final res = await helper.getComp(token, widget.index);
    print(res.toJson());
    if (res.success) {
      return res.data;
    } else {
      Navigator.pop(context);
      snackBar("서버 에러", context);
      print("error: ${res.msg}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
            future: _getNotice(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                widget.list = snapshot.data;
                moveCamera();
                return ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
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
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.list.title,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  User.role == User.user
                                      ? SizedBox()
                                      : IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: _onDeleteCompNotice),
                                ],
                              ),
                              Text(
                                "채용분야: ${widget.list.field}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "공고일: ${DateFormat("yyyy년 MM월 dd일").format(DateFormat("yyyy-MM-dd").parse(widget.list.startDate))}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "마감일: ${DateFormat("yyyy년 MM월 dd일").format(DateFormat("yyyy-MM-dd").parse(widget.list.deadLine))}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
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
                                "지역",
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
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          return GoogleMap(
                                            initialCameraPosition:
                                                CameraPosition(
                                              target: LatLng(latLng.latitude,
                                                  latLng.longitude),
                                              zoom: 9,
                                            ),
                                            onMapCreated: (GoogleMapController
                                                controller) async {
                                              mapController = controller;
                                            },
                                            markers: _createMarker(),
                                          );
                                        }
                                      }))
                            ],
                          ),
                        ),
                      ),
                    ),
                    widget.list.info.isEmpty
                        ? SizedBox()
                        : Card(
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
                                      "회사 설명",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.list.info,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    widget.list.preferential.isEmpty
                        ? SizedBox()
                        : Card(
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
                                      "우대 조건",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.list.preferential,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    widget.list.etc.isEmpty
                        ? SizedBox(height: 25,) : Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            margin: EdgeInsets.all(25),
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "기타",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.list.etc,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    Align(
                      alignment: Alignment.center,
                      child: makeTagWidget(
                          tag: widget.list.tag, size: Size(360, 25), mode: 1),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    User.role == User.user
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, bottom: 25),
                              child: makeGradientBtn(
                                  msg: "해당 기업에 지원 신청",
                                  onPressed: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            ApplyWriteDialog(vo: widget.list));
                                  },
                                  mode: 2),
                            ),
                          )
                        : Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 25, right: 15, left: 15),
                              child: makeGradientBtn(
                                  msg: "취업 공고 수정하기",
                                  onPressed: () {
                                    _onModifyCompNotice();
                                  },
                                  mode: 1,
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  )),
                            ),
                          )
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  _onDeleteCompNotice() async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) => StdDialog(
            msg: "해당 취업 공고를 삭제하시겠습니까?",
            size: Size(326, 124),
            btnName1: "아니요",
            btnCall1: () {
              Navigator.pop(context, "no");
            },
            btnName2: "삭제하기",
            btnCall2: () async {
              print("삭제할 Comp: ${widget.list}");
              final pref = await SharedPreferences.getInstance();
              var token = pref.getString("accessToken");
              try {
                final res = await helper.deleteComp(token, widget.index);
                if (res.success) {
                  Navigator.pop(context, "yes");
                } else {
                  Navigator.pop(context, "no");
                  snackBar(res.msg, context);
                  print("error: ${res.msg}");
                }
              } catch (e) {
                print("error: ${e}");
                Navigator.pop(context, "no");
              }
            }),
        barrierDismissible: false);
    if (result == "yes") {
      Navigator.pop(context, "delete");
    }
  }

  _onModifyCompNotice() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CompanyNoticeModifyPage(
                  list: widget.list,
                )));

    setState(() {
      _getNotice();
    });
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
