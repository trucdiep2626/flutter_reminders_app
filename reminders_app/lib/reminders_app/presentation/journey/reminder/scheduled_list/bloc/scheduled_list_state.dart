import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';

class ScheduledRemindersState extends Equatable {
 final List<String> dateList ;
 final Map<String, List<Reminder>> scheduledList  ;
 final bool isUpdated;

 ScheduledRemindersState({@required this.dateList,@required this.scheduledList,this.isUpdated});
 ScheduledRemindersState update({bool isUpdated,
    List<String> dateList,
    Map<String, List<Reminder>> scheduledList,
  }) =>
     ScheduledRemindersState(
       isUpdated: isUpdated?? this.isUpdated,
          dateList: dateList  ,
          scheduledList: scheduledList  );

  @override
  List<Object> get props => [this.isUpdated, this.dateList, this.scheduledList];
}
