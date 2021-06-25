import 'dart:async';
import 'dart:developer';

import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';

import '../../../reminders_list.dart';
import '../../../../../../common/extensions/date_extensions.dart';
class TodayStream{
  String now =  DateTime.now().dateDdMMyyyy;
  List<Reminder> todayList=[];
  StreamController todayListController= StreamController();
  Stream get todayListStream=>todayListController.stream;

  void dispose()
  {
  todayListController.close();
  }
  void update()
  {
    log(now+"update");
    if(RemindersList.allReminders[now]!=0)
    {  todayList=RemindersList.allReminders[now];
   todayListController.sink.add(todayList);
  }}
}