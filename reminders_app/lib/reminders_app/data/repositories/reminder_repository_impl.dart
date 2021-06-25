import 'dart:developer';

import 'package:reminders_app/reminders_app/data/data_sources/local/reminder_data_source.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/domain/repositories/reminder_repository.dart';

class ReminderRepositoryImpl implements ReminderRepository{
  final ReminderDataSource reminderDs;

  ReminderRepositoryImpl({this.reminderDs});

  @override
  Future<void> deleteReminder(int index) async{
    log('deleteeeeee reminder');
   return await reminderDs.deleteReminder(index);
  }

  @override
  Future<List<Reminder>> getAllReminder()async {
    return await reminderDs.getAllReminder();
  }

  @override
  Future<List<Reminder>> getReminderOfDay(String date) async{
    return await reminderDs.getReminderOfDay(date);
  }

  @override
  Future<List<Reminder>> getReminderOfList(String list) async{
    return await reminderDs.getReminderOfList(list);
  }

  @override
  Future<int> setReminder(Reminder reminder) async {
    log('adddd');
    return await reminderDs.setReminder(reminder);
  }

}