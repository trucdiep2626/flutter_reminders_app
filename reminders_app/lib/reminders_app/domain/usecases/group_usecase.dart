import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';
import 'package:reminders_app/reminders_app/domain/repositories/group_repository.dart';

class GroupUsecase{
  final GroupRepository groupRepo;

  GroupUsecase({@required this.groupRepo});
  Future<int> setGroup(Group group) async
  {
    return  await groupRepo.setGroup(group);
  }
  Future<List<Group>> getAllGroup() async{
    //log("+++++++++++++++++++++");
    return await groupRepo.getAllGroup();
  }

  Future<Group> getGroup(int index) async{
    return await groupRepo.getGroup(index);
  }
  Future<Group> getGroupByName(String name) async{
    return await groupRepo.getGroupByName(name);
  }
  Future<void> deleteGroup(int index) async{

    return await groupRepo.deleteGroup(index);
  }

}