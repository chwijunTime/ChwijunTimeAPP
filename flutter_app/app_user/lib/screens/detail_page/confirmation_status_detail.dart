import 'package:app_user/model/confirmation/confirmation_vo.dart';
import 'package:app_user/model/confirmation/response_confirmation.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/modify_page/confirmation_status_modify.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/screens/show_web_view.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationStatusDetail extends StatefulWidget {
  ConfirmationVO list;
  Positioned position;
  int index;

  ConfirmationStatusDetail({@required this.index});

  @override
  _ConfirmationStatusDetailState createState() =>
      _ConfirmationStatusDetailState();
}

class _ConfirmationStatusDetailState extends State<ConfirmationStatusDetail> {
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
          CameraPosition(target: latLng, zoom: 17)));
    } catch(e) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
            future: _getComfirmation(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                final result = snapshot.data as ResponseConfirmation;
                widget.list = result.data;
                moveCamera();
                return ListView(
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
                                  Expanded(
                                    child: Text(
                                      "${widget.list.jockey}기 ${widget.list.name}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 28,
                                      ),
                                      onPressed: _onDelete)
                                ],
                              ),
                              Text(
                                "회사명: ${widget.list.title}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ShowWebView(
                                                url: widget.list.siteUrl)));
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
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
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
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          return GoogleMap(
                                            initialCameraPosition:
                                                CameraPosition(
                                              target: LatLng(latLng.latitude,
                                                  latLng.longitude),
                                              zoom: 17,
                                            ),
                                            onMapCreated: (GoogleMapController
                                                controller) async {
                                              mapController = controller;
                                            },
                                            markers: _createMarker(),
                                          );
                                        }
                                      })),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "지역: ${widget.list.area}",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
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
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
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
                    Align(
                        alignment: Alignment.center,
                        child: makeTagWidget(
                            tag: widget.list.tag,
                            size: Size(360, 27),
                            mode: 1)),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25, left: 25),
                      child: makeGradientBtn(
                          msg: "취업 현황 수정하기",
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ConfirmationStatusModify(
                                          list: widget.list,
                                        )));
                            print("hi");
                            setState(() {
                              _getComfirmation();
                            });
                          },
                          mode: 2,
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                      height: 25,
                    ),
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

  Future<ResponseConfirmation> _getComfirmation() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print(token);
    var res = await helper.getConf(token, widget.index);
    print("res.success: ${res.success}");
    if (res.success) {
      return res;
    } else {
      return null;
    }
  }

  _onDelete() async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) => StdDialog(
              msg: "해당 취업현황을 삭제하시겠습니까?",
              size: Size(326, 124),
              btnName1: "아니요",
              btnCall1: () {
                Navigator.pop(context, "no");
              },
              btnName2: "삭제하기",
              btnCall2: () async {
                final pref = await SharedPreferences.getInstance();
                var token = pref.getString("accessToken");
                try {
                  final res = await helper.deleteConf(token, widget.list.index);
                  if (res.success) {
                    snackBar("삭제되었습니다.", context);
                    Navigator.pop(context);
                  } else {
                    print("errorr: ${res.msg}");
                  }
                } catch (e) {
                  print("err: ${e}");
                  Navigator.pop(context, false);
                  snackBar("이미 삭제된 취업현황입니다.", context);
                }
              },
            ),
        barrierDismissible: false);

    if (result == null) {
      Navigator.pop(context);
    }
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
