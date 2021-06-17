import 'package:app_user/model/contracting_company/contracting_vo.dart';
import 'package:app_user/model/user.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/screens/modify_page/contracting_company_modify.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContractingCompanyDetailPage extends StatefulWidget {
  ContractingVO list;
  Positioned position;
  String role;
  int index;

  ContractingCompanyDetailPage({this.index});

  @override
  _ContractingCompanyDetailPageState createState() =>
      _ContractingCompanyDetailPageState();
}

class _ContractingCompanyDetailPageState
    extends State<ContractingCompanyDetailPage> {
  RetrofitHelper helper;
  LatLng latLng;

  GoogleMapController mapController;

  Future<LatLng> getCordinate() async {
    List<Location> location = await locationFromAddress(widget.list.address);
    latLng = LatLng(location[0].latitude, location[0].longitude);
    return latLng;
  }

  @override
  void initState() {
    super.initState();
    widget.role = User.role;
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

  moveCamera() async {
    try {
      List<Location> location = await locationFromAddress(widget.list.address);
      latLng = LatLng(location[0].latitude, location[0].longitude);
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 17)));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임", context),
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: _getContracting(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            widget.list = snapshot.data;
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
                            children: [
                              Expanded(
                                child: Text(
                                  widget.list.title,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              widget.role == User.user
                                  ? SizedBox()
                                  : IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 28,
                                      ),
                                      onPressed: () {
                                        _onDeleteComp();
                                      },
                                    ),
                            ],
                          ),
                          Text(
                            "지역: ${widget.list.area}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "평균: ${widget.list.salary}",
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
                                  }))
                        ],
                      ),
                    ),
                  ),
                ),
                widget.list.info.isEmpty ? SizedBox() :
                Card(
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
                            "회사 설명",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
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
                SizedBox(
                  height: 25,
                ),
                Align(
                    alignment: Alignment.center,
                    child: makeTagWidget(
                        tag: widget.list.tag, size: Size(360, 27), mode: 1)),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: makeGradientBtn(
                          msg: "협약 업체 수정하기",
                          onPressed: () {
                            _moveModify();
                          },
                          mode: 2,
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )),
                    )),
                SizedBox(
                  height: 25,
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

  Future<ContractingVO> _getContracting() async {
    final pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    print("token: ${token}");
    try {
      var res = await helper.getCont(token, widget.index);
      print("res.success: ${res.success}");
      if (res.success) {
        return res.data;
      } else {
        return null;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  _moveModify() async {
      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContractingCompanyModify(list: widget.list)));
      setState(() {
        _getContracting();
      });
  }

  _onDeleteComp() async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) => StdDialog(
              msg: "해당 협약 업체를 삭제하시겠습니까?",
              size: Size(326, 124),
              btnName1: "아니요",
              btnCall1: () {
                Navigator.pop(context, "no");
              },
              btnName2: "삭제하기",
              btnCall2: () async {
                final pref = await SharedPreferences.getInstance();
                var token = pref.getString("accessToken");
                print("token: ${token}");
                try {
                  var res = await helper.deleteCont(token, widget.index);
                  if (res.success) {
                    Navigator.pop(context, "yes");
                  } else {
                    snackBar(res.msg, context);
                    print("error: ${res.msg}");
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
        barrierDismissible: false);

    if (result == "yes") {
      Navigator.pop(context, true);
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
