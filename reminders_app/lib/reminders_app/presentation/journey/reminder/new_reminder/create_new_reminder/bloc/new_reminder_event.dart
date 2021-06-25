import 'package:flutter/cupertino.dart';

abstract class NewReminderEvent{

}

class SetNotesEvent extends NewReminderEvent{
  final String notes;

  SetNotesEvent({@required this.notes});
}


class SetTitleEvent extends NewReminderEvent{
  final String title;

  SetTitleEvent({@required this.title});
}


class SetListEvent extends NewReminderEvent{
  final String list;

  SetListEvent({@required this.list});
}


class SetDetailsEvent extends NewReminderEvent{
  final Map<String,int> details;

  SetDetailsEvent({@required this.details});
}

class GetAllGroupEvent extends NewReminderEvent{

  GetAllGroupEvent();
}

class CreateNewReminderEvent extends NewReminderEvent{

  CreateNewReminderEvent();
}