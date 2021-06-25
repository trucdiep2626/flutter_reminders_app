import 'dart:developer';

import 'package:hive/hive.dart';
part 'reminder.g.dart';
@HiveType(typeId: 2)
class Reminder {
  Reminder({this.id, this.title, this.notes, this.list, this.dateAndTime,
    this.createAt, this.lastUpdate, this.priority});
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String notes;
  @HiveField(3)
  String list='Reminders';
  @HiveField(4)
  int dateAndTime;
  @HiveField(5)
  int createAt;
  @HiveField(6)
  int lastUpdate;
  @HiveField(7)
  int priority=0;


}