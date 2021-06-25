import 'package:reminders_app/reminders_app/domain/entities/group.dart';

abstract class GroupRepository{
  Future<int> setGroup(Group group) async{}

  Future<List<Group>> getAllGroup() async{}

  Future<Group> getGroup(int index) async{  }

  Future<void> deleteGroup(int index) async{}

}