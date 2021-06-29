abstract class TodayEvent{

}
class UpdateTodayListEvent extends TodayEvent{
  final bool isUpdated;

  UpdateTodayListEvent({this.isUpdated});
}
class DeleteReminderInTodayScreenEvent extends TodayEvent{
  final int id;
  DeleteReminderInTodayScreenEvent({this.id});
}