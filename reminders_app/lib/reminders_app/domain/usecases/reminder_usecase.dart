import 'dart:developer';

import 'package:reminders_app/reminders_app/data/data_sources/local/reminder_data_source.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/domain/repositories/reminder_repository.dart';

class ReminderUseCase{
  final ReminderRepository reminderRepository;


  ReminderUseCase({this.reminderRepository});

  @override
  Future<void> deleteReminder(int id) async {
    log('delete reminder');
    return await reminderRepository.deleteReminder(id);
  }

  Future<void> deleteRemindersOfList(String list) async{
    return await reminderRepository.deleteRemindersOfList(list);
  }
  Future<List<String>> getAllDate()async{
    return await reminderRepository.getAllDate();
  }

  @override
  Future<List<Reminder>> getAllReminder() async {
    return await reminderRepository.getAllReminder();
  }

  @override
  Future<List<Reminder>> getReminderOfDay(String date) async {
    return await reminderRepository.getReminderOfDay(date);
  }

  @override
  Future<List<Reminder>> getReminderOfList(String list) async {
    return await reminderRepository.getReminderOfList(list);
  }

  @override
  Future<int> setReminder(Reminder reminder) async{
    log('add');
    return await reminderRepository.setReminder(reminder);
  }

  Future<Reminder> getReminder(int index)async {
    return await reminderRepository.getReminder(index);
  }

  Future<int> getLengthOfBox() async{
    return await reminderRepository.getLengthOfBox();
  }

  Future<int> updateReminder(Reminder reminder, int id) async
  {
    log('?????????????');
    return await reminderRepository.updateReminder(reminder, id);
  }

  Future<bool> updateBox(List<Reminder> reminders) async {
    return await reminderRepository.updateBox(reminders);
  }

  Future<void> updateListOfReminders(String oldList, String newList)async
  {
    return await reminderRepository.updateListOfReminders(oldList, newList);
  }
}