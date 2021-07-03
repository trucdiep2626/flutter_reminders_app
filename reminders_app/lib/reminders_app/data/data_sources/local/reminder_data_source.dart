import 'dart:developer';

import 'package:intl/intl.dart';

import '../../../../../common/extensions/date_extensions.dart';
import 'package:reminders_app/common/config/local_config.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';

class ReminderDataSource {
  final LocalConfig config;

  ReminderDataSource({this.config});

  Future<int> setReminder(Reminder reminder) async {
    log('adddddd reminder');
    int id = await config.reminderBox.add(reminder);
    return id;
  }

  Future<int> updateReminder(Reminder reminder, int id) async {
    List<Reminder> allReminders = await getAllReminder();
    log(id.toString() + "LLLLLLLLLLLLLLLLLLLLLLLLLLLL");
    for (int i = 0; i < allReminders.length; i++) {
      if (allReminders[i].id == id) {
        await config.reminderBox.putAt(i, reminder);
        break;
      }
    }
    return 1;
  }

  Future<void> updateListOfReminders(String oldList, String newList) async {
    List<Reminder> allReminders = await getAllReminder();
    for (int i = 0; i < allReminders.length; i++) {
      if (allReminders[i].list == oldList) {
        await config.reminderBox.putAt(
            i,
            Reminder(
                id: allReminders[i].id,
                title: allReminders[i].title,
                notes: allReminders[i].notes,
                dateAndTime: allReminders[i].dateAndTime,
                priority: allReminders[i].priority,
                createAt: allReminders[i].createAt,
                lastUpdate: DateTime.now().millisecondsSinceEpoch,
                list: newList));
      }
    }
  }

  Future<Reminder> getReminder(int index) async {
    return await config.reminderBox.getAt(index);
  }

  Future<int> getLengthOfBox() async {
    return await config.reminderBox.length;
  }

  Future<bool> updateBox(List<Reminder> reminders) async {
    log("length   " + reminders.length.toString());
    for (int i = 0; i < reminders.length; i++) {
      await config.reminderBox.putAt(i, reminders[i]);
    }
    log(">>>>>>>>>update box");
    return true;
  }

  Future<List<Reminder>> getAllReminder() async {
    //log('get all reminder');
    return await config.reminderBox.values.toList() as List<Reminder>;
  }

  Future<List<Reminder>> getReminderOfList(String list) async {
    return await config.reminderBox.values
        .where((reminder) => reminder.list == list)
        .toList();
  }

  Future<List<Reminder>> getReminderOfDay(String date) async {
    return await config.reminderBox.values
        .where((reminder) =>
            DateTime.fromMillisecondsSinceEpoch(reminder.dateAndTime)
                .dateDdMMyyyy ==
            date)
        .toList();
  }

  Future<List<int>> getAllDate() async {
    List<Reminder> allReminders = await getAllReminder();
    List<int> dateList = [];
    for (int i = 0; i < allReminders.length; i++) {
      if (allReminders[i].dateAndTime != 0) {
        if (dateList.isEmpty ||
            dateList.contains(DateTime.parse(DateFormat('yyyy-MM-dd').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            allReminders[i].dateAndTime)))
                    .millisecondsSinceEpoch) ==
                false) {
          dateList.add(DateTime.parse(DateFormat('yyyy-MM-dd').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      allReminders[i].dateAndTime)))
              .millisecondsSinceEpoch);
        }
      }
    }

    dateList.sort();
    return dateList;
  }

  Future<void> deleteReminder(int id) async {
    List<Reminder> allReminders = await getAllReminder();
    log(id.toString());
    for (int i = 0; i < allReminders.length; i++) {
      if (allReminders[i].id == id) {
        await config.reminderBox.deleteAt(i);
        break;
      }
    }
    log('deleteeeeeeeeee reminder');
  }

  Future<void> deleteRemindersOfList(String list) async {
    List<Reminder> allReminders = await getAllReminder();
    for (int i = 0; i < allReminders.length; i++) {
      if (allReminders[i].list == list) {
        await config.reminderBox.deleteAt(i);
        allReminders.removeAt(i);
        i--;
      }
    }
    log("deleteRemindersOfList");
  }
}
//8
