import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/domain/usecases/group_usecase.dart';
import 'package:reminders_app/reminders_app/domain/usecases/reminder_usecase.dart';
import 'all_list_event.dart';

import '../../../reminders_list.dart';

import 'all_list_state.dart';

class AllRemindersBloc extends Bloc<AllRemindersEvent, AllRemindersState> {
  final ReminderUseCase reminderUc;
  final GroupUsecase groupUc;

  AllRemindersBloc({this.reminderUc, this.groupUc});

  @override
  AllRemindersState get initialState => AllRemindersState( myLists:[],remindersOfList: {});

  @override
  Stream<AllRemindersState> mapEventToState(AllRemindersEvent event) async* {
    if (event is UpdateAllListEvent) {
      yield* _mapUpdateEventToState(event);
    }
   
  }

  Stream<AllRemindersState> _mapUpdateEventToState(
      UpdateAllListEvent event) async* {

     List<Group> lists = await groupUc.getAllGroup();
    Map<String,List<Reminder>> remindersOfList=Map();
    for(int i=0;i<lists.length;i++)
      {
        List<Reminder> reminders = await reminderUc.getReminderOfList(lists[i].name);
        remindersOfList.addAll({lists[i].name:reminders});
      }
    yield state.update(myLists: null,remindersOfList: null);
     yield state.update(myLists: lists,remindersOfList: remindersOfList);
     log("all list update");
  }

 
}
