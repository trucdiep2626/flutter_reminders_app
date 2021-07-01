import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/domain/usecases/reminder_usecase.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/scheduled_list/bloc/scheduled_list_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/scheduled_list/bloc/scheduled_list_state.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminders_list.dart';

class ScheduledRemindersBloc
    extends Bloc<ScheduledRemindersEvent, ScheduledRemindersState> {
  final ReminderUseCase reminderUc;

  ScheduledRemindersBloc({@required this.reminderUc});

  @override
  ScheduledRemindersState get initialState =>
      ScheduledRemindersState(dateList: [], scheduledList: {},isUpdated:false);

  @override
  Stream<ScheduledRemindersState> mapEventToState(
      ScheduledRemindersEvent event) async* {
    if (event is UpdateScheduledEvent) {
      yield* _mapUpdateEventToState(event);
    }
    if(event is DeleteReminderInScheduledScreenEvent)
    {
      yield* _mapDeleteReminderEventToState(event);
    }

  }
  Stream<ScheduledRemindersState> _mapDeleteReminderEventToState(DeleteReminderInScheduledScreenEvent event) async* {
    await reminderUc.deleteReminder(event.id);
    log('deleted');
  }

  Stream<ScheduledRemindersState> _mapUpdateEventToState(
      UpdateScheduledEvent event) async* {
    List<String> dateList = await reminderUc.getAllDate();
    Map<String, List<Reminder>> scheduledList = {};
    //sắp xếp datelist
    /*for (int i = 0; i < dateList.length - 1; i++) {
      for (int j = i + 1; j < dateList.length; j++) {
        if ((dateList[i]).compareTo(dateList[j]) > 0) {
          String tmp = dateList[i];
          dateList[i] = dateList[j];
          dateList[j] = tmp;
        }
      }
    }*/
    for (int i = 0; i < dateList.length; i++) {
      scheduledList.addAll(
          {dateList[i]: (await reminderUc.getReminderOfDay(dateList[i]))});
    }
    //sắp xếp reminders
  /*  scheduledList.forEach((key, value) {
      //sắp xếp theo thứ tự ưu tiên
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
    state.update(dateList: null, scheduledList: null);
    yield state.update(dateList: dateList, scheduledList: scheduledList,isUpdated: event.isUpdated);
    log("scheduled list update");
  }
}
