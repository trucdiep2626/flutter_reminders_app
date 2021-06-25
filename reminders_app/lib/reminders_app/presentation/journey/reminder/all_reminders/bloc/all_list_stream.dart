import 'dart:async';
import 'dart:developer';

import 'package:reminders_app/reminders_app/domain/entities/group.dart';

import '../../../reminders_list.dart';

class AllListStream{
  List<Group> MyLists=[];
StreamController myListsController= StreamController<List<Group>>();
Stream get myListsStream=>myListsController.stream;
  void update()
  {
    MyLists=RemindersList.MyLists;
myListsController.sink.add(MyLists);
log(MyLists.length.toString()+"update");
  }
  void dispose()
  {
    myListsController.close();
  }
}