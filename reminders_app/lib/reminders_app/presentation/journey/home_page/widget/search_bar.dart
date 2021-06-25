import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SearchBar extends StatelessWidget{
  @override
  Widget build(BuildContext context)  {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(30),
          bottom: ScreenUtil().setHeight(25),
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20)),
      child: Container(
        height: ScreenUtil().setHeight(29),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        padding: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(3),
          top: ScreenUtil().setHeight(3),
          left: ScreenUtil().setWidth(10),
        ),
        child: TextField(
            decoration: InputDecoration(
              // fillColor: Colors.blue,
                enabled: false,
                border: InputBorder.none,
                icon: Icon(
                  Icons.search,
                  size: ScreenUtil().setSp(25),
                ),
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(15),
                ))),
      ),
    );
  }
  }


