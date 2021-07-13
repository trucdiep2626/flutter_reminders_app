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
import 'new_reminder_event.dart';
import 'reminder_state.dart';

class NewReminderBloc extends Bloc<NewReminderEvent, NewReminderState> {
  final ReminderUseCase reminderUc;
  final GroupUsecase groupUc;
  NewReminderBloc({@required this.reminderUc,@required this.groupUc});
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
    List<Group> lists = await groupUc.getAllGroup();
    yield state.update(myLists: null);
    yield state.update(myLists: lists);
  }

  Stream<NewReminderState> _mapCreateNewReminderToState(
      CreateNewReminderEvent event) async* {
    yield state.update(viewState: ViewState.busy);
  //  int lengthOfBox= (await reminderUc.getLengthOfBox());
    List<Reminder> allReminders = await reminderUc.getAllReminder();
    int id;
  if(allReminders.isNotEmpty)
    {
       id=allReminders[0].id;
      for(int i=0;i<allReminders.length;i++)
      {
        if(id<allReminders[i].id)
        {
          id=allReminders[i].id;
        }
      }
    }
    final Reminder reminder = Reminder(
      id: allReminders.length!=0?id+ 1:1,
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
    log(reminder.id.toString()+"iddddđ");
    log(reminder.priority.toString()+"priority");
    var result;
    if(allReminders.isEmpty)
      {
        result = await reminderUc.setReminder(reminder);
      }
    else
      {
        result = await reminderUc.setReminder(reminder);

      if(allReminders.length<2)
        {
          if(allReminders[0].priority== reminder.priority)
            {
              if(allReminders[0].dateAndTime <= reminder.dateAndTime)
              {
                allReminders.insert(1, reminder);
              }
              else
                {
                  allReminders.insert(0, reminder);
                }
            }
          else if(allReminders[0].priority > reminder.priority)
            {
              allReminders.insert(1, reminder);
            }
          else if(allReminders[0].priority < reminder.priority)
          {
            allReminders.insert(0, reminder);
          }
        }
      else
       {
         if(reminder.priority==3)
         {
           allReminders.insert(0, reminder);
         }
         else
           {
             for(int i=0;i<allReminders.length-1;i++)
             {
               if((allReminders[i].priority>= reminder.priority && reminder.priority>= allReminders[i+1].priority))
               {
                 allReminders.insert(i+1, reminder);
                 break;
               }
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
       }
      result= await reminderUc.updateBox(allReminders);
      }

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
