import 'package:equatable/equatable.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';


class TodayListState extends Equatable {
  final List<Reminder> todayList ;
  final bool isUpdated;
  TodayListState({this.todayList,this.isUpdated});

  TodayListState update({  List<Reminder> todayList, bool isUpdated }) =>
      TodayListState(
        isUpdated: isUpdated?? this.isUpdated,
          todayList:  todayList //?? this.todayList
      );

  @override
  List<Object> get props => [
    this.todayList, this.isUpdated
  ];
}