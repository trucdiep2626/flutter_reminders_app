import 'package:flutter/cupertino.dart';

abstract class HomeEvent {}

class UpdateEvent extends HomeEvent {
  UpdateEvent();
}

class SetDefaultGroupEvent extends HomeEvent {
  SetDefaultGroupEvent();
}

class DeleteGroupEvent extends HomeEvent {
  final int indexGroup;

  DeleteGroupEvent({@required this.indexGroup});
}
