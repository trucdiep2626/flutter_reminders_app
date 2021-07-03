import 'package:flutter/cupertino.dart';

abstract class ListEvent{}

class UpdateListScreenEvent extends ListEvent{
final int index;
final bool isUpdated;
UpdateListScreenEvent({@required this.index,@required this.isUpdated});
}
class DeleteReminderInListScreenEvent extends ListEvent{
final int id;
  DeleteReminderInListScreenEvent({@required this.id});
}