import 'dart:developer';

import '../../../../../common/extensions/date_extensions.dart';
import 'package:reminders_app/common/config/local_config.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';

class ReminderDataSource {
  final LocalConfig config;

  ReminderDataSource({this.config});

  Future<int> setReminder(Reminder reminder) async {
    log('adddddd reminder');
    int id =await config.reminderBox.add(reminder);
    return id;
  }

  Future<List<Reminder>> getAllReminder() async {
    log('get all reminder');
    return await config.reminderBox.values.toList() as List<Reminder>;
  }

  Future<List<Reminder>> getReminderOfList(String list) async {
    return await config.reminderBox.values.where((reminder) => reminder.list == list).toList();
  }

  Future<List<Reminder>> getReminderOfDay(String date) async {
    return   await config.reminderBox.values.where((reminder) =>
    DateTime.fromMillisecondsSinceEpoch(reminder.dateAndTime)
        .dateDdMMyyyy ==
        date).toList();
  }

  Future<void> deleteReminder(int index) async {
    log((await getAllReminder()).length.toString());
    log(index.toString());
     await config.reminderBox.deleteAt(index-1);
    log('deleteeeeeeeeee reminder');
  }
}
