import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class HomePageConstant{
  static Icon iconScheduled =  Icon(
    Icons.calendar_today_sharp,
    size: ScreenUtil().setSp(22),
    color: Colors.white,
  );
  static Icon iconToday=  Icon(
  Icons.today,
  size: ScreenUtil().setSp(22),
  color: Colors.white,
  );
  static Icon iconAll=  Icon(
    Icons.format_align_left,
    size: ScreenUtil().setSp(22),
    color: Colors.white,
  );
  static Icon iconList=  Icon(
  Icons.list,
  size: ScreenUtil().setSp(22),
  color: Colors.white,
  );
  static Icon iconArrow =  Icon(
    Icons.arrow_forward_ios_rounded,
    size: ScreenUtil().setSp(15),
    color: Colors.grey,
  );
  static Widget listIconWidget(Color color){
    return Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: HomePageConstant.iconList);
  }
}