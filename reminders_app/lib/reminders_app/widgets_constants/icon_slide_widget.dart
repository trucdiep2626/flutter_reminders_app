import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class IconSlideWidget {
  static Widget edit (){
    return    IconSlideAction(
        caption: 'Edit',
        iconWidget: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        color: Colors.blue,
        onTap: () => {},

    );
  }
  static Widget delete(Function onTap)
  {
    return  IconSlideAction(
      caption: 'Delete',
      iconWidget: Icon(
        Icons.delete,
        color: Colors.white,
      ),
      color: Colors.red,
      onTap:onTap,
    );
  }
}