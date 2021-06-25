import 'dart:async';



import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';

import '../../../reminders_list.dart';

class ListStream{
  List<Reminder> list=[];
  StreamController listController= StreamController<List<Reminder>>();
  Stream get listStream=>listController.stream;

  void update(int index)
  {
    list=RemindersList.MyLists[index].list;
 listController.sink.add(list);
  }
  void dispose()
  {
    listController.close();
  }
}