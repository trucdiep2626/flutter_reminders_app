import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:reminders_app/common/constants/color_constants.dart';
import 'package:reminders_app/reminders_app/theme/theme.dart';
import '../../../../../common/constants/route_constants.dart';
import 'bloc/all_list_bloc.dart';
import 'bloc/all_list_event.dart';
import 'bloc/all_list_state.dart';
import '../reminders_constants.dart';
import '../../../../widgets_constants/appbar_for_list_screen.dart';
import '../../../../widgets_constants/confirm_dialog.dart';
import '../../../../widgets_constants/icon_slide_widget.dart';
import 'bloc/all_list_stream.dart';
import '../../reminders_list.dart';

import '../../../../../common/extensions/date_extensions.dart';

class AllRemindersList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AllRemindersList();
}

class _AllRemindersList extends State<AllRemindersList> {
  String now = DateTime.now().dateDdMMyyyy;
 

  @override
  void dispose() { 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    int id;
    return BlocBuilder<AllRemindersBloc, AllRemindersState>(
        builder: (context, state) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppbarWidgetForListScreen(
            context,
            () {
              Navigator.pushNamed(context, RouteList.createNewScreen)
                  .whenComplete(
                () async => await BlocProvider.of<AllRemindersBloc>(context)
                    .add(UpdateAllListEvent( )),
              );
            },
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10),
                  left: ScreenUtil().setWidth(20)),
              child: Text(RemindersConstants.allTxt,
                  style: ThemeText.headlineListScreen
                      .copyWith(color: Colors.black)),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(
                bottom: ScreenUtil().setHeight(12),
                right: ScreenUtil().setWidth(12),
                left: ScreenUtil().setWidth(20),
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.myLists.length,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            state.myLists[index].name,
                            style: ThemeText.headline2ListScreen.copyWith(
                                color:    ColorConstants.colorMap[state.myLists[index].color]),
                          ),
                        ),
                      ),
                      state.remindersOfList[state.myLists[index].name].length == 0
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(20),
                                  bottom: ScreenUtil().setHeight(20)),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: RemindersConstants.noReminders),
                            )
                          : getReminderOfList(index, state)
                    ]);
                  }),
            ))
          ]));
    });
  }

  Widget getReminderOfList(int index, AllRemindersState state) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: state.remindersOfList[state.myLists[index].name].length,
        itemBuilder: (context, index1) {
          String time = (DateTime.fromMillisecondsSinceEpoch(
              state.remindersOfList[state.myLists[index].name][index1].dateAndTime)
              .hourHHmm);
          String date = DateTime.fromMillisecondsSinceEpoch(
              state.remindersOfList[state.myLists[index].name][index1].dateAndTime)
              .dateDdMMyyyy;
          return Slidable(
              closeOnScroll: true,
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: [
                IconSlideWidget.edit(),
                IconSlideWidget.delete(
                  () => {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => ConfirmDialog(
                          confirmText: 'Delete',
                          content:
                              'Are you sure you want to delete this reminder ?',
                          title: 'Delete ?',
                          onPressedCancel: () {
                            Navigator.pop(context);
                          },
                          onPressedOk: () =>
                              _deleteReminder(index, index1, state)),
                    )
                  },
                )
              ],
              actionExtentRatio: 0.2,
              child: Container(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 15.h,
                          height: 15.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: RemindersConstants.getPriorityColor(
                                state.remindersOfList[state.myLists[index].name][index1].priority),
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
                                      state.remindersOfList[state.myLists[index].name][index1].title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      softWrap: false,
                                      style: ThemeText.title),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(3)),
                                  child: Container(
                                    width: ScreenUtil().screenWidth - 85,
                                    child: Text(
                                      getDetails(
                                          index, index1, date, time, state),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      softWrap: false,
                                      style: ThemeText.subtitle,
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

  String getDetails(int index, int index1, String date, String time,
      AllRemindersState state) {
    return state.remindersOfList[state.myLists[index].name][index1].dateAndTime != 0
        ? ((state.remindersOfList[state.myLists[index].name][index1].dateAndTime % 10 == 1)
            ? '${date == now ? 'Today' : date}, ${time} \n${state.remindersOfList[state.myLists[index].name][index1].notes}'
            : '${date == now ? 'Today' : date}\n${state.remindersOfList[state.myLists[index].name][index1].notes}')
        : '${state.remindersOfList[state.myLists[index].name][index1].notes}';
  }

  void _deleteReminder(int index, int index1, AllRemindersState state) {
    String delDate;
    int id = state.remindersOfList[state.myLists[index].name][index1].id;


    BlocProvider.of<AllRemindersBloc>(context)
        .add(UpdateAllListEvent(  ));
    Navigator.pop(context);
  }
}
