/*
class ReminderState{
  String title;
  String notes;
  String list = 'Reminders';
  var details;

  ReminderState({this.title, this.notes, this.list, this.details});
  ReminderState update({
    String title,
    String notes,
    String list,
    var details,
}) => ReminderState(title:title?? this.title, notes:notes?? this.notes, list:list?? this.list, details:details?? this.details);
}*/
import 'package:equatable/equatable.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/reminders_app/domain/entities/group.dart';

 
class NewReminderState extends Equatable {
  final String title;
  final String notes;
  final String list  ;
  final Map<String,int> details;
  final ViewState viewState;
  final List<Group> myLists;

  NewReminderState({this.title, this.notes, this.list, this.details,this.viewState,this.myLists});

  NewReminderState update({String title,List<Group> myLists,
  String notes,
  String list,
  Map<String,int> details, ViewState viewState}) =>
      NewReminderState(
        myLists: myLists?? this.myLists,
       title: title?? this.title,
        notes: notes?? this.notes,
        list: list?? this.list,
        details: details??this.details,
          viewState: viewState?? this.viewState
      );

  @override
  List<Object> get props => [this.viewState,
    this.title,
      this.notes,
     this.list,
     this.details,
    this.myLists
  ];
}