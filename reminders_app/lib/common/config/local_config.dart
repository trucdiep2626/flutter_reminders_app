import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:reminders_app/common/config/default_env.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';

class LocalConfig{
  Box<Group> groupBox;
  Box<Reminder> reminderBox;

 Future<void> init() async{
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(GroupAdapter());
  Hive.registerAdapter(ReminderAdapter());
  groupBox = await Hive.openBox(DefaultEnv.groupCollection);
  reminderBox = await Hive.openBox(DefaultEnv.reminderCollection);
  log('open box');
}

void dispose(){
  groupBox.compact();
  Hive.close();
}
}