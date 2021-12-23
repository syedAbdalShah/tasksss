import 'package:flutter/material.dart';
import 'package:productbox_flutter_exercise/constants/theme_data.dart';
import 'package:sizer/sizer.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final Color? colors;
  final Widget? widget;
  MyButton({this.onTap, this.widget, this.colors});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          width: size.width,
          height: size.height * 0.08,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.width * 0.1),
              color: colors ?? MyThemeData.themeData.primaryColor),
          child: widget),
    );
  }
}
