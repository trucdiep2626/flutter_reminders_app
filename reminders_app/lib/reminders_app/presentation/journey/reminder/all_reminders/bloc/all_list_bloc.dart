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
  AllRemindersState get initialState => AllRemindersState( myLists:[],remindersOfList: {},isUpdated: false);

  @override
  Stream<AllRemindersState> mapEventToState(AllRemindersEvent event) async* {
    if (event is UpdateAllListEvent) {
      yield* _mapUpdateEventToState(event);
    }
    if(event is DeleteReminderInAllScreenEvent)
      {
        yield* _mapDeleteReminderEventToState(event);
      }
   
  }
  Stream<AllRemindersState> _mapDeleteReminderEventToState(DeleteReminderInAllScreenEvent event) async* {
    await reminderUc.deleteReminder(event.id);
    log('deleted');
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
   /* remindersOfList.forEach((key, value) {
      for (int i = 0; i < value?.length - 1; i++)
        for (int j = i; j < value?.length; j++) {
          if (value[i]?.priority <= value[j]?.priority) {
            Reminder a = value[i];
            value[i] = value[j];
            value[j] = a;
          }
        }
      //sắp xếp theo ngày trong cùng 1 thứ tự ưu tiên
      for (int k = 0; k < value?.length; k++) {
        for (int h = k + 1; h < value?.length; h++) {
          if ((value[k]?.priority == value[h]?.priority) &&
              (value[k]?.dateAndTime >= value[h]?.dateAndTime)) {
            Reminder a = value[k];
            value[k] = value[h];
            value[h] = a;
          }
        }
      }
    });*/
    yield state.update(myLists: null,remindersOfList: null);
     yield state.update(myLists: lists,remindersOfList: remindersOfList,isUpdated: event.isUpdated);
     log("all list update");
  }

 
}
