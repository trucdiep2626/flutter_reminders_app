import 'package:flutter/cupertino.dart';

abstract class EditReminderEvent{}

class EditNotesEvent extends EditReminderEvent{
  final String notes;

  EditNotesEvent({@required this.notes});
}


class EditTitleEvent extends EditReminderEvent{
  final String title;

  EditTitleEvent({@required this.title});
}


class EditListEvent extends EditReminderEvent{
  final String list;

  EditListEvent({@required this.list});
}

class SetInfoEvent extends EditReminderEvent{
  final int id;
  final String title;
  final String notes;
  final String list;
  final int date;
  final int time;
  final int priority;
  final int createAt;

  SetInfoEvent({@required this.id,@required this.title, this.notes,@required this.list, this.date, this.time,
   @required this.priority,@required this.createAt});
}

class GetAllGroupEventInEditScreen extends EditReminderEvent{
  GetAllGroupEventInEditScreen();
}

class  UpdateReminderEvent extends EditReminderEvent{
  UpdateReminderEvent( );
}
class EditDateEvent extends EditReminderEvent {
  final bool hasDate;
  final int date;
  EditDateEvent({  this.date, @required this.hasDate});
}

class EditTimeEvent extends EditReminderEvent {
  final bool hasTime;
  final int time;
  EditTimeEvent({@required this.hasTime, this.time});
}
class EditPriorityEvent extends EditReminderEvent {
  final int priority;
  EditPriorityEvent({@required this.priority});
}