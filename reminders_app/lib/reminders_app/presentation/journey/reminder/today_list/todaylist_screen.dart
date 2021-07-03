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
import 'package:reminders_app/reminders_app/presentation/journey/reminder/today_list/bloc/today_list_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/today_list/bloc/today_list_event.dart';
import 'package:reminders_app/reminders_app/theme/theme.dart';
import '../../../../../common/constants/route_constants.dart';
import '../reminders_constants.dart';
import '../../../../../common/extensions/date_extensions.dart';
import '../../../../widgets_constants/appbar_for_list_screen.dart';
import '../../../../widgets_constants/confirm_dialog.dart';
import '../../../../widgets_constants/icon_slide_widget.dart';
import 'bloc/today_list_state.dart';

class TodayList extends StatelessWidget {
  var isUpdated;
  String now = DateTime.now().dateDdMMyyyy;
  SlidableController slidableController = SlidableController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayListBloc, TodayListState>(
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
                RemindersConstants.todayTxt,
                style: ThemeText.headlineListScreen,
              ),
            ),
            (state.todayList == null || state.todayList.length == 0)
                ? Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().screenHeight / 2 - 100),
                    child: Align(
                        alignment: Alignment.center,
                        child: RemindersConstants.noReminders),
                  )
                : todayListWidget(state, context)
          ]));
    });
  }

  Widget todayListWidget(
    TodayListState state,
    BuildContext context,
  ) {
    int id;
    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(
              bottom: ScreenUtil().setHeight(12),
              right: ScreenUtil().setWidth(12),
              left: ScreenUtil().setWidth(20),
            ),
            child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.todayList.length, //  state.todayList.length,
                itemBuilder: (context, index) {
                  String time = DateFormat('HH:mm').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          state.todayList[index].dateAndTime));
                  String date = DateFormat('dd/MM/yyyy').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          state.todayList[index].dateAndTime));
                  return Slidable(
                      key: Key(state.todayList[index].id.toString()),
                      controller: slidableController,
                      closeOnScroll: true,
                      actionPane: SlidableDrawerActionPane(),
                      secondaryActions: [
                        IconSlideWidget.edit(() async {
                          int dateInt = DateTime.parse(DateFormat('yyyy-MM-dd')
                                  .format(DateTime.fromMillisecondsSinceEpoch(
                                      state.todayList[index].dateAndTime)))
                              .millisecondsSinceEpoch;
                          int timeInt =
                              state.todayList[index].dateAndTime - dateInt;
                          log((state.todayList[index].dateAndTime).toString());
                          log(dateInt.toString());
                          log(timeInt.toString());
                          isUpdated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider<
                                          EditReminderBloc>(
                                      create: (context) => locator<
                                          EditReminderBloc>()
                                        ..add(SetInfoEvent(
                                          id: state.todayList[index].id,
                                          title: state.todayList[index].title,
                                          notes: state.todayList[index].notes,
                                          list: state.todayList[index].list,
                                          date: state.todayList[index]
                                                      .dateAndTime >
                                                  0
                                              ? dateInt
                                              : 0,
                                          time: timeInt == 0 ? 0 : timeInt - 1,
                                          priority:
                                              state.todayList[index].priority,
                                          createAt:
                                              state.todayList[index].createAt,
                                        ))
                                        ..add(GetAllGroupEventInEditScreen()),
                                      child: EditReminderScreen())));
                          if (isUpdated)
                            BlocProvider.of<TodayListBloc>(context)
                                .add(UpdateTodayListEvent(isUpdated: true));
                        }),
                        IconSlideWidget.delete(
                          () => {
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
                                      onPressedOk: () => deleteReminder(
                                          context, state, now, index),
                                    )),
                          },
                        )
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
                                    color: RemindersConstants.getPriorityColor(
                                        state.todayList[index].priority),
                                  ),
                                ),
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
                                            state.todayList[index].title,
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
                                        getDetails(state, index, time) == null
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
                                                        state, index, time),
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

  String getDetails(TodayListState state, int index, String time) {
    if (state.todayList[index].dateAndTime % 10 == 1) {
      if (state.todayList[index].notes != '') {
        return '${time} \n${state.todayList[index].notes}';
      } else {
        return '${time}';
      }
    } else {
      if (state.todayList[index].notes != '') {
        return '${state.todayList[index].notes}';
      } else {
        return null;
      }
    }
  }

  void deleteReminder(
      BuildContext context, TodayListState state, String now, int index) {
    int id = state.todayList[index].id;
    BlocProvider.of<TodayListBloc>(context)
      ..add(DeleteReminderInTodayScreenEvent(id: id))
      ..add(UpdateTodayListEvent(isUpdated: true));
    Navigator.pop(context);
  }

  Widget _appbar(
      {@required BuildContext context, @required TodayListState state}) {
    return AppbarWidgetForListScreen(
        context: context,
        onTapCreateNew: () async {
          isUpdated =
              await Navigator.pushNamed(context, RouteList.createNewScreen);
          if (isUpdated) {
            BlocProvider.of<TodayListBloc>(context)
                .add(UpdateTodayListEvent(isUpdated: true));
          }
        },
        onTapCancel: () {
          log(state.isUpdated.toString());
          Navigator.pop(context, state.isUpdated);
        });
  }
}
