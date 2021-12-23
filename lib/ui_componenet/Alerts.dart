import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Alerts {
  static Future<dynamic> showMessage(
      BuildContext context, String message, Function()? ontap) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              actionsPadding: EdgeInsets.all(8),
              content: Text(message),
              title: Text('message'),
              actions: [
                InkWell(
                  onTap: ontap,
                  child: Text(
                    'ok',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ));
  }
}
