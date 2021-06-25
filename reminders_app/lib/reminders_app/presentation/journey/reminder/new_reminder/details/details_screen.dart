import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:intl/intl.dart';
import 'package:reminders_app/reminders_app/theme/theme.dart';

import '../../../../../../common/extensions/date_extensions.dart';
import '../../../../../../common/enums/priority_type.dart';
import '../../../../../../common/utils/priority_type_utils.dart';
import '../../../home_page/homepage_constants.dart';
import '../new_reminder_constants.dart';
import 'bloc/add_details_bloc.dart';

import 'bloc/add_details_event.dart';
import 'bloc/details_stream.dart';
import 'details_constants.dart';
import 'widget/details_item.dart';
import 'widget/priority_dialog.dart';
import 'widget/priority_item.dart';
import '../../../../../widgets_constants/appbar.dart';

import 'bloc/add_details_state.dart';

class DetailsScreen extends StatefulWidget {
  int date;
  int time;
  int priority;

  DetailsScreen({this.date, this.time, this.priority});

  @override
  State<StatefulWidget> createState() =>
      _DetailsScreen(date: date, time: time, priority: priority);
}

class _DetailsScreen extends State<DetailsScreen> {
  int date;
  int time;
  int priority;

  void setDefault(int date, int time, int priority, BuildContext context) {
    if (date != 0) {
      BlocProvider.of<AddDetailsBloc>(context)
          .add(SetDateEvent(hasDate: true, date: date));
      if (time != 0) {
        BlocProvider.of<AddDetailsBloc>(context)
            .add(SetTimeEvent(hasTime: true, time: time));
      } else {
        BlocProvider.of<AddDetailsBloc>(context)
            .add(SetTimeEvent(hasTime: false, time: 0));
      }
    } else {
      BlocProvider.of<AddDetailsBloc>(context)
          .add(SetDateEvent(hasDate: false, date: 0));
      BlocProvider.of<AddDetailsBloc>(context)
          .add(SetTimeEvent(hasTime: false, time: 0));
    }
    BlocProvider.of<AddDetailsBloc>(context)
        .add(SetPriorityEvent(priority: priority));
  }

  _DetailsScreen({this.date, this.time, this.priority});

  @override
  void dispode() {
    super.dispose();
  }

  String selectedPriority = 'None';

  @override
  Widget build(BuildContext context) {
    String now = DateTime.now().dateDdMMyyyy;
    return BlocBuilder<AddDetailsBloc, AddDetailsState>(
          builder: (context, state) {
           // setDefault(date, time, priority, context);
            return Scaffold(
                appBar: _appBar(context, state),
                body: Column(children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: DetailConstants.marginHorizontal,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: GridView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 6,
                        ),
                        children: [
                          DetailsItem(
                            title: DetailConstants.dateTxt,
                            subtitle: state.hasDate == true
                                ? DateTime.fromMillisecondsSinceEpoch(
                                state.date)
                                .isToday
                                : '',
                            icon: Icons.calendar_today_sharp,
                            bgIcon: Colors.red,
                            switchValue: state.hasDate,
                            switchOnChanged: (bool value) {
                              selectDate(context, value);
                              selectTime(context, false);
                              // detailsStream.setTime(
                              //     TimeOfDay.now(), false);
                            },
                            onTapItem: () {
                              if (state.hasDate) {
                                selectDate(context, state.hasDate);
                              }
                            },
                          ),
                          DetailsItem(
                            title: DetailConstants.timeTxt,
                            subtitle: (state.hasDate && state.hasTime)
                                ? DateTime.fromMillisecondsSinceEpoch(
                                state.date + state.time)
                                .hourHHmm
                                : '',
                            icon: Icons.timer,
                            bgIcon: Colors.blue,
                            switchValue: state.hasTime,
                            switchOnChanged: (bool value) {
                              if (state.hasDate)
                                selectTime(context, value);
                              else {
                                selectDate(context, value);
                                // selectTime(context, value);
                              }
                            },
                            onTapItem: () {
                              if (state.hasDate && state.hasTime)
                                selectTime(context, state.hasTime);
                              /* else if(state.hasDate == false )
                                  {
                                    selectDate(context, state.hasDate); selectTime(context, state.hasTime);
                                  }*/
                            },
                          ),
                        ]),
                  ),
                  Container(
                    margin: EdgeInsets.all(
                      DetailConstants.marginHorizontal,
                    ),
                    padding: EdgeInsets.all(ScreenUtil().setWidth(7)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (dialogContext) =>
                                priorityDialog(context));
                        //PriorityDialog(detailsStream: detailsStream, selectedPriority: selectedPriority, context1: context,));
                      },
                      child: Padding(
                        padding:
                        EdgeInsets.all(ScreenUtil().setHeight(8.0)),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 9,
                              child: Text(DetailConstants.priorityTxt,
                                  style: ThemeText.title2),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                  getPriorityTypeText(state.priority),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(12.5),
                                    color: Colors.grey,
                                  )),
                            ),
                            Expanded(
                                flex: 1,
                                child: HomePageConstant.iconArrow),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]));
          },
        );
  }

  String getPriorityTypeText(int intPriority) {
    switch (intPriority) {
      case 1:
        return priorityTypeUtil(PriorityType.LOW);
      case 2:
        return priorityTypeUtil(PriorityType.MEDIUM);
      case 3:
        return priorityTypeUtil(PriorityType.HIGH);
      default:
        return priorityTypeUtil(PriorityType.NONE);
    }
  }

  Widget priorityDialog(BuildContext context) {
    return SimpleDialog(
      titlePadding: EdgeInsets.only(
        top: ScreenUtil().setHeight(15),
        left: ScreenUtil().setWidth(15),
      ),
      contentPadding: EdgeInsets.zero,
      title: Text(
        DetailConstants.priorityTxt,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            fontWeight: FontWeight.w700,
            color: Colors.black),
      ),
      children: [
        PriorityItemWidget(
          name: priorityTypeUtil(PriorityType.NONE),
          color: Colors.grey,
          onTap: () => {
            BlocProvider.of<AddDetailsBloc>(context)
                .add(SetPriorityEvent(priority: 0)),
            Navigator.pop(context),
            priority=0,
         //   selectedPriority = priorityTypeUtil(PriorityType.NONE),
            // log(selectedPriority)
          },
          isNotLast: true,
        ),
        PriorityItemWidget(
            name: priorityTypeUtil(PriorityType.LOW),
            color: Colors.yellow,
            onTap: () => {
                  BlocProvider.of<AddDetailsBloc>(context)
                      .add(SetPriorityEvent(priority: 1)),
                  Navigator.pop(context),
              priority=1,
                  selectedPriority = priorityTypeUtil(PriorityType.LOW),
                  // log(selectedPriority)
                },
            isNotLast: true),
        PriorityItemWidget(
            name: priorityTypeUtil(PriorityType.MEDIUM),
            color: Colors.orange,
            onTap: () => {
                  BlocProvider.of<AddDetailsBloc>(context)
                      .add(SetPriorityEvent(priority: 2)),
                  Navigator.pop(context),
              priority=2,
                   selectedPriority = priorityTypeUtil(PriorityType.MEDIUM),
                  // log(selectedPriority)
                },
            isNotLast: true),
        PriorityItemWidget(
            name: priorityTypeUtil(PriorityType.HIGH),
            color: Colors.red,
            onTap: () => {
                  BlocProvider.of<AddDetailsBloc>(context)
                      .add(SetPriorityEvent(priority: 3)),
                  Navigator.pop(context),
              priority=3,
                   selectedPriority = priorityTypeUtil(PriorityType.HIGH),
                  // log(selectedPriority)
                },
            isNotLast: false),
      ],
    );
  }

  void selectTime(BuildContext context, bool hasTime) async {
    if (hasTime) {
      final TimeOfDay newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (newTime != null) {
        time = (newTime.hour * 60 * 60 + newTime.minute * 60) * 1000 + 1;
        BlocProvider.of<AddDetailsBloc>(context)
            .add(SetTimeEvent(hasTime: hasTime, time: time));
      }
    } else {
      time = 0;
      BlocProvider.of<AddDetailsBloc>(context)
          .add(SetTimeEvent(hasTime: false, time: 0));
    }
  }

  void selectDate(BuildContext context, bool hasDate) async {
    if (hasDate) {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null) {
        date = DateTime.parse(DateFormat('yyyy-MM-dd').format(picked))
            .millisecondsSinceEpoch;
        BlocProvider.of<AddDetailsBloc>(context)
            .add(SetDateEvent(hasDate: hasDate, date: date));
      }
    } else {
      date = 0;
      BlocProvider.of<AddDetailsBloc>(context)
          .add(SetDateEvent(hasDate: hasDate, date: 0));
    }
  }

  Widget _appBar(BuildContext context, AddDetailsState addDetailsState) {
    return AppbarWidget(
      context,
      leadingText: NewReminderConstants.newReminderTxt,
      title: NewReminderConstants.detailTxt,
      actionText: DetailConstants.saveTxt,
      onTapAction: GestureDetector(
        onTap: () => {
          Navigator.pop(
              context,
              ({
                'date': addDetailsState.date,
                'time': addDetailsState.time,
                'priority': addDetailsState.priority
              })),
        },
        child: Container(
          //color: Colors.blue,
          width: ScreenUtil().screenWidth / 6,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Save',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      onTapCancel: () => {
        log('cancel'),
        Navigator.pop(context),
      },
    );
  }
}