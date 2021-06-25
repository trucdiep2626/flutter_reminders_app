import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/scheduled_list/bloc/scheduled_list_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/scheduled_list/bloc/scheduled_list_state.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminders_list.dart';

class ScheduledRemindersBloc extends Bloc<ScheduledRemindersEvent, ScheduledRemindersState> {
  @override
  ScheduledRemindersState get initialState => ScheduledRemindersState(dateList: [],scheduledList: null );

  @override
  Stream<ScheduledRemindersState> mapEventToState(ScheduledRemindersEvent event) async* {
    if (event is UpdateScheduledEvent) {
      yield* _mapUpdateEventToState(event);
    }

  }

  Stream<ScheduledRemindersState> _mapUpdateEventToState(
      UpdateScheduledEvent event) async* {
     List<String> dateList=[] ;
      Map<String, List<Reminder>> scheduledList={}  ;
    log("scheduled list update");
    state.update(dateList: null,scheduledList: null);
    log(RemindersList.allReminders.length.toString());
    RemindersList.allReminders.forEach((key, value) {
      log(key);
      if(key!='Others') {
        if(value.length!=0) {
          log(key);
          dateList.add(key);
          scheduledList.addAll({key: value});
        }
      }
    });
    log(dateList.length.toString());
    for(int i=0;i<dateList.length-1;i++)
    {
      for(int j=i+1;j<dateList.length;j++)
      {
        if((dateList[i]).compareTo(dateList[j])>0)
        {
          String tmp= dateList[i];
          dateList[i]=dateList[j];
          dateList[j]=tmp;
        }
      }
    }
    yield state.update(dateList: dateList,scheduledList: scheduledList);
  
  }


}