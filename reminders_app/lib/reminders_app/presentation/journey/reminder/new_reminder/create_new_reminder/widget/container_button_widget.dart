import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class ContainerButtonWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String content;
  final Function onPressed;

  ContainerButtonWidget(
      {Key key, this.title, this.subTitle, this.content, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(
          ScreenUtil().setWidth(10),
        ),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(7)),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(ScreenUtil().setHeight(8.0)),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(15),
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        content != null
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(0.7)),
                                child: Text(
                                  content,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue),
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: subTitle != null
                        ? Text(subTitle,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(12.5),
                              color: Colors.grey,
                            ))
                        : SizedBox(),
                  ),
                  Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: ScreenUtil().setSp(15),
                        color: Colors.grey,
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
