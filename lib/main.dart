import 'package:flutter/material.dart';
import 'package:productbox_flutter_exercise/constants/theme_data.dart';
import 'package:productbox_flutter_exercise/view/Dashboard_screen.dart';
import 'package:productbox_flutter_exercise/view/Login_screen.dart';
import 'package:productbox_flutter_exercise/view/document_upload_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ProductBox Flutter Exercise',
        theme: MyThemeData.themeData,
        routes: {},
        home: LoginScreen(),
      );
    });
  }
}
