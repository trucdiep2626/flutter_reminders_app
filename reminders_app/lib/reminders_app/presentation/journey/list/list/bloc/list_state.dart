import 'package:equatable/equatable.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';

class ListState extends Equatable {
  Group list;
  List<Reminder> reminderList = [];
  ViewState viewState;

  ListState({this.list, this.reminderList, this.viewState});
  ListState update(
          {List<Reminder> reminderList, Group list, ViewState viewState}) =>
      ListState(
          list: list ?? this.list,
          reminderList: reminderList,
          viewState: viewState ?? this.viewState);
  @override
  List<Object> get props => [this.list, this.reminderList, this.viewState];
}
