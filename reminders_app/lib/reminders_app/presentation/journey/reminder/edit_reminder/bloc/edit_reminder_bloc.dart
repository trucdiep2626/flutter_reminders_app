import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:reminders_app/common/extensions/date_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/domain/usecases/group_usecase.dart';
import 'package:reminders_app/reminders_app/domain/usecases/reminder_usecase.dart';
import 'package:reminders_app/reminders_app/presentation/journey/home_page/bloc/homepage_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/edit_reminder/bloc/edit_reminder_state.dart';
import 'edit_reminder_event.dart';

class EditReminderBloc extends Bloc<EditReminderEvent, EditReminderState> {
  final ReminderUseCase reminderUc;
  final GroupUsecase groupUc;

  EditReminderBloc({@required this.reminderUc, @required this.groupUc});

  @override
  EditReminderState get initialState => EditReminderState(
      list: 'Reminders',
      myLists: [],
      date: 0,
      time: 0,
      priority: 0,
      hasTime: false,
      hasDate: false);

  @override
  Stream<EditReminderState> mapEventToState(EditReminderEvent event) async* {
    if (event is EditTitleEvent) {
      yield* _mapEditTitleEventToState(event);
    }
    if (event is EditNotesEvent) {
      yield* _mapEditNotesEventToState(event);
    }
    if (event is EditListEvent) {
      yield* _mapEditListEventToState(event);
    }
    if (event is EditDateEvent) {
      yield* _mapEditDateEventToState(event);
    }
    if (event is EditTimeEvent) {
      yield* _mapEditTimeEventToState(event);
    }
    if (event is EditPriorityEvent) {
      yield* _mapEditPriorityEventToState(event);
    }
    if (event is UpdateReminderEvent) {
      yield* _mapUpdateReminderEventToState(event);
    }
    if (event is GetAllGroupEventInEditScreen) {
      yield* _mapGetAllGroupToState(event);
    }
    if (event is SetInfoEvent) {
      yield* _mapSetInfoEventToState(event);
    }
  }

  Stream<EditReminderState> _mapEditDateEventToState(
      EditDateEvent event) async* {
    final int date = event.date;
    // log(event.hasDate.toString()+"dateeeee");
    yield state.update(
      hasDate: event.hasDate,
      date: date,
    );
  }

  Stream<EditReminderState> _mapEditTimeEventToState(
      EditTimeEvent event) async* {
    final int time = event.time;
    yield state.update(
      hasTime: event.hasTime,
      time: time,
    );
  }

  Stream<EditReminderState> _mapEditPriorityEventToState(
      EditPriorityEvent event) async* {
    final int priority = event.priority;
    yield state.update(
      priority: priority,
    );
  }

  Stream<EditReminderState> _mapGetAllGroupToState(
      GetAllGroupEventInEditScreen event) async* {
    log('get group');
    List<Group> lists = await groupUc.getAllGroup();
    yield state.update(myLists: null);
    yield state.update(myLists: lists);
  }

  Stream<EditReminderState> _mapEditTitleEventToState(
      EditTitleEvent event) async* {
    final String title = event.title;
    yield state.update(title: title);
  }

  Stream<EditReminderState> _mapEditNotesEventToState(
      EditNotesEvent event) async* {
    final String notes = event.notes;
    yield state.update(notes: notes);
  }

  Stream<EditReminderState> _mapEditListEventToState(
      EditListEvent event) async* {
    final String list = event.list;
    log(list);
    yield state.update(list: list);
  }

  Stream<EditReminderState> _mapUpdateReminderEventToState(
      UpdateReminderEvent event) async* {
    yield state.update(viewState: ViewState.busy);
    var result;
    final Reminder reminder = Reminder(
      id: state.id,
      title: state.title,
      notes: state.notes ?? '',
      list: state.list,
      dateAndTime: state.hasDate == false
          ? 0
          : state.hasTime == false
              ? state.date
              : state.date + state.time+1,
      priority: state.priority != null ? state.priority : 0,
      createAt: state.createAt,
      lastUpdate: DateTime.now().millisecondsSinceEpoch,
    );
    log('>>>>>>>>>>');
    result = await reminderUc.updateReminder(reminder, state.id);
    log('>>>>>>>>>>');
    List<Reminder> allReminders = await reminderUc.getAllReminder();
    for (int i = 0; i < allReminders?.length - 1; i++)
      for (int j = i; j < allReminders?.length; j++) {
        if (allReminders[i]?.priority <= allReminders[j]?.priority) {
          Reminder a = allReminders[i];
          allReminders[i] = allReminders[j];
          allReminders[j] = a;
        }
      }

    for (int k = 0; k < allReminders.length; k++) {
      for (int h = k + 1; h < allReminders.length; h++) {
        if ((allReminders[k]?.priority == allReminders[h]?.priority) &&
            (allReminders[k]?.dateAndTime >= allReminders[h]?.dateAndTime)) {
          Reminder a = allReminders[k];
          allReminders[k] = allReminders[h];
          allReminders[h] = a;
        }
      }
    }

    log('hihi');
    result = await reminderUc.updateBox(allReminders);
    if (result != null) {
      log('success');
      yield state.update(viewState: ViewState.success);
      return;
    }
    log('error');
    yield state.update(viewState: ViewState.error);
  }

  Stream<EditReminderState> _mapSetInfoEventToState(SetInfoEvent event) async* {
    yield state.update(
      id: event.id,
        createAt: event.createAt,
        title: event.title,
        notes: event.notes,
        list: event.list,
        priority: event.priority,
    hasDate: (event.date!=0)?true:false,
      date: event.date,
      hasTime: event.time!=0?true:false,
      time: event.time
    );
    // if (event.date != 0) {
    //   int date= event.date;
    //   yield state.update(hasDate: true, date: date);
    //   if (event.time != 0) {
    //     int time = event.time;
    //     yield state.update(hasTime: true, time:  time);
    //   }
    // }
    log(state.hasDate.toString()+"  "+state.date.toString());
    log(state.hasTime.toString()+"  "+state.time.toString());
  }
}
