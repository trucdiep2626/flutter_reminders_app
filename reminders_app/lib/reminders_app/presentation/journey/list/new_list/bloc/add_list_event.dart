import 'package:flutter/cupertino.dart';

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

  CreateNewListEvent({@required this.name });
}