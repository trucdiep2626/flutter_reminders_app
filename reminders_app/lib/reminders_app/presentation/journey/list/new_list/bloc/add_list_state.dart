import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:reminders_app/common/enums/view_state.dart';

class AddListState extends Equatable {
  final Color selectColor;
  final bool activeAddBtn;
  final ViewState viewState;
  AddListState({
    @required this.viewState,
    @required this.selectColor,
    this.activeAddBtn,
  });

  AddListState update({Color selectColor, bool activeAddBtn, ViewState viewState}) =>
      AddListState(
        viewState: viewState ?? this.viewState,
        selectColor: selectColor ?? this.selectColor,
        activeAddBtn: activeAddBtn ?? this.activeAddBtn,
      );

  @override
  List<Object> get props => [
    this.viewState,
        this.selectColor,
        this.activeAddBtn,
      ];
}
