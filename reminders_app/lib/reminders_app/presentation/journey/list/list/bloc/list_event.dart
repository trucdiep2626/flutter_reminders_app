import 'package:flutter/cupertino.dart';

abstract class ListEvent{}

class UpdateListEvent extends ListEvent{
final int index;
final bool isUpdated;
  UpdateListEvent({@required this.index, this.isUpdated});
}
class DeleteReminderInListScreenEvent extends ListEvent{
final int id;
  DeleteReminderInListScreenEvent({this.id});
}