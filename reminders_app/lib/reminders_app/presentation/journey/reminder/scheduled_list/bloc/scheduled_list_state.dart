import 'package:equatable/equatable.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';

class ScheduledRemindersState extends Equatable {
 final List<String> dateList ;
 final Map<String, List<Reminder>> scheduledList  ;

 ScheduledRemindersState({this.dateList, this.scheduledList});
 ScheduledRemindersState update({
    List<String> dateList,
    Map<String, List<Reminder>> scheduledList,
  }) =>
     ScheduledRemindersState(
          dateList: dateList  ,
          scheduledList: scheduledList  );

  @override
  List<Object> get props => [this.dateList, this.scheduledList];
}
