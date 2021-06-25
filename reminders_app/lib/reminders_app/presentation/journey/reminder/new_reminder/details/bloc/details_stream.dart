import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'details_state.dart';

class DetailsStream {
  int date = 0;
  int time = 0;
  int priority = 0;
  bool hasDate = false;
  bool hasTime = false;
  DetailsState detailsState = DetailsState(
      date: 0, time: 0, priority: 0, hasDate: false, hasTime: false);
  StreamController detailsController =
      StreamController<DetailsState>.broadcast();

  Stream get detailsStream => detailsController.stream;
void setDefault(int date, int time, int priority)
{
  if(date!=0)
    {
      this.hasDate=true;
      this.date=date;
      if(time!=0)
        {
          this.hasTime=true;
          this.time=time;
        }
      else
        {
          this.hasTime=false;
          this.time=0;
        }
    }
  else
    {
      this.hasDate=false;
      this.date=0;
      this.hasTime=false;
      this.time=0;
    }
  this.priority=priority;
  detailsController.sink.add(detailsState.update(
      date: date,
      time: time,
      priority: priority,
      hasDate: hasDate,
      hasTime: hasTime));

}
  void setPriority(int value) {
    priority = value;
    log(priority.toString());
    detailsController.sink.add(detailsState.update(
        date: date,
        time: time,
        priority: priority,
        hasDate: hasDate,
        hasTime: hasTime));
  }

  void setTime(TimeOfDay timeOfDay, bool has_time) {
    hasTime = has_time;
    if (hasTime == true) {
      log(timeOfDay.toString());
      time = (timeOfDay.hour * 60 * 60 + timeOfDay.minute * 60) * 1000 + 1;
      log(DateFormat('HH:mm dd/MM/yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(date + time)));
      log(time.toString());
    } else {
      time = 0;
    }
    detailsController.sink.add(detailsState.update(
        date: date,
        time: time,
        priority: priority,
        hasDate: hasDate,
        hasTime: hasTime));
  }

  void setDate(DateTime value, bool has_date) {
    hasDate = has_date;
    if (hasDate == true) {
      date = DateTime.parse(DateFormat('yyyy-MM-dd').format(value))
          .millisecondsSinceEpoch;
    } else {
      date = 0;
    }
    log(hasDate.toString());
    log(date.toString());
    detailsController.sink.add(detailsState.update(
        date: date,
        time: time,
        priority: priority,
        hasDate: hasDate,
        hasTime: hasTime));
  }

  void dispose() {
    detailsController.close();
  }
}
