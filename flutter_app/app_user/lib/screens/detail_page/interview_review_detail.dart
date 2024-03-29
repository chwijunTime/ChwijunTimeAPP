import 'package:app_user/model/company_review/review_vo.dart';
import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/modify_page/interview_review_modify.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/dialog/std_dialog.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class InterviewReviewDetail extends StatefulWidget {
  ReviewVO list;
  Positioned position;
  int index;

  InterviewReviewDetail({this.index});

  @override
  _InterviewReviewDetailState createState() => _InterviewReviewDetailState();
}

class _InterviewReviewDetailState extends State<InterviewReviewDetail> {
  LatLng latLng;
  GoogleMapController mapController;
  RetrofitHelper helper;

  Future<LatLng> getCoordinate() async {
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
        child: FutureBuilder(
            future: _getReview(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                widget.list = snapshot.data;
                _moveCamera();
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_sharp,
                                      size: 28,
                                      color: Colors.black,
                                    ),
                                    onPressed: _onDelete,
                                  )
                                ],
                              ),
                              Text(
                                "지원 날짜: ${DateFormat("yyyy년 MM월 dd일").format(DateFormat("yyyy-MM-dd").parse(widget.list.applyDate))}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "비용: ${widget.list.price}원",
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
                                height: 10,
                              ),
                              SizedBox(
                                  width: 330,
                                  height: 200,
                                  child: FutureBuilder(
                                      future: getCoordinate(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        print(
                                            "hasData: ${snapshot.hasData}, hasError: ${snapshot.hasError},");
                                        if (snapshot.hasData) {
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
                                        } else if (snapshot.hasError) {
                                          return Container(
                                            color: Colors.grey[200],
                                            child: Text(
                                              "주소를 찾을 수 없습니다.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            alignment: Alignment.center,
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }))
                            ],
                          ),
                        ),
                      ),
                    ),
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
                                "후기 내용",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AutoSizeText(
                                widget.list.review,
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
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
                                "자주 나온 질문",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AutoSizeText(
                                widget.list.question,
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
                    ),
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
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: makeGradientBtn(
                            msg: "면접 후기 수정하기",
                            onPressed: () {
                              _onMoveModify();
                            },
                            mode: 2,
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )),
                      ),
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

  Future<ReviewVO> _getReview() async {
    helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
      setState(() {});
    }));
    try {
      var res = await helper.getReview(widget.index);
      if (res.success) {
        return res.data;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  _onDelete() async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) => StdDialog(
              msg: "해당 취업확정현황을 삭제하시겠습니까?",
              size: Size(326, 124),
              btnName1: "아니요",
              btnCall1: () {
                Navigator.pop(context, "no");
              },
              btnName2: "삭제하기",
              btnCall2: () async {
                helper = RetrofitHelper(
                    await TokenInterceptor.getApiClient(context, () {
                  setState(() {});
                }));
                try {
                  var res = await helper.deleteReview(widget.list.index);
                  if (res.success) {
                    Navigator.pop(context);
                  } else {
                    snackBar(res.msg, context);
                    print("error: ${res.msg}");
                    Navigator.pop(context, false);
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
        barrierDismissible: false);
    if (result == null) {
      Navigator.pop(context);
    }
  }

  _onMoveModify() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InterviewReviewModify(list: widget.list)));
    setState(() {
      _getReview();
    });
  }

  _moveCamera() async {
    try {
      List<Location> location = await locationFromAddress(widget.list.address);
      latLng = LatLng(location[0].latitude, location[0].longitude);
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 17)));
    } catch (e) {
      print("err: ${e}");
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
