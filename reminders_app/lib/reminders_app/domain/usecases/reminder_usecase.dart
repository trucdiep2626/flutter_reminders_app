import 'dart:developer';

import 'package:reminders_app/reminders_app/data/data_sources/local/reminder_data_source.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/domain/repositories/reminder_repository.dart';

class ReminderUseCase{
  final ReminderRepository reminderRepository;


  ReminderUseCase({this.reminderRepository});

  @override
  Future<void> deleteReminder(int index) async {
    log('delete reminder');
    return await reminderRepository.deleteReminder(index);
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

}