import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/domain/usecases/reminder_usecase.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/today_list/bloc/today_list_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/today_list/bloc/today_list_state.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminders_list.dart';
import '../../../../../../common/extensions/date_extensions.dart';
class TodayListBloc extends Bloc<TodayEvent,TodayListState> {
  final ReminderUseCase reminderUc;


  TodayListBloc({this.reminderUc});

  @override
  TodayListState get initialState => TodayListState(todayList: []);

  String now =  DateTime.now().dateDdMMyyyy;
  @override
  Stream<TodayListState> mapEventToState(TodayEvent event) async* {
    if (event is UpdateTodayListEvent) {
      yield* _mapUpdateEventToState(event);
    }

  }

  Stream<TodayListState> _mapUpdateEventToState(
      UpdateTodayListEvent event) async* {
    log(now+"update");
    List<Reminder> todayList= await reminderUc.getReminderOfDay(now);
    yield state.update(todayList: null);
    yield state.update(todayList: todayList);
  }






}
