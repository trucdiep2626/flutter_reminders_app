import 'package:flutter/cupertino.dart';
import 'package:reminders_app/common/enums/view_state.dart';

abstract class EditListEvent {

}

class SelectColorEvent extends EditListEvent {
  final Color color;
  SelectColorEvent({@required this.color});
}

class ActiveClearButtonEvent extends EditListEvent{
  final bool activeClearButton;
  ActiveClearButtonEvent({@required this.activeClearButton});
}

class UpdateListEvent extends EditListEvent{
  final String name;
  final Color color;
  UpdateListEvent({@required this.name,@required this.color });
}

class UpdateViewStateEvent extends EditListEvent{
  final ViewState viewState;
  UpdateViewStateEvent({@required this.viewState});
}

class SetInfoOfListEvent extends  EditListEvent{
  final String name;
  final Color color;
  final String createAt;
  SetInfoOfListEvent({@required this.name,@required this.color,@required this.createAt });
}