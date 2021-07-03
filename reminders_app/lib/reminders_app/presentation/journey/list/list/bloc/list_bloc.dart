import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/domain/usecases/group_usecase.dart';
import 'package:reminders_app/reminders_app/domain/usecases/reminder_usecase.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/list/bloc/list_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/list/bloc/list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final ReminderUseCase reminderUc;
  final GroupUsecase groupUc;

  ListBloc({@required this.reminderUc,@required this.groupUc});

  @override
  ListState get initialState =>
      ListState(reminderList: [], list: Group(), isUpdated: false);

  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {
    if (event is UpdateListScreenEvent) {
      yield* _mapUpdateEventToState(event);
    }
    if (event is DeleteReminderInListScreenEvent)
      yield* _mapDeleteReminderEventToState(event);
  }

  Stream<ListState> _mapDeleteReminderEventToState(
      DeleteReminderInListScreenEvent event) async* {
    await reminderUc.deleteReminder(event.id);
    log('deleted');
  }

  Stream<ListState> _mapUpdateEventToState(UpdateListScreenEvent event) async* {
    Group list = await groupUc.getGroup(event.index);
    final List<Reminder> reminderList =
        await reminderUc.getReminderOfList(list.name);
    yield state.update(reminderList: null, list: list);
    yield state.update(
        reminderList: reminderList, list: list, isUpdated: event.isUpdated);
    log("list update");
  }
}
