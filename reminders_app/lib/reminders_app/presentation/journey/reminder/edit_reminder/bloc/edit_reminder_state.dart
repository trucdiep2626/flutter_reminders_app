import 'package:equatable/equatable.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';

class EditReminderState extends Equatable {
  final String title;
  final String notes;
  final String list  ;
  final int date;
  final int time;
  final int priority;
  final bool hasDate;
  final bool hasTime;
  final ViewState viewState;
  final List<Group> myLists;

  EditReminderState({this.title, this.notes, this.list, this.date, this.time,
    this.priority, this.hasDate, this.hasTime, this.viewState, this.myLists});
  EditReminderState update({  String title,
    String notes,
    String list  ,
    int date,
    int time,
    int priority,
    bool hasDate,
    bool hasTime,
    ViewState viewState,
    List<Group> myLists,}) =>
      EditReminderState(
          myLists: myLists?? this.myLists,
          title: title?? this.title,
          notes: notes?? this.notes,
          list: list?? this.list,
          date:date ?? this.date,
          time:time?? this.time,
          priority: priority?? this.priority,
          hasDate: hasDate?? this.hasDate,
          hasTime: hasTime??this.hasTime,
          viewState: viewState?? this.viewState
      );

  @override
  List<Object> get props => [
    this.title,
    this.notes,
    this.list,
    this.viewState,
    this.date,
    this.hasDate,
    this.time,
    this.hasTime,
    this.priority,
    this.myLists
  ];

}