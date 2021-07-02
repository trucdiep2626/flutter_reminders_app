import 'package:flutter/cupertino.dart';

abstract class AddDetailsEvent {

}

class SetDateEvent extends AddDetailsEvent {
  final bool hasDate;
  final int date;
  SetDateEvent({  this.date, @required this.hasDate});
}

class SetTimeEvent extends AddDetailsEvent {
  final bool hasTime;
  final int time;
  SetTimeEvent({@required this.hasTime, this.time});
}
class SetPriorityEvent extends AddDetailsEvent {
  final int priority;
  SetPriorityEvent({@required this.priority});
}

class SetDefaultEvent extends AddDetailsEvent{
  final int date;
  final int time;
  final int priority;
  SetDefaultEvent({this.date, this.time, this.priority});
}