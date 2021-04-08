import 'package:flutter/material.dart';

Widget makeTagWidget({@required List<String> tag, @required Size size, @required int mode}) {
  return SizedBox(
      height: 28+size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "태그",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 1,
            width: 360,
            color: Colors.grey[500],
            margin: EdgeInsets.only(bottom: 5, top: 5),
          ),
          if (mode == 1)
              makeTagList(tag, size)
          else
              makeTagGrid(tag, size)
        ],
      ));
}

Widget makeTagList(List<String> tag, Size size) {
  return SizedBox(
    width: size.width,
    height: 20,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: tag.length,
        itemBuilder: (context, index) {
          return buildItemTag(tag, index);
        }),
  );
}

Widget makeTagGrid(List<String> tag, Size size) {
  return SizedBox(
    width: size.width,
    height: size.height,
    child: GridView.builder(
      itemCount: tag.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 5,
          mainAxisExtent: 20
        ),
        itemBuilder: (BuildContext context, index) => buildItemTag(tag, index)),
  );
}

Widget buildItemTag(List<String> tag, int index) {
  return Container(
    padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
    margin: EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.blue[400],
        )),
    child: Center(
      child: Text(
        "#${tag[index]}",
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      ),
    ),
  );
}
