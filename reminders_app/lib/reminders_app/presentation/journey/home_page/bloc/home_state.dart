import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';

class HomeState extends Equatable {
  final int todayListLength;
  final int scheduledListLength;
  final int allListLength;
  final List<Group> myLists;
  final ViewState viewState;
  final Map<String, int> listLength;

  HomeState(
      {@required this.viewState,
      @required this.todayListLength,
      @required this.scheduledListLength,
      @required this.allListLength,
      @required this.myLists,
      @required this.listLength});

  HomeState update(
          {int todayListLength,
          int scheduledListLength,
          int allListLength,
          List myLists,
          ViewState viewState,
          Map<String, int> listLength}) =>
      HomeState(
          listLength: listLength,
          viewState: viewState ?? this.viewState,
          todayListLength: todayListLength ?? this.todayListLength,
          scheduledListLength: scheduledListLength ?? this.scheduledListLength,
          allListLength: allListLength ?? this.allListLength,
          myLists: myLists
          );

  @override
  List<Object> get props => [
        this.todayListLength,
        this.scheduledListLength,
        this.allListLength,
        this.myLists,
        this.viewState,
        this.listLength
      ];
}
