import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
class AllRemindersState extends Equatable {
  final List<Group> myLists;
  final Map<String, List<Reminder>> remindersOfList;
  final bool isUpdated;
  AllRemindersState(
      {@required this.myLists, @required this.remindersOfList, this.isUpdated});

  AllRemindersState update(
      {List<Group> myLists,
        Map<String, List<Reminder>> remindersOfList,
        bool isUpdated}) =>
      AllRemindersState(
          isUpdated: isUpdated ?? this.isUpdated,
          remindersOfList: remindersOfList,
          myLists: myLists
      );

  @override
  List<Object> get props =>
      [this.isUpdated, this.myLists, this.remindersOfList];
}
// class AllRemindersState extends Equatable {
//   final List<Group> myLists;
//   final List<Group> emptyLists;
//   final List<Reminder> remindersOfList;
//   final bool isUpdated;
//   AllRemindersState(
//       {@required this.myLists,
//       @required this.remindersOfList,
//       this.isUpdated,
//       this.emptyLists});
//
//   AllRemindersState update(
//           {List<Group> myLists,
//           List<Reminder> remindersOfList,
//           bool isUpdated,
//           List<Group> emptyLists}) =>
//       AllRemindersState(
//           emptyLists: emptyLists,
//           isUpdated: isUpdated ?? this.isUpdated,
//           remindersOfList: remindersOfList,
//           myLists: myLists);
//
//   @override
//   List<Object> get props =>
//       [this.isUpdated, this.myLists, this.remindersOfList, this.emptyLists];
// }
