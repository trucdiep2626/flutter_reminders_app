abstract class ScheduledRemindersEvent{

}

class UpdateScheduledEvent extends ScheduledRemindersEvent{
  final bool isUpdated;

  UpdateScheduledEvent({this.isUpdated} );
}
class DeleteReminderInScheduledScreenEvent extends ScheduledRemindersEvent{
  final int id;
  DeleteReminderInScheduledScreenEvent({this.id});
}