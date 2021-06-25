import 'package:equatable/equatable.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';


class AllRemindersState extends Equatable {
 final List<Group> myLists ;
 final Map<String,List<Reminder>> remindersOfList;
  AllRemindersState({this.myLists,this.remindersOfList});

  AllRemindersState update({  List<Group> myLists,Map<String,List<Reminder>> remindersOfList }) =>
      AllRemindersState(
        remindersOfList: remindersOfList,
          myLists:  myLists //?? this.myLists
      );

  @override
  List<Object> get props => [
    this.myLists,this.remindersOfList
  ];
}