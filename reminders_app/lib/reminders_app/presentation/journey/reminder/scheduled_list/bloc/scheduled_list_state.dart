import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';

class ScheduledRemindersState extends Equatable {
  final List<Reminder> scheduledList;
  final bool isUpdated;

  ScheduledRemindersState({@required this.scheduledList, this.isUpdated});
  ScheduledRemindersState update({
    bool isUpdated,
    List<Reminder> scheduledList,
  }) =>
      ScheduledRemindersState(
          isUpdated: isUpdated ?? this.isUpdated, scheduledList: scheduledList);

  @override
  List<Object> get props => [this.isUpdated, this.scheduledList];
}
