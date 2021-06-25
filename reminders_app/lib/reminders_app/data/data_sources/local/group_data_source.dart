import 'dart:developer';

import 'package:reminders_app/common/config/local_config.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';

class GroupDataSource{
  final LocalConfig config;

  GroupDataSource({this.config});
  
  Future<int> setGroup (Group group) async
  {
    log('add to box');
    return await config.groupBox.add(group);
  }
  Future<List<Group>> getAllGroup() async{
    log('get all group');
    return await config.groupBox.values.toList() as List<Group>;
  }

  Future<Group> getGroup(int index) async{
    return await config.groupBox.getAt(index);
  }

  Future<void> deleteGroup(int index) async
  {
    await config.groupBox.deleteAt(index);
    log('delete group');
  }
}