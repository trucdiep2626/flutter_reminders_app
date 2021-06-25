import 'package:equatable/equatable.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';


class TodayListState extends Equatable {
  final List<Reminder> todayList ;
  TodayListState({this.todayList});

  TodayListState update({  List<Reminder> todayList }) =>
      TodayListState(
          todayList:  todayList //?? this.todayList
      );

  @override
  List<Object> get props => [
    this.todayList
  ];
}