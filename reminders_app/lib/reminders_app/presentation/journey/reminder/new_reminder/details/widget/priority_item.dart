import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriorityItemWidget extends StatelessWidget {
  final String name;
  final Color color;
  final Function onTap;
  final bool isNotLast;

  const PriorityItemWidget(
      {Key key,
      @required this.name,
      @required this.color,
      @required this.onTap,
      @required this.isNotLast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.translucent,
          child: Container(
              margin: EdgeInsets.all(ScreenUtil().setHeight(15)),
              child: Row(children: [
                Expanded(
                  flex: 20,
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenUtil().setHeight(10),
                    width: ScreenUtil().setHeight(10),
                    decoration:
                        BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                )
              ])),
        ),
        Visibility(
          visible: isNotLast,
          child: Container(
              height: ScreenUtil().setHeight(0.2),
              width: ScreenUtil().screenWidth - 50,
              color: Colors.black),
        ),
      ],
    );
  }
}
