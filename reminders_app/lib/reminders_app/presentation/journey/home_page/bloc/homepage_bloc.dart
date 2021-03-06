import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/domain/usecases/group_usecase.dart';
import 'package:reminders_app/reminders_app/domain/usecases/reminder_usecase.dart';
import 'home_state.dart';
import 'homepage_event.dart';
import '../../../../../common/extensions/date_extensions.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GroupUsecase groupUc;
  final ReminderUseCase reminderUc;

  HomeBloc({@required this.groupUc, @required this.reminderUc});
  @override
  HomeState get initialState => HomeState(
      todayListLength: 0,
      scheduledListLength: 0,
      allListLength: 0,
      myLists: [],
      listLength: {});

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is UpdateEvent) yield* _mapUpdateEventToState(event);
    if (event is SetDefaultGroupEvent)
      yield* _mapSetDefaultGroupEventToState(event);
    if (event is DeleteGroupEvent) yield* _mapDeleteGroupEventToState(event);
  }

  Stream<HomeState> _mapDeleteGroupEventToState(DeleteGroupEvent event) async* {
    yield state.update(viewState: ViewState.busy);
    List<Group> l1 = await groupUc.getAllGroup();
    await reminderUc.deleteRemindersOfList(l1[event.indexGroup].name);
    await groupUc.deleteGroup(event.indexGroup);
    List l2 = await groupUc.getAllGroup();
    if (l2.length < l1.length) {
      log("deleted");
      yield state.update(viewState: ViewState.success);
      return;
    }
    log('error');
    yield state.update(viewState: ViewState.error);
  }

  Stream<HomeState> _mapSetDefaultGroupEventToState(
      SetDefaultGroupEvent event) async* {
    if ((await groupUc.getAllGroup() as List).length == 0) {
      int result = await groupUc.setGroup(Group(
        name: 'Reminders',
        color: 'blue',
        createAt: DateTime.now().dateDdMMyyyy,
        lastUpdate: DateTime.now().dateDdMMyyyy,
      ));
    }
  }

  Stream<HomeState> _mapUpdateEventToState(UpdateEvent event) async* {
    yield state.update(viewState: ViewState.busy);
    int todayListLength = 0;
    int scheduledListLength = 0;
    int allListLength = 0;
    List<Reminder> allReminder = await reminderUc.getAllReminder();
    if (allReminder.length == 0) {
      todayListLength = 0;
      scheduledListLength = 0;
      allListLength = 0;
    } else {
      String now = DateTime.now().dateDdMMyyyy;
      allListLength = allReminder.length;
      todayListLength = (await reminderUc.getReminderOfDay(now)).length;
      for (int i = 0; i < allReminder.length; i++) {
        if (allReminder[i].dateAndTime != 0) {
          scheduledListLength++;
        }
      }
    }
    yield state.update(
      myLists: null,
      listLength: null,
    );
    List<Group> list = await groupUc.getAllGroup();
    Map<String, int> listLength = {};
    for (int i = 0; i < list.length; i++) {
      listLength.addAll({
        list[i].name: (await reminderUc.getReminderOfList(list[i].name)).length
      });
    }

    yield state.update(
      todayListLength: todayListLength,
      scheduledListLength: scheduledListLength,
      allListLength: allListLength,
      myLists: list,
      listLength: listLength,
    );
    log('home update');
  }
}
