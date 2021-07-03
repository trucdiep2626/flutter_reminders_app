import 'package:flutter/cupertino.dart';
import 'package:reminders_app/common/enums/view_state.dart';

abstract class EditListEvent {}

class EditColorEvent extends EditListEvent {
  final Color color;
  EditColorEvent({@required this.color});
}
class EditNameEvent extends EditListEvent{
  final String name;
  EditNameEvent({@required this.name});
}

class ActiveClearButtonEvent extends EditListEvent {
  final bool activeClearButton;
  ActiveClearButtonEvent({@required this.activeClearButton});
}

class UpdateListEvent extends EditListEvent {
  final String name;
  final Color color;
  UpdateListEvent({@required this.name, @required this.color});
}

class UpdateViewStateEvent extends EditListEvent {
  final ViewState viewState;
  UpdateViewStateEvent({@required this.viewState});
}

class SetInfoOfListEvent extends EditListEvent {
  final String name;
  final Color color;
  final String createAt;
  SetInfoOfListEvent(
      {@required this.name, @required this.color, @required this.createAt});
}
