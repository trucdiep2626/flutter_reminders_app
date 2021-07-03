import 'package:flutter/cupertino.dart';

abstract class ScheduledRemindersEvent{

}

class UpdateScheduledEvent extends ScheduledRemindersEvent{
  final bool isUpdated;
  UpdateScheduledEvent({@required this.isUpdated} );
}
class DeleteReminderInScheduledScreenEvent extends ScheduledRemindersEvent{
  final int id;
  DeleteReminderInScheduledScreenEvent({@required this.id});
}