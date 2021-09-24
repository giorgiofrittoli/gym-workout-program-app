import 'package:flutter/material.dart';

class WidgetHelper {
  static SnackBar mySnackbar(String text) {
    return SnackBar(
      content: Text(
        text,
        style: TextStyle(
          fontSize: 15,
        ),
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(3),
          topRight: Radius.circular(3),
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.black,
    );
  }

  static Future<void> goHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed("/");
    return Future.value(false);
  }

  static double calcHeight(
    double perc,
    MediaQueryData mq, {
    hasNavbar = true,
    paddBottom = true,
  }) {
    return mq.size.height * perc -
        AppBar().preferredSize.height -
        (hasNavbar ? kBottomNavigationBarHeight : 0) -
        (paddBottom ? mq.padding.bottom : 0) -
        mq.padding.top;
  }

  static String? genericDataValidator(String field, String? data) {
    if (data == null || data.isEmpty) {
      return "Inserire $field";
    }
    return null;
  }
}
