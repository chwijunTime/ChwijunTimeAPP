import 'package:app_user/retrofit/retrofit_helper.dart';
import 'package:app_user/retrofit/token_interceptor.dart';
import 'package:app_user/screens/search_page.dart';
import 'package:app_user/widgets/button.dart';
import 'package:app_user/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPasswordDialog extends StatefulWidget {
  @override
  _EditPasswordDialogState createState() => _EditPasswordDialogState();
}

class _EditPasswordDialogState extends State<EditPasswordDialog> {
  RetrofitHelper helper;

  var passwordC = TextEditingController();
  var rePasswordC = TextEditingController();

  @override
  void dispose() {
    passwordC.dispose();
    rePasswordC.dispose();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
        width: 311,
        height: 280,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 60),
        decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 1,
                offset: const Offset(0.0, 0.0),
              )
            ]),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "변경할 비밀번호를 입력해주세요.",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            buildTextField("password", passwordC,
                autoFocus: false, password: true),
            SizedBox(
              height: 10,
            ),
            buildTextField("re password", rePasswordC,
                autoFocus: false, password: true),
            SizedBox(
              height: 10,
            ),
            makeGradientBtn(
                msg: "변경하기",
                onPressed: _putPassword,
                mode: 1,
                icon: Icon(
                  Icons.note_add,
                  color: Colors.white,
                ))
          ],
        )));
  }

  _putPassword() async {
    if (passwordC.text.isEmpty || rePasswordC.text.isEmpty) {
      snackBar("비밀번호를 입력해주세요.", context);
    } else {
      if (passwordC.text == rePasswordC.text) {
        helper = RetrofitHelper(await TokenInterceptor.getApiClient(context, () {
          setState(() {});
        }));
        try {
          var res = await helper
              .putChengPassword({"memberPassword": passwordC.text});
          if (res.success) {
            snackBar("비밀번호가 변경되었습니다.", context);
            Navigator.pop(context);
          } else {
            snackBar(res.msg, context);
            Navigator.pop(context);
          }
        } catch (e) {
          print("err: $e");
        }
      } else {
        snackBar("비밀번호를 다시 확인해주세요", context);
        Navigator.pop(context);
      }
    }
  }
}
