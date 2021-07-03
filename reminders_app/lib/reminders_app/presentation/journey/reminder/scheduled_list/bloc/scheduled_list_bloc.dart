import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/domain/usecases/reminder_usecase.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/scheduled_list/bloc/scheduled_list_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/scheduled_list/bloc/scheduled_list_state.dart';

import 'package:reminders_app/common/extensions/date_extensions.dart';
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
    List<int> dateList = await reminderUc.getAllDate();
    Map<int, List<Reminder>> scheduledList = {};
    for (int i = 0; i < dateList.length; i++) {
      scheduledList.addAll(
          {dateList[i]: (await reminderUc.getReminderOfDay(DateTime.fromMillisecondsSinceEpoch(dateList[i]).dateDdMMyyyy))});
    }
    state.update(dateList: null, scheduledList: null);
    yield state.update(dateList: dateList, scheduledList: scheduledList,isUpdated: event.isUpdated);
    log("scheduled list update");
  }
}
