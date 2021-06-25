import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmDialog extends StatelessWidget{
  Function onPressedOk;
  Function onPressedCancel;
String content;
String confirmText;
String title;
  ConfirmDialog({@required this.onPressedOk,
    @required this.onPressedCancel,
  @required this.title,
    @required this.confirmText,
  this.content});

  @override
  Widget build(BuildContext context) {
  return AlertDialog(
    titlePadding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w,0),
    contentPadding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w,20.w),
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)),
    content: content!=null?Text(content,textAlign: TextAlign.center,style: TextStyle(fontSize: 15.sp,),):SizedBox(),
    title: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),),
    actions: [
      Container(
        height: 30.h,
        width: ScreenUtil().screenWidth-20,
        child: GridView(  shrinkWrap: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
            ),
            children: [   GestureDetector(
                onTap:  onPressedCancel,
                child: Container(
                  child: Text('Cancel', textAlign: TextAlign.center, style: TextStyle(fontSize: 17.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600
                  ),),
                ),
              ),
              GestureDetector(
                  onTap: onPressedOk,
                  child: Container(
                    child: Text(confirmText, textAlign: TextAlign.center,style: TextStyle(fontSize: 17.sp,
                        color: Colors.red,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
              ),],),
      ),
    ],
  );
  }

}