import 'dart:developer';
import 'package:reminders_app/common/extensions/date_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/domain/usecases/group_usecase.dart';
import 'package:reminders_app/reminders_app/domain/usecases/reminder_usecase.dart';
import 'package:reminders_app/reminders_app/presentation/journey/home_page/bloc/homepage_bloc.dart';
import 'new_reminder_event.dart';
import 'reminder_state.dart';

class NewReminderBloc extends Bloc<NewReminderEvent, NewReminderState> {
  final ReminderUseCase reminderUc;
  final GroupUsecase groupUc;
  NewReminderBloc({this.reminderUc, this.groupUc});
  @override
  NewReminderState get initialState =>
      NewReminderState(list: 'Reminders', myLists: []);

  @override
  Stream<NewReminderState> mapEventToState(NewReminderEvent event) async* {
    if (event is SetTitleEvent) {
      yield* _mapSetTitleEventToState(event);
    }
    if (event is SetNotesEvent) {
      yield* _mapSetNotesEventToState(event);
    }
    if (event is SetListEvent) {
      yield* _mapSetListEventToState(event);
    }
    if (event is SetDetailsEvent) {
      yield* _mapSetDetailsEventToState(event);
    }
    if (event is CreateNewReminderEvent) {
      yield* _mapCreateNewReminderToState(event);
    }
    if (event is GetAllGroupEvent) {
      yield* _mapGetAllGroupToState(event);
    }
  }

  Stream<NewReminderState> _mapGetAllGroupToState(
      GetAllGroupEvent event) async* {
    log('get group');
    List<Group> lists = await groupUc.getAllGroup();
//log(lists.length.toString()+"))))))))");
    yield state.update(myLists: null);
    yield state.update(myLists: lists);
   // log(state.myLists.length.toString()+"))))))))");
  }

  Stream<NewReminderState> _mapCreateNewReminderToState(
      CreateNewReminderEvent event) async* {
    yield state.update(viewState: ViewState.busy);
    final Reminder reminder = Reminder(
      id: (await reminderUc.getAllReminder()).length + 1,
      title: state.title,
      notes: state.notes ?? '',
      list: state.list,
      dateAndTime: state.details != null
          ? state.details['date'] + state.details['time']
          : 0,
      priority: state.details != null ? state.details['priority'] : 0,
      createAt: DateTime.now().millisecondsSinceEpoch,
      lastUpdate: DateTime.now().millisecondsSinceEpoch,
    );
    int result = await reminderUc.setReminder(reminder);
    if (result != null) {
      log('success');
      yield state.update(viewState: ViewState.success);
      return;
    }
    log('error');
    yield state.update(viewState: ViewState.error);
  }

  Stream<NewReminderState> _mapSetTitleEventToState(
      SetTitleEvent event) async* {
    final String title = event.title;
    yield state.update(title: title);
  }

  Stream<NewReminderState> _mapSetNotesEventToState(
      SetNotesEvent event) async* {
    final String notes = event.notes;
    yield state.update(notes: notes);
  }

  Stream<NewReminderState> _mapSetListEventToState(SetListEvent event) async* {
    final String list = event.list;
    yield state.update(list: list);
  }

  Stream<NewReminderState> _mapSetDetailsEventToState(
      SetDetailsEvent event) async* {
    yield state.update(details: event.details);
  }
}
