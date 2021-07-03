import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:reminders_app/common/enums/view_state.dart';

class EditListState extends Equatable {
  final String oldName;
  final String newName;
  final Color selectedColor;
  final bool activeClearBtn;
  final ViewState viewState;
  final String createAt;

  EditListState({
    this.newName,
    @required this.createAt,
    @required this.oldName,
    @required this.viewState,
    @required this.selectedColor,
    this.activeClearBtn,
  });

  EditListState update(
          {Color selectedColor,
          bool activeClearBtn,
          ViewState viewState,
          String oldName,
            String newName,
          String createAt}) =>
      EditListState(
        newName: newName??this.newName,
        createAt: createAt ?? this.createAt,
        oldName: oldName ?? this.oldName,
        viewState: viewState ?? this.viewState,
        selectedColor: selectedColor ?? this.selectedColor,
        activeClearBtn: activeClearBtn ?? this.activeClearBtn,
      );

  @override
  List<Object> get props => [
    this.newName,
        this.createAt,
        this.oldName,
        this.viewState,
        this.selectedColor,
        this.activeClearBtn,
      ];
}
