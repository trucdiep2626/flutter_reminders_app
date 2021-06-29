import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';

abstract class ReminderRepository{
  Future<int> setReminder(Reminder reminder) async{}
  Future<List<Reminder>> getAllReminder() async{}
  Future<List<Reminder>> getReminderOfList(String list) async {  }
  Future<List<Reminder>> getReminderOfDay(String date) async { }
  Future<void> deleteReminder(int id) async{}
  Future<void> deleteRemindersOfList(String list) async{}
  Future<List<String>> getAllDate()async{}
  Future<Reminder> getReminder(int index) async{  }
  Future<int> getLengthOfBox() async{  }
}