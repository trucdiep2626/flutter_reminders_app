import 'package:flutter/cupertino.dart';

abstract class TodayEvent{

}
class UpdateTodayListEvent extends TodayEvent{
  final bool isUpdated;

  UpdateTodayListEvent({@required this.isUpdated});
}
class DeleteReminderInTodayScreenEvent extends TodayEvent{
  final int id;
  DeleteReminderInTodayScreenEvent({@required this.id});
}