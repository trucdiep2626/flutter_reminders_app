import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class AddDetailsState extends Equatable {
  final int date;
  final int time;
  final int priority;
  final bool hasDate;
  final bool hasTime;

  AddDetailsState({
     this.date,
    this.time,
    this.priority,
    this.hasTime,
    this.hasDate
  });

  AddDetailsState update({  int date,
   int time,
  int priority,bool hasDate,
     bool hasTime,}) =>
      AddDetailsState(
         date:date ?? this.date,
         time:time?? this.time,
         priority: priority?? this.priority,
          hasDate: hasDate?? this.hasDate,
        hasTime: hasTime??this.hasTime,
      );

  @override
  List<Object> get props => [
    this.date,
    this.time,
    this.priority,
    this.hasTime,
    this.hasDate
  ];
}
