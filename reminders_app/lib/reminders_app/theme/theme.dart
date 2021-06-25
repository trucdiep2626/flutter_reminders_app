import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class ThemeText {
  static TextStyle headlineListScreen = TextStyle(
      color: Colors.blue,
      fontSize: ScreenUtil().setSp(25),
      fontWeight: FontWeight.w700);
  static TextStyle headline2ListScreen = TextStyle(
      color: Colors.blue,
      fontSize: ScreenUtil().setSp(20),
      fontWeight: FontWeight.w700);
  static TextStyle title2= TextStyle(
      fontSize: ScreenUtil().setSp(15),
      color: Colors.black,
      fontWeight: FontWeight.w500);

  static TextStyle actionButton= TextStyle(
      fontSize: ScreenUtil().setSp(15),
      color: Colors.black,
      fontWeight: FontWeight.w600);
  static TextStyle subtitle= TextStyle(
  fontWeight: FontWeight.w500,
  color: Colors.grey,
  fontSize:  ScreenUtil().setSp(12));
  static TextStyle title =  TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: ScreenUtil().setSp(17)
  );
}
