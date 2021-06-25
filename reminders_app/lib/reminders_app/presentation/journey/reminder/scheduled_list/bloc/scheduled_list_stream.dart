/*
import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/scheduled_list/bloc/scheduled_list_state.dart';


import '../../../reminders_list.dart';

class ScheduledListStream{
  List<String> dateList =[];
  Map<String,List<Reminder>> scheduledList= Map();
ScheduledListState scheduledListState= ScheduledListState();
StreamController scheduledController = StreamController<ScheduledListState>.broadcast();
Stream get scheduledStream=>scheduledController.stream;

  void setDefault()
  {
    log('default');
    int i=0;
    RemindersList.allReminders.forEach((key, value) {
      if(key!='Others') {
        dateList.add(key);
        scheduledList.addAll({key:value});
        i++;
        log('default');
      }
    });
    for(int i=0;i<dateList.length-1;i++)
    {
      for(int j=i+1;j<dateList.length;j++)
      {
        if((dateList[i]).compareTo(dateList[j])>0)   {
          String tmp= dateList[i];
          dateList[i]=dateList[j];
          dateList[j]=tmp;
        }
      }
    }
    scheduledController.sink.add(ScheduledListState(dateList: dateList,scheduledList: scheduledList));
  }
  void update()
  {
    dateList.clear();
    scheduledList.clear();
    RemindersList.allReminders.forEach((key, value) {
      if(key!='Others') {
        if(value.length!=0) {
          dateList.add(key);
          scheduledList.addAll({key: value});
        }
      }
    });
    for(int i=0;i<dateList.length-1;i++)
    {
      for(int j=i+1;j<dateList.length;j++)
      {
        if((dateList[i]).compareTo(dateList[j])>0)
        {
          String tmp= dateList[i];
          dateList[i]=dateList[j];
          dateList[j]=tmp;
        }
      }
    }
    scheduledController.sink.add(ScheduledListState(dateList: dateList,scheduledList: scheduledList));
    log(dateList.length.toString()+" update "+scheduledList.length.toString());
  }
  void dispose()
  {
    scheduledController.close();
  }
}*/
