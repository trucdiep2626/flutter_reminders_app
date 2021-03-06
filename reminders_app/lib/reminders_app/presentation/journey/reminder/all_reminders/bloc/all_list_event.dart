import 'package:flutter/cupertino.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';


abstract class AllRemindersEvent{

}
class DeleteReminderInAllScreenEvent extends AllRemindersEvent{
  final int id;
  DeleteReminderInAllScreenEvent({@required this.id});
}
class UpdateAllListEvent extends AllRemindersEvent{
  final bool isUpdated;
  UpdateAllListEvent({@required this.isUpdated});
}