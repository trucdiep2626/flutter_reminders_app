import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListItemWidget extends StatelessWidget {
  Function onTap;
  Color bgIcon;
  String name;
  ListItemWidget({
    Key,
    key,
    @required this.onTap,
    @required this.bgIcon,
    @required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      // alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: bgIcon ?? Colors.blue,
                      ),
                      child: Icon(
                        Icons.list,
                        size: ScreenUtil().setSp(22),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 22,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      // textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: ScreenUtil().setHeight(0.2),
              width: ScreenUtil().screenWidth - 50,
              color: Colors.grey),
        ]));
  }
}
