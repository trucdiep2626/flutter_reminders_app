/*
import 'dart:async';
import 'dart:developer';

import 'package:reminders_app/reminders_app/presentation/model/group.dart';
import 'package:reminders_app/reminders_app/common/extensions/date_extensions.dart';
import '../../reminders_list.dart';
import 'home_state.dart';

class HomeStream {
  int l1 = 0, l2 = 0, l3 = 0;
  List<Group> MyLists = [];
  HomeState homeState=HomeState(l1:0, l2:0,l3:0) ;
 StreamController homeController= StreamController<HomeState>.broadcast();
 Stream get homeStream=>homeController.stream;

  void update() {
    log('update');
    l1 = 0;
    l2 = 0;
    l3 = 0;
    if (RemindersList.allReminders?.length == null) {
      l1 = 0;
      l2 = 0;
      l3 = 0;
    } else {
      RemindersList.allReminders?.forEach((key, value) {
        String now =  DateTime.now().dateDdMMyyyy;
        log(key.toString());
        if (key == now) {
          l1 = RemindersList.allReminders[now].length;
        }
        if (key != ('Others')) {
          l2 += RemindersList.allReminders[key].length;
        }
        l3 += RemindersList.allReminders[key].length;
      });
    }
    RemindersList.addDefaultList();
    MyLists = RemindersList.MyLists;
    log(MyLists.length.toString()+"  "+l1.toString());
   homeController.sink.add(homeState.update(l1: l1,l2: l2,l3: l3,MyLists: MyLists));

  }

  void dispose(){
   homeController.close();
  }
}
*/
