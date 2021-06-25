import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsProvider with ChangeNotifier,DiagnosticableTreeMixin{
  int date=0;
  int time=0;
  int priority=0;
  bool hasDate=false;
  bool hasTime=false;

  void setPriority(int value)
  {
    priority=value;
    notifyListeners();
  }
  void setTime(TimeOfDay timeOfDay, bool has_time)
  {

    hasTime=has_time;
    if(hasTime==true)
      {
        log(timeOfDay.toString());
        time=(timeOfDay.hour*60*60+timeOfDay.minute*60)*1000+1;
        log(DateFormat('HH:mm dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(date+time)));
    //{time=(timeOfDay.hour.toString()+':'+timeOfDay.minute.toString()) ;
    log(time.toString());}

    else
      {
        time=0;
      }
    notifyListeners();
  }
  void setDate(DateTime value, bool has_date)
  {
    hasDate=has_date;
    if(hasDate==true) {
   //   log(value.toIso8601String());
        date = DateTime.parse(DateFormat('yyyy-MM-dd').format(value))
            .millisecondsSinceEpoch;
    }
    else
    {
      date=0;
    }
    log(hasDate.toString());
    log(date.toString());
    notifyListeners();
  }
}