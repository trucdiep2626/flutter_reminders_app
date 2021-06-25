import 'package:flutter/cupertino.dart';

abstract class ListEvent{}

class UpdateListEvent extends ListEvent{
final int index;
  UpdateListEvent({@required this.index});
}
class DeleteReminderInListScreenEvent extends ListEvent{
final int id;
  DeleteReminderInListScreenEvent({this.id});
}