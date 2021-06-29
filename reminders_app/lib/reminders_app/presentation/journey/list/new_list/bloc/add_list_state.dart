import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:reminders_app/common/enums/view_state.dart';

class AddListState extends Equatable {
  final Color selectedColor;
  final bool activeAddBtn;
  final ViewState viewState;
 
  AddListState({
    @required this.viewState,
    @required this.selectedColor,
    this.activeAddBtn,
  });

  AddListState update({Color selectedColor, bool activeAddBtn, ViewState viewState}) =>
      AddListState(
        viewState: viewState ?? this.viewState,
        selectedColor: selectedColor ?? this.selectedColor,
        activeAddBtn: activeAddBtn ?? this.activeAddBtn,
      );

  @override
  List<Object> get props => [
    this.viewState,
        this.selectedColor,
        this.activeAddBtn,
      ];
}
