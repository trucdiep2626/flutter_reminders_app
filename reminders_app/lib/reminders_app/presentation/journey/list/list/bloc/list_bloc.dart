import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/domain/usecases/group_usecase.dart';
import 'package:reminders_app/reminders_app/domain/usecases/reminder_usecase.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/list/bloc/list_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/list/bloc/list_state.dart';
import '../../../reminders_list.dart';


class ListBloc extends Bloc<ListEvent, ListState> {
  final ReminderUseCase reminderUc;
  final GroupUsecase groupUc;

  ListBloc({this.reminderUc,this.groupUc});

  @override
  ListState get initialState => ListState( reminderList: [],list: Group(),isUpdated: false);

  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {
    if (event is UpdateListEvent) {
      yield* _mapUpdateEventToState(event);
    }
    if(event is DeleteReminderInListScreenEvent)
      yield* _mapDeleteReminderEventToState(event);
  }

  Stream<ListState> _mapDeleteReminderEventToState(DeleteReminderInListScreenEvent event) async* {

   await reminderUc.deleteReminder(event.id);
  log('deleted');
  }
  
  Stream<ListState> _mapUpdateEventToState(
      UpdateListEvent event) async* {
    Group list = await groupUc.getGroup(event.index) ;
    log("list update");
    final List<Reminder> reminderList = await reminderUc.getReminderOfList(list.name);
     
      for (int i = 0; i < reminderList.length - 1; i++)
        for (int j = i; j < reminderList.length; j++) {
          if (reminderList[i]?.priority <= reminderList[j]?.priority) {
            Reminder a = reminderList[i];
            reminderList[i] = reminderList[j];
            reminderList[j] = a;
          }
        }
      //sắp xếp theo ngày trong cùng 1 thứ tự ưu tiên
      for (int k = 0; k < reminderList.length; k++) {
        for (int h = k + 1; h < reminderList.length; h++) {
          if ((reminderList[k]?.priority == reminderList[h]?.priority) &&
              (reminderList[k]?.dateAndTime >= reminderList[h]?.dateAndTime)) {
            Reminder a = reminderList[k];
            reminderList[k] = reminderList[h];
            reminderList[h] = a;
          }
        }
      }
 
    yield state.update(reminderList: null,list: list);
    yield state.update(reminderList: reminderList,list: list,isUpdated: event.isUpdated);
    //log(state.myLists.length.toString());
  }


}
