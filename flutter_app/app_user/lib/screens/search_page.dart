import 'package:app_user/widgets/app_bar.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  List<String> list = [];

  SearchPage({@required this.list});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Widget appBarTitle = new Text(
    "Search Sample",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> tagList= [];
  bool _IsSearching;
  String _searchText = "";

  _SearchPageState() {
    print(_searchQuery.text);
    print("_SearchPageState()");
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
          print(
              "searchtext = $_searchText, searchQuery.text = ${_searchQuery.text}");
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    print("list: ${widget.list}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: buildAppBar("이건 AppBar"),
        body: buildDropDownTextField());
  }

  List<ListTile> _buildSearchList() {
    if (_searchText.isEmpty) {
      return widget.list.map((contact) => ListTile(title: Text(contact))).toList();
    } else {
      List<String> _searchList = [];
      for (int i = 0; i < widget.list.length; i++) {
        String name = widget.list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.length != 0 ? _searchList
          .map((contact) => ListTile(
                title: Text(contact),
                onTap: () {
                  if (!tagList.contains(contact)) {
                    setState(() {
                      tagList.add(contact);
                    });
                  } else {
                    snackBar("중복된 태그입니다.", context);
                    print("중복된 태그입니다ㅣ");
                  }
                },
              ))
          .toList() :
      List.generate(1, (index) => ListTile(title: Text("검색된 태그가 없습니다."),)).toList();
    }
  }

  Widget buildDropDownTextField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(34,16,34,16),
          child: buildTextField("Tag", _searchQuery),
        ),
        Expanded(
          child: _IsSearching
              ? SizedBox(
                  child: Card(
                    margin: EdgeInsets.only(left: 34, right: 34),
                    elevation: 5,
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      children: _buildSearchList(),
                    ),
                  ),
                )
              : SizedBox(
            child: Card(
              margin: EdgeInsets.only(left: 34, right: 34),
              elevation: 5,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("태그 검색어를 입력해주세요!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800
                    ),),
                    SizedBox(height: 20,),
                    CircularProgressIndicator()
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
              height: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "태그",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 360,
                    color: Colors.grey[500],
                    margin: EdgeInsets.only(bottom: 5, top: 5),
                  ),
                  SizedBox(
                    width: 360,
                    height: 18,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: tagList.length,
                        itemBuilder: (context, index) {
                          return buildItemTag(index);
                        }),
                  ),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: makeBtn(
            msg: "태그 설정 완료!",
            onPressed: () {
              Navigator.pop(context, tagList);
            },
            mode: 1,
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 25,),
      ],
    );
  }

  Widget buildItemTag(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tagList.removeAt(index);
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.blue[400],
            )),
        child: Row(
          children: [
            Text(
              "#${tagList[index]}",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            Icon(
              Icons.highlight_remove_rounded,
              size: 10,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

void snackBar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    duration: Duration(milliseconds: 1000),
    backgroundColor: Colors.red[200],
  ));
}
