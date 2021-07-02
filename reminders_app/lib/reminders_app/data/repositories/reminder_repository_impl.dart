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

  Future<List<String>> getAllDate()async{
    return await reminderDs.getAllDate();
  }

  @override
  Future<int> setReminder(Reminder reminder) async {
    log('adddd');
    return await reminderDs.setReminder(reminder);
  }

  @override
  Future<Reminder> getReminder(int id)async {
    return await reminderDs.getReminder(id);
  }

  @override
  Future<void> deleteRemindersOfList(String list)async {
    return await reminderDs.deleteRemindersOfList(list);
  }

  Future<int> getLengthOfBox() async{
    return await reminderDs.getLengthOfBox();
  }

  Future<int> updateReminder(Reminder reminder, int id) async
  {
    return await reminderDs.updateReminder(reminder, id);
  }

  Future<bool> updateBox(List<Reminder> reminders) async {
    return await reminderDs.updateBox(reminders);
  }

  Future<void> updateListOfReminders(String oldList, String newList)async
  {
     return await reminderDs.updateListOfReminders(oldList, newList);
  }
}