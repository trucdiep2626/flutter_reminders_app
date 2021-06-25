import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemindersConstants{
  static String scheduledTxt='Scheduled';
  static String todayTxt='Today';
  static String allTxt='All';
  static Widget noReminders= Text(
  'No Reminders',
  style: TextStyle(
  color: Colors.grey,
  fontSize:
  ScreenUtil().setSp(20)),
  );
  static Color getPriorityColor (int value){
    log(value.toString());
if(value==3)
  return Colors.red;
else if(value==2)
  return Colors.orange;
else if(value==1)
  return Colors.yellow;
else return Colors.grey;


  }
}