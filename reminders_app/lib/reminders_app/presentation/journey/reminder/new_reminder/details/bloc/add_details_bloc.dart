import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_details_event.dart';
import 'add_details_state.dart';

class AddDetailsBloc extends Bloc<AddDetailsEvent, AddDetailsState> {
  @override
  AddDetailsState get initialState => AddDetailsState(
      date: 0, time: 0, priority: 0, hasTime: false, hasDate: false);

  @override
  Stream<AddDetailsState> mapEventToState(AddDetailsEvent event) async* {


    switch (event.runtimeType) {
      case SetDateEvent:
        yield* _mapSetDateEventToState(event);
        break;
      case SetTimeEvent:
        yield* _mapSetTimeEventToState(event);
        break;
      case SetPriorityEvent:
        yield* _mapSetPriorityEventToState(event);
        break;
    }
  }

  Stream<AddDetailsState> _mapSetDateEventToState(SetDateEvent event) async* {
    final int date = event.date;
   // log(event.hasDate.toString()+"dateeeee");
    yield state.update(
      hasDate: null,
      date: date,
    );
    yield state.update(
      hasDate: event.hasDate,
      date: date,
    );
  }

  Stream<AddDetailsState> _mapSetTimeEventToState(SetTimeEvent event) async* {
    final int time = event.time;
    yield state.update(
      hasTime: event.hasTime,
      time: time,
    );
  }

  Stream<AddDetailsState> _mapSetPriorityEventToState(
      SetPriorityEvent event) async* {
    final int priority = event.priority;
    yield state.update(
      priority: priority,
    );
  }
}
