import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:reminders_app/reminders_app/presentation/journey/home_page/bloc/homepage_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/all_reminders/bloc/all_list_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/scheduled_list/bloc/scheduled_list_event.dart';
import 'package:reminders_app/reminders_app/theme/theme.dart';
import '../../../../../common/constants/route_constants.dart';
import '../reminders_constants.dart';
import '../../../../widgets_constants/appbar_for_list_screen.dart';
import '../../../../widgets_constants/confirm_dialog.dart';
import '../../../../widgets_constants/icon_slide_widget.dart';
import 'bloc/scheduled_list_bloc.dart';
import 'bloc/scheduled_list_state.dart';
import 'bloc/scheduled_list_stream.dart';
import '../../reminders_list.dart';
import '../../../../../common/extensions/date_extensions.dart';

class ScheduledList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScheduledList();
}

class _ScheduledList extends State<ScheduledList> {
  int id;
  String now = DateTime.now().dateDdMMyyyy; 
  @override
  void dispose() { 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduledRemindersBloc,ScheduledRemindersState>(
        builder: (context,state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppbarWidgetForListScreen(context, () {
                Navigator.pushNamed(context, RouteList.createNewScreen)
                    .whenComplete(() =>
                    BlocProvider.of<ScheduledRemindersBloc>(context).add(
                        UpdateScheduledEvent()));
              }
                ,),
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(20)),
                      child: Text(
                        RemindersConstants.scheduledTxt,
                        style: ThemeText.headlineListScreen
                            .copyWith(color: Colors.red),
                      ),
                    ),
                    (state.dateList.length == 0 || state.dateList.length == null)
                        ? Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().screenHeight / 2 - 100),
                      child: Align(
                          alignment: Alignment.center,
                          child: RemindersConstants.noReminders),
                    )
                        : scheduledListWidget(state),
                  ]));
        }
    );
  }

  Widget scheduledListWidget(ScheduledRemindersState scheduledListState)
  {
    return  Expanded(
        child: Padding(
            padding: EdgeInsets.only(
              bottom: ScreenUtil().setHeight(12),
              right: ScreenUtil().setWidth(12),
              left: ScreenUtil().setWidth(20),
            ),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:
                scheduledListState.dateList.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil()
                              .setHeight(10),
                          left: ScreenUtil()
                              .setWidth(20)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            scheduledListState.dateList[
                            index] ==
                                now
                                ? 'Today'
                                : scheduledListState
                                .dateList[index],
                            style: ThemeText
                                .headline2ListScreen),
                      ),
                    ),
                    getReminderOfDay(scheduledListState, index),
                  ]);
                })));
  }
  Widget getReminderOfDay(ScheduledRemindersState scheduledListState, int index) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: scheduledListState
            .scheduledList[scheduledListState.dateList[index]].length,
        itemBuilder: (context, index1) {
          String time = DateTime.fromMillisecondsSinceEpoch(scheduledListState
                  .scheduledList[scheduledListState.dateList[index]][index1]
                  .dateAndTime)
              .hourHHmm;
          String date = DateTime.fromMillisecondsSinceEpoch(scheduledListState
                  .scheduledList[scheduledListState.dateList[index]][index1]
                  .dateAndTime)
              .dateDdMMyyyy;
          //  log(index1.toString()+'}}}}}}}}}}}}');
          return Slidable(
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: [
                IconSlideWidget.edit(),
                IconSlideWidget.delete(() => {
                      showDialog(
                        context: context,
                        builder: (_) => ConfirmDialog(      confirmText: 'Delete',
                            content:
                                'Are you sure you want to delete this reminder ?',
                            title: 'Delete ?',
                            onPressedCancel: () {
                              Navigator.pop(context);
                            },
                            onPressedOk: () => deleteReminder(
                                scheduledListState, index, index1)),
                      )
                    })
              ],
              actionExtentRatio: 0.2,
              child: Container(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: ScreenUtil().setHeight(15),
                          height: ScreenUtil().setHeight(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: RemindersConstants.getPriorityColor(
                                RemindersList.allReminders[scheduledListState
                                    .dateList[index]][index1]
                                    .priority),
                                /*scheduledListState
                                    .scheduledList[scheduledListState
                                        .dateList[index]][index1]
                                    .priority),*/
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: ScreenUtil().screenWidth - 85,
                                  child: Text(
                                      RemindersList.allReminders[scheduledListState
                                      .dateList[index]][index1]
                                      .title,
                                  //  scheduledListState
                                     /*   .scheduledList[scheduledListState
                                            .dateList[index]][index1]
                                        .title,*/
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: ScreenUtil().setSp(17)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(3)),
                                  child: Container(
                                    width: ScreenUtil().screenWidth - 85,
                                    child: Text(
                                      getDetails(scheduledListState, index,
                                          index1, time),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      softWrap: false,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                          fontSize: ScreenUtil().setSp(12)),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(10)),
                                  color: Colors.grey,
                                  height: ScreenUtil().setHeight(0.5),
                                  width: ScreenUtil().screenWidth - 85,
                                )
                              ]),
                        )
                      ])));
        });
  }

  void deleteReminder(
      ScheduledRemindersState scheduledListState, int index, int index1) {
    id = scheduledListState
        .scheduledList[scheduledListState.dateList[index]][index1].id;
    RemindersList.allReminders[scheduledListState.dateList[index]]
        .removeAt(index1);
    if (RemindersList.allReminders[scheduledListState.dateList[index]].length ==
        0) {
      RemindersList.allReminders.remove(scheduledListState.dateList[index]);
    }
    ;
    for (int i = 0; i < RemindersList.MyLists.length; i++) {
      for (int j = 0; j < RemindersList.MyLists[i].list.length; j++) {
        if (RemindersList.MyLists[i].list[j].id == id) {
          RemindersList.MyLists[i].list.removeAt(j);
          j--;
        }
      }
      ;
    }
    ;
    index1--;
    BlocProvider.of<ScheduledRemindersBloc>(context).add(UpdateScheduledEvent());
    Navigator.pop(context);
  }

  String getDetails(ScheduledRemindersState scheduledListState, int index,
      int index1, String time) {
    return (scheduledListState
                    .scheduledList[scheduledListState.dateList[index]][index1]
                    .dateAndTime %
                10 ==
            1)
        ? '${time} \n${scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].notes}'
        : '${scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].notes}';
  }
}
