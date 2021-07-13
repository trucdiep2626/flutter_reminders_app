import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/domain/usecases/group_usecase.dart';
import 'package:reminders_app/reminders_app/domain/usecases/reminder_usecase.dart';
import 'all_list_event.dart';
import 'all_list_state.dart';
class AllRemindersBloc extends Bloc<AllRemindersEvent, AllRemindersState> {
  final ReminderUseCase reminderUc;
  final GroupUsecase groupUc;

  AllRemindersBloc({@required this.reminderUc, @required this.groupUc});

  @override
  AllRemindersState get initialState =>
      AllRemindersState(myLists: [], remindersOfList: {}, isUpdated: false);

  @override
  Stream<AllRemindersState> mapEventToState(AllRemindersEvent event) async* {
    if (event is UpdateAllListEvent) {
      yield* _mapUpdateEventToState(event);
    }
    if (event is DeleteReminderInAllScreenEvent) {
      yield* _mapDeleteReminderEventToState(event);
    }
  }

  Stream<AllRemindersState> _mapDeleteReminderEventToState(
      DeleteReminderInAllScreenEvent event) async* {
    await reminderUc.deleteReminder(event.id);
    log('deleted');
  }

  Stream<AllRemindersState> _mapUpdateEventToState(
      UpdateAllListEvent event) async* {
    List<Group> lists = await groupUc.getAllGroup();
    Map<String, List<Reminder>> remindersOfList = Map();
    for (int i = 0; i < lists.length; i++) {
      List<Reminder> reminders =
      await reminderUc.getReminderOfList(lists[i].name);
      remindersOfList.addAll({lists[i].name: reminders});
    }
    yield state.update(myLists: null, remindersOfList: null);
    yield state.update(
        myLists: lists,
        remindersOfList: remindersOfList,
        isUpdated: event.isUpdated);
    log("all list update");
  }
}
// class AllRemindersBloc extends Bloc<AllRemindersEvent, AllRemindersState> {
//   final ReminderUseCase reminderUc;
//   final GroupUsecase groupUc;
//
//   AllRemindersBloc({@required this.reminderUc, @required this.groupUc});
//
//   @override
//   AllRemindersState get initialState =>
//       AllRemindersState(myLists: [], remindersOfList: [], isUpdated: false,emptyLists: []);
//
//   @override
//   Stream<AllRemindersState> mapEventToState(AllRemindersEvent event) async* {
//     if (event is UpdateAllListEvent) {
//       yield* _mapUpdateEventToState(event);
//     }
//     if (event is DeleteReminderInAllScreenEvent) {
//       yield* _mapDeleteReminderEventToState(event);
//     }
//   }
//
//   Stream<AllRemindersState> _mapDeleteReminderEventToState(
//       DeleteReminderInAllScreenEvent event) async* {
//     await reminderUc.deleteReminder(event.id);
//     log('deleted');
//   }
//
//   Stream<AllRemindersState> _mapUpdateEventToState(
//       UpdateAllListEvent event) async* {
//     List<Group> lists = await groupUc.getAllGroup();
//     List<Group> emptyLists = [];
//     List<Reminder> remindersOfList = [];
//     for (int i = 0; i < lists.length; i++) {
//       //log(lists[i].name);
//       List<Reminder> reminders =
//           await reminderUc.getReminderOfList(lists[i].name);
//      // log(lists[i].name+" "+reminders.length.toString());
//       remindersOfList.addAll(reminders);
//       if (reminders.isEmpty) {
//         emptyLists.add(lists[i]);
//       }
//     }
//     log(emptyLists.length.toString());
//     log(lists.length.toString());
//     log(remindersOfList.length.toString());
//     yield state.update(myLists: null, remindersOfList: null, emptyLists: null);
//     yield state.update(
//         emptyLists: emptyLists,
//         myLists: lists,
//         remindersOfList: remindersOfList,
//         isUpdated: event.isUpdated);
//     log("all list update");
//   }
// }
