import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:reminders_app/common/injector.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/edit_reminder/bloc/edit_reminder_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/edit_reminder/bloc/edit_reminder_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/edit_reminder/edit_reminder_screen.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/scheduled_list/bloc/scheduled_list_event.dart';
import 'package:reminders_app/reminders_app/theme/theme.dart';
import '../../../../../common/constants/route_constants.dart';
import '../reminders_constants.dart';
import '../../../../widgets_constants/appbar_for_list_screen.dart';
import '../../../../widgets_constants/confirm_dialog.dart';
import '../../../../widgets_constants/icon_slide_widget.dart';
import 'bloc/scheduled_list_bloc.dart';
import 'bloc/scheduled_list_state.dart';
import '../../../../../common/extensions/date_extensions.dart';

class ScheduledList extends StatelessWidget {
  var isUpdated;
  int id;
  String now = DateTime.now().dateDdMMyyyy;
SlidableController slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduledRemindersBloc,ScheduledRemindersState>(
        builder: (context,state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: _appbar(context: context, state: state),
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
        physics: NeverScrollableScrollPhysics(),
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
              key: Key(scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].id.toString()),
              controller: slidableController,
              closeOnScroll: true,
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: [
                IconSlideWidget.edit(
                        ()async{
                      int dateInt = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].dateAndTime)))
                          .millisecondsSinceEpoch;
                      int timeInt = scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].dateAndTime-dateInt;
                      log((scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].dateAndTime).toString());
                      log(dateInt.toString());
                      log(timeInt.toString());
                      isUpdated = await Navigator.push(context,  MaterialPageRoute(
                          builder: (context) =>  BlocProvider<EditReminderBloc>(
                              create: (context) => locator<EditReminderBloc>()..add(GetAllGroupEventInEditScreen()), child:EditReminderScreen(
                            id:scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].id ,
                            title: scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].title,
                            notes: scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].notes,
                            list: scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].list,
                            date:scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].dateAndTime>0?dateInt:0,
                            time:  timeInt==0?0:timeInt-1,
                            priority: scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].priority,
                            createAt: scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].createAt,
                          ))));
                      if(isUpdated )
                        BlocProvider.of<ScheduledRemindersBloc>(context).add(UpdateScheduledEvent(isUpdated: true));
                    }
                ),
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
                                context,scheduledListState, index, index1)),
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
                                scheduledListState
                                    .scheduledList[scheduledListState
                                    .dateList[index]][index1]
                                    .priority)
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
                                      /*RemindersList.allReminders[scheduledListState
                                      .dateList[index]][index1]
                                      .title,*/
                                 scheduledListState
                                      .scheduledList[scheduledListState
                                            .dateList[index]][index1]
                                        .title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: ScreenUtil().setSp(17)),
                                  ),
                                ),
                                getDetails(scheduledListState, index,
                                    index1, time)==null?SizedBox(): Padding(
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

  void deleteReminder(BuildContext context,
      ScheduledRemindersState scheduledListState, int index, int index1) {
    id = scheduledListState
        .scheduledList[scheduledListState.dateList[index]][index1].id;
    BlocProvider.of<ScheduledRemindersBloc>(context)
      ..add(DeleteReminderInScheduledScreenEvent(id:id))
      ..add(UpdateScheduledEvent(isUpdated: true));
    Navigator.pop(context);
  }

  String getDetails(ScheduledRemindersState scheduledListState, int index,
      int index1, String time) {
    if (scheduledListState .scheduledList[scheduledListState.dateList[index]][index1] .dateAndTime % 10 == 1)
      {
        if(scheduledListState .scheduledList[scheduledListState.dateList[index]][index1].notes !='')
          {
            return '${time} \n${scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].notes}';
          }
        else
          return time;
      }
    else
      {
        if(scheduledListState .scheduledList[scheduledListState.dateList[index]][index1].notes !='')
        {
          return '${scheduledListState.scheduledList[scheduledListState.dateList[index]][index1].notes}';
        }
        else
          return null;
      }

  }
  Widget _appbar({@required BuildContext context,@required ScheduledRemindersState state})
  {
    return AppbarWidgetForListScreen(context:context,onTapCreateNew: () async {
      isUpdated = await Navigator.pushNamed(context, RouteList.createNewScreen);

      if(isUpdated)
      {
        BlocProvider.of<ScheduledRemindersBloc>(context).add(UpdateScheduledEvent(isUpdated: true));

      }

    },
        onTapCancel: (){
          log(state.isUpdated.toString());
          Navigator.pop(context,state.isUpdated);});
  }
}
