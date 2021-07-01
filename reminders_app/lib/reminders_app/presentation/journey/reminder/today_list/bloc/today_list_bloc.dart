import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/domain/usecases/reminder_usecase.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/today_list/bloc/today_list_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/today_list/bloc/today_list_state.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminders_list.dart';
import '../../../../../../common/extensions/date_extensions.dart';
class TodayListBloc extends Bloc<TodayEvent,TodayListState> {
  final ReminderUseCase reminderUc;


  TodayListBloc({@required this.reminderUc});

  @override
  TodayListState get initialState => TodayListState(todayList: [],isUpdated: false);

  String now =  DateTime.now().dateDdMMyyyy;
  @override
  Stream<TodayListState> mapEventToState(TodayEvent event) async* {
    if (event is UpdateTodayListEvent) {
      yield* _mapUpdateEventToState(event);
    }
    if(event is DeleteReminderInTodayScreenEvent)
    {
      yield* _mapDeleteReminderEventToState(event);
    }

  }
  Stream<TodayListState> _mapDeleteReminderEventToState(DeleteReminderInTodayScreenEvent event) async* {
    await reminderUc.deleteReminder(event.id);
    log('deleted');
  }

  Stream<TodayListState> _mapUpdateEventToState(
      UpdateTodayListEvent event) async* {
    log(now+"update");
    List<Reminder> todayList= await reminderUc.getReminderOfDay(now);
   /* for (int i = 0; i < todayList.length - 1; i++)
      for (int j = i; j < todayList.length; j++) {
        if (todayList[i]?.priority <= todayList[j]?.priority) {
          Reminder a = todayList[i];
          todayList[i] = todayList[j];
          todayList[j] = a;
        }
      }
    //sắp xếp theo ngày trong cùng 1 thứ tự ưu tiên
    for (int k = 0; k < todayList.length; k++) {
      for (int h = k + 1; h < todayList.length; h++) {
        if ((todayList[k]?.priority == todayList[h]?.priority) &&
            (todayList[k]?.dateAndTime >= todayList[h]?.dateAndTime)) {
          Reminder a = todayList[k];
          todayList[k] = todayList[h];
          todayList[h] = a;
        }
      }
    }*/
    yield state.update(todayList: null);
    yield state.update(todayList: todayList,isUpdated: event.isUpdated);
  }






}
