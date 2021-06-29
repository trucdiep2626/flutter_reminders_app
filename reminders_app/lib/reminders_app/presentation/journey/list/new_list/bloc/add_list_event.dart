import 'package:flutter/cupertino.dart';
import 'package:reminders_app/common/enums/view_state.dart';

abstract class AddListEvent {

}

class SelectColorEvent extends AddListEvent {
  final Color color;
  SelectColorEvent({@required this.color});
}

class ActiveAddButtonEvent extends AddListEvent{
  final bool activeAddButton;
  ActiveAddButtonEvent({@required this.activeAddButton});
}

class CreateNewListEvent extends AddListEvent{
  final String name;
  final Color color;
  CreateNewListEvent({@required this.name,@required this.color });
}

class UpdateViewStateEvent extends AddListEvent{
  final ViewState viewState;
  UpdateViewStateEvent({@required this.viewState});
}