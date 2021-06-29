import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/common/constants/color_constants.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/usecases/group_usecase.dart';
import 'add_list_event.dart';
import 'add_list_state.dart';

import 'package:reminders_app/common/extensions/date_extensions.dart';

class AddListBloc extends Bloc<AddListEvent, AddListState> {
  final GroupUsecase groupUc;

  AddListBloc({this.groupUc});

  @override
  AddListState get initialState =>
      AddListState(selectedColor: Colors.blue, activeAddBtn: false,viewState: ViewState.idle);

  @override
  Stream<AddListState> mapEventToState(AddListEvent event) async* {
    if (event is SelectColorEvent) {
      yield* _mapSelectColorEventToState(event);
    }
    if (event is ActiveAddButtonEvent) {
      yield* _mapActiveAddButtonEventToState(event);
    }
    if (event is CreateNewListEvent) {
      yield* _mapCreateNewListEventToState(event);
    }
    if(event is UpdateViewStateEvent)
      {
        yield* _mapUpdateViewStateEventToState(event);
      }
  }
  Stream<AddListState> _mapUpdateViewStateEventToState(UpdateViewStateEvent event) async*
  {
    yield state.update(viewState: ViewState.busy);
  }
  Stream<AddListState> _mapCreateNewListEventToState(
      CreateNewListEvent event) async* {

    yield state.update(viewState: ViewState.busy);
    //log((await groupUc.getGroupByName(event.name).toString()));
    if ((await groupUc.getGroupByName(event.name) != null)) {
      yield state.update(viewState: ViewState.showDialog);
    }else
      {
      final Group group = Group(
        name: event.name,
        color: ColorConstants.getColorString(event.color) ??
            ColorConstants.getColorString(Colors.blue),
        createAt: DateTime.now().dateDdMMyyyy,
        lastUpdate: DateTime.now().dateDdMMyyyy,
      );
      int result = await groupUc.setGroup(group);

      if (result != null) {
        log('success');
        yield state.update(viewState: ViewState.success);
        return;
      }
      log('error');
      yield state.update(viewState: ViewState.error);
    }


    
    log('add list');
  }

  Stream<AddListState> _mapActiveAddButtonEventToState(
      ActiveAddButtonEvent event) async* {
    final bool activeAddBtn = event.activeAddButton;
    yield state.update(
      activeAddBtn: activeAddBtn,
    );
  }

  Stream<AddListState> _mapSelectColorEventToState(
      SelectColorEvent event) async* {
  
    final Color selectedColor = event.color;
    yield state.update(
      selectedColor: selectedColor,
    );
  }
}
