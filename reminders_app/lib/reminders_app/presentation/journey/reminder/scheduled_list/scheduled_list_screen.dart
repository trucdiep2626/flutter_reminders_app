import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:reminders_app/common/injector.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/edit_reminder/bloc/edit_reminder_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/edit_reminder/bloc/edit_reminder_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/edit_reminder/edit_reminder_screen.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/scheduled_list/bloc/scheduled_list_event.dart';
import 'package:reminders_app/reminders_app/theme/theme.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import '../../../../../common/constants/route_constants.dart';
import '../reminders_constants.dart';
import '../../../../widgets_constants/appbar_for_list_screen.dart';
import '../../../../widgets_constants/confirm_dialog.dart';
import '../../../../widgets_constants/icon_slide_widget.dart';
import 'bloc/scheduled_list_bloc.dart';
import 'bloc/scheduled_list_state.dart';
import '../../../../../common/extensions/date_extensions.dart';
import 'package:grouped_list/grouped_list.dart';

class ScheduledList extends StatelessWidget {
  var isUpdated;
  int id;
  String now = DateTime.now().dateDdMMyyyy;
  SlidableController slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduledRemindersBloc, ScheduledRemindersState>(
        builder: (context, state) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: _appbar(context: context, state: state),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10),
                  left: ScreenUtil().setWidth(20)),
              child: Text(
                RemindersConstants.scheduledTxt,
                style: ThemeText.headlineListScreen.copyWith(color: Colors.red),
              ),
            ),
            (state.scheduledList.length == 0 || state.scheduledList == null)
                ? Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().screenHeight / 2 - 100),
                    child: Align(
                        alignment: Alignment.center,
                        child: RemindersConstants.noReminders),
                  )
                : scheduledListWidget(state),
          ]));
    });
  }

  Widget scheduledListWidget(ScheduledRemindersState scheduledListState) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(
              bottom: ScreenUtil().setHeight(12),
              right: ScreenUtil().setWidth(12),
              left: ScreenUtil().setWidth(20),
            ),
            child: GroupedListView<Reminder, String>(
              semanticChildCount: 0,
              shrinkWrap: true,
                order: GroupedListOrder.ASC,
                stickyHeaderBackgroundColor: Colors.transparent,
                useStickyGroupSeparators: false,
                elements: scheduledListState.scheduledList,
                groupBy: (Reminder element) =>
                    DateTime.fromMillisecondsSinceEpoch(element.dateAndTime)
                        .dateDdMMyyyy,
          //      reverse: true,
                groupSeparatorBuilder: (String value) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(10),
                        left: ScreenUtil().setWidth(20)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(value == now ? 'Today' : value,
                          style: ThemeText.headline2ListScreen),
                    ),
                  );
                },
                itemBuilder: (context, Reminder element) {
                  String time =
                      DateTime.fromMillisecondsSinceEpoch(element.dateAndTime)
                          .hourHHmm;
                  String date =
                      DateTime.fromMillisecondsSinceEpoch(element.dateAndTime)
                          .dateDdMMyyyy;
                  return Slidable(
                      key: Key(element.id.toString()),
                      controller: slidableController,
                      closeOnScroll: true,
                      actionPane: SlidableDrawerActionPane(),
                      secondaryActions: [
                        IconSlideWidget.edit(() async {
                          int dateInt = DateTime.parse(DateFormat('yyyy-MM-dd')
                                  .format(DateTime.fromMillisecondsSinceEpoch(
                                      element.dateAndTime)))
                              .millisecondsSinceEpoch;
                          int timeInt = element.dateAndTime - dateInt;
                          isUpdated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider<
                                          EditReminderBloc>(
                                      create: (context) => locator<
                                          EditReminderBloc>()
                                        ..add(SetInfoEvent(
                                          id: element.id,
                                          title: element.title,
                                          notes: element.notes,
                                          list: element.list,
                                          date: element.dateAndTime > 0
                                              ? dateInt
                                              : 0,
                                          time: timeInt == 0 ? 0 : timeInt - 1,
                                          priority: element.priority,
                                          createAt: element.createAt,
                                        ))
                                        ..add(GetAllGroupEventInEditScreen()),
                                      child: EditReminderScreen())));
                          if (isUpdated)
                            BlocProvider.of<ScheduledRemindersBloc>(context)
                                .add(UpdateScheduledEvent(isUpdated: true));
                        }),
                        IconSlideWidget.delete(() => {
                              showDialog(
                                context: context,
                                builder: (_) => ConfirmDialog(
                                    confirmText: 'Delete',
                                    content:
                                        'Are you sure you want to delete this reminder ?',
                                    title: 'Delete ?',
                                    onPressedCancel: () {
                                      Navigator.pop(context);
                                    },
                                    onPressedOk: () =>
                                        deleteReminder(context, element)),
                              )
                            })
                      ],
                      actionExtentRatio: 0.2,
                      child: Container(
                          padding:
                              EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: ScreenUtil().setHeight(15),
                                    height: ScreenUtil().setHeight(15),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            RemindersConstants.getPriorityColor(
                                                element.priority))),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(20)),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: ScreenUtil().screenWidth - 85,
                                          child: Text(
                                            element.title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontSize:
                                                    ScreenUtil().setSp(17)),
                                          ),
                                        ),
                                        getDetails(scheduledListState, time,
                                                    element) ==
                                                null
                                            ? SizedBox()
                                            : Padding(
                                                padding: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setHeight(3)),
                                                child: Container(
                                                  width:
                                                      ScreenUtil().screenWidth -
                                                          85,
                                                  child: Text(
                                                    getDetails(
                                                        scheduledListState,
                                                        time,
                                                        element),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 5,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey,
                                                        fontSize: ScreenUtil()
                                                            .setSp(12)),
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
                })));
  }

  void deleteReminder(
    BuildContext context,
    Reminder reminder,
  ) {
    id = reminder.id;
    BlocProvider.of<ScheduledRemindersBloc>(context)
      ..add(DeleteReminderInScheduledScreenEvent(id: id))
      ..add(UpdateScheduledEvent(isUpdated: true));
    Navigator.pop(context);
  }

  String getDetails(ScheduledRemindersState scheduledListState, String time,
      Reminder reminder) {
    if (reminder.dateAndTime % 10 == 1) {
      if (reminder.notes != '') {
        return '${time} \n${reminder.notes}';
      } else
        return time;
    } else {
      if (reminder.notes != '') {
        return '${reminder.notes}';
      } else
        return null;
    }
  }

  Widget _appbar(
      {@required BuildContext context,
      @required ScheduledRemindersState state}) {
    return AppbarWidgetForListScreen(
        context: context,
        onTapCreateNew: () async {
          isUpdated =
              await Navigator.pushNamed(context, RouteList.createNewScreen);

          if (isUpdated) {
            BlocProvider.of<ScheduledRemindersBloc>(context)
                .add(UpdateScheduledEvent(isUpdated: true));
          }
        },
        onTapCancel: () {
          log(state.isUpdated.toString());
          Navigator.pop(context, state.isUpdated);
        });
  }
}
