import 'package:app_user/model/review_vo.dart';
import 'package:app_user/screens/modify_page/interview_review_modify.dart';
import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/tag.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InterviewReviewDetail extends StatefulWidget {
  final ReviewVO list;
  Positioned position;

  InterviewReviewDetail({this.list});

  @override
  _InterviewReviewDetailState createState() => _InterviewReviewDetailState();
}

class _InterviewReviewDetailState extends State<InterviewReviewDetail> {
  LatLng latLng;

  _onFavoriteMarkPressed() {
    setState(() {
      widget.list.isFavorite = !widget.list.isFavorite;
      print(widget.list.isFavorite);
    });
  }

  Future<LatLng> getCordinate() async {
    List<Location> location = await locationFromAddress(widget.list.address);
    latLng = LatLng(location[0].latitude, location[0].longitude);
    return latLng;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("취준타임"),
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
                        children: [
                          Text(
                            widget.list.title,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 5,),
                          Expanded(child: Text("${widget.list.grade}학년")),
                          widget.list.isMine
                              ? IconButton(
                                  icon: Icon(
                                          Icons.delete_sharp,
                                          size: 28,
                                          color: Colors.black,
                                        ),
                                  onPressed: () => print("${widget.list.title} 을 삭제합니다."),
                                )
                              : IconButton(
                                  icon: widget.list.isFavorite
                                      ? Icon(
                                          Icons.favorite,
                                          size: 28,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.favorite_border_outlined,
                                          size: 28,
                                        ),
                                  onPressed: () => _onFavoriteMarkPressed(),
                                ),
                        ],
                      ),
                      Text(
                        "지원 날짜: ${widget.list.applyDate}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "비용: ${widget.list.price}",
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
                    tag: widget.list.tag, size: Size(360, 27), mode: 1)),
            SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: makeGradientBtn(msg: "면접 후기 수정하기", onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InterviewReviewModify(list: widget.list)));
                }, mode: 2, icon: Icon(Icons.arrow_forward, color: Colors.white,)),
              ),
            ),
            SizedBox(height: 25,),
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
