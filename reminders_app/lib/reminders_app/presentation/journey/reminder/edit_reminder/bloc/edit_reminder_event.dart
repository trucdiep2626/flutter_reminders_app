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



class GetAllGroupEventInEditScreen extends EditReminderEvent{
  GetAllGroupEventInEditScreen();
}

class  UpdateReminderEvent extends EditReminderEvent{
  final int id;
  final int createAt;
  UpdateReminderEvent({ this.id,this.createAt});
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