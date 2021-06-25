import 'dart:developer';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import '../../../../common/extensions/date_extensions.dart';
import '../reminders_list.dart';

class HomePageProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int l1 = 0, l2 = 0, l3 = 0;
  Color listColor = Colors.blue;
  List<Group> MyLists = [];
  void setColor(Color value) {
    listColor = value;
    notifyListeners();
  }
  void update() {
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

    notifyListeners();
  }
}
