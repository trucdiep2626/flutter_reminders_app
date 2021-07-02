import 'dart:developer';

import 'package:flutter/material.dart';
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

  Future<Group> getGroupByName(String name) async{
    try
    {
      return await config.groupBox.values.singleWhere((group) => group.name==name);
    }
    catch(IterableElementError)
    {
      return null;
    }

  }

  Future<void> deleteGroup(int index) async
  {
    log(index.toString()+"___________________________");
    await config.groupBox.deleteAt(index);
    log('delete group');
  }

  Future<bool> updateGroup(String oldName,Group newGroup) async
  {
    List<Group> groups= await getAllGroup();
    for(int i=0;i<groups.length;i++)
      {
        if(groups[i].name== oldName)
          {
            config.groupBox.putAt(i, newGroup);
            return true;
          }
      }
    return false;
  }
}