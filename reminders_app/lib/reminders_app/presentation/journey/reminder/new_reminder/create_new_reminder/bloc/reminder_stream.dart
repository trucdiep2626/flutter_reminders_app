/*
import 'dart:async';
import 'dart:developer';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/new_reminder/create_new_reminder/bloc/reminder_state.dart';

class ReminderStream {
  String title;
  String notes;
  String list = 'Reminders';
  Map<String, int> details;
  ReminderState reminderState = ReminderState(list: 'Reminder');
  StreamController reminderController =
      StreamController<ReminderState>.broadcast();

  Stream get reminderStream => reminderController.stream;

  void setDetails(var value) {
    details = value;
    reminderController.sink.add(reminderState.update(
        title: title, notes: notes, list: list, details: details));
  }

  void setList(String value) {
    list = value;
    reminderController.sink.add(reminderState.update(
        title: title, notes: notes, list: list, details: details));
  }

  void test() {
    //log(allReminder.length.toString()+'@@@@@@@@@@@@');
  }

  void setTitle(String value) {
    title = value;
    reminderController.sink.add(reminderState.update(
        title: title, notes: notes, list: list, details: details));
  }

  void setNote(String value) {
    notes = value;
    reminderController.sink.add(reminderState.update(
        title: title, notes: notes, list: list, details: details));
  }

  void dispose() {
    reminderController.close();
  }
}
*/
