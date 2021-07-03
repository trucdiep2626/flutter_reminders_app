import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/common/constants/color_constants.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/usecases/group_usecase.dart';

import 'package:reminders_app/common/extensions/date_extensions.dart';
import 'package:reminders_app/reminders_app/domain/usecases/reminder_usecase.dart';

import 'edit_list_event.dart';
import 'edit_list_state.dart';

class EditListBloc extends Bloc<EditListEvent, EditListState> {
  final GroupUsecase groupUc;
  final ReminderUseCase reminderUc;

  EditListBloc({@required this.groupUc, @required this.reminderUc});

  @override
  EditListState get initialState =>
      EditListState(activeClearBtn: true, viewState: ViewState.idle);

  @override
  Stream<EditListState> mapEventToState(EditListEvent event) async* {
    if (event is EditColorEvent) {
      yield* _mapSelectColorEventToState(event);
    }
    if (event is UpdateListEvent) {
      yield* _mapUpdateListEventToState(event);
    }
    if (event is UpdateViewStateEvent) {
      yield* _mapUpdateViewStateEventToState(event);
    }
    if (event is SetInfoOfListEvent) {
      yield* _mapSetInfoOfListEventToState(event);
    }
    if (event is ActiveClearButtonEvent) {
      yield* _mapActiveClearButtonEventToState(event);
    }
    if (event is EditNameEvent) {
      yield* _mapEditNameEventToState(event);
    }
  }
  Stream<EditListState> _mapEditNameEventToState(
      EditNameEvent event) async* {
    yield state.update(newName: event.name
    );
  }


  Stream<EditListState> _mapActiveClearButtonEventToState(
      ActiveClearButtonEvent event) async* {
    yield state.update(
      activeClearBtn: event.activeClearButton,
    );
  }

  Stream<EditListState> _mapSetInfoOfListEventToState(
      SetInfoOfListEvent event) async* {
    yield state.update(
      newName: event.name,
        selectedColor: event.color,
        oldName: event.name,
        createAt: event.createAt);
  }

  Stream<EditListState> _mapUpdateViewStateEventToState(
      UpdateViewStateEvent event) async* {
    yield state.update(viewState: ViewState.busy);
  }

  Stream<EditListState> _mapUpdateListEventToState(
      UpdateListEvent event) async* {
    yield state.update(viewState: ViewState.busy);
    final Group group = Group(
      name: event.name,
      color: ColorConstants.setColorString(event.color)?? ColorConstants.getColorString(event.color),
      createAt: state.createAt,
      lastUpdate: DateTime.now().dateDdMMyyyy,
    );
    var result = await groupUc.updateGroup(state.oldName, group);
    if (group.name != state.oldName) {
      await reminderUc.updateListOfReminders(state.oldName, group.name);
    }
    if (result == true) {
      log('success');
      yield state.update(viewState: ViewState.success);
      return;
    }
    log('error');
    yield state.update(viewState: ViewState.error);
  }

  Stream<EditListState> _mapSelectColorEventToState(
      EditColorEvent event) async* {
    final Color selectedColor = event.color;
    yield state.update(
      selectedColor: selectedColor,
    );
  }
}
