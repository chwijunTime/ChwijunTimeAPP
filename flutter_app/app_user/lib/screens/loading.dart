import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingPage extends StatefulWidget {
  final String page;
  String role;

  LoadingPage({@required this.page});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    loadPage();
  }

  loadPage() {
    getRole().then((value) {
      setState(() {
        widget.role = value;
      });
      Navigator.of(context).pushNamedAndRemoveUntil(
          widget.page, (route) => false,);
    });
  }

  Future<String> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    var role = prefs.getString("role") ?? "user";
    print("role: ${role}");
    return role;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
