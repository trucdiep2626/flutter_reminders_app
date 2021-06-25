import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';


import '../../reminders_list.dart';

class ScheduledProvider with ChangeNotifier,DiagnosticableTreeMixin{
  List<String> dateList =[];
  Map<String,List<Reminder>> scheduledList= Map();

  void setDefault()
  {
    int i=0;
    RemindersList.allReminders.forEach((key, value) {
      if(key!='Others') {
        dateList.add(key);
        scheduledList.addAll({key:value});
        i++;
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
    notifyListeners();
  }
}