import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/constants/route_constants.dart';

class AppbarWidgetForListScreen extends AppBar {
  AppbarWidgetForListScreen(BuildContext context, Function onTapCreateNew)
      : super(
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: ScreenUtil().setSp(22),
              color: Colors.blue,
            ),
          ),
          title: Text(
            'Lists',
            style:
                TextStyle(color: Colors.blue, fontSize: ScreenUtil().setSp(20)),
          ),
          actions: [
            GestureDetector(
              onTap: onTapCreateNew,
              child: Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(2)),
                margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: ScreenUtil().setSp(30),
                  ),
                ),
              ),
            )
          ],
        );
}
