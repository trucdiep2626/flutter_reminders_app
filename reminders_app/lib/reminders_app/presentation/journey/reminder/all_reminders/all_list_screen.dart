import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:reminders_app/common/constants/color_constants.dart';
import 'package:reminders_app/common/injector.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/edit_reminder/bloc/edit_reminder_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/edit_reminder/bloc/edit_reminder_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/edit_reminder/edit_reminder_screen.dart';
import 'package:reminders_app/reminders_app/theme/theme.dart';
import 'package:reminders_app/reminders_app/widgets_constants/flash_message.dart';
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

class AllRemindersList extends StatelessWidget {
  var isUpdated;
  String now = DateTime.now().dateDdMMyyyy;
  final SlidableController slidableController =  SlidableController();
  @override
  Widget build(BuildContext context) {
    int id;
    return BlocBuilder<AllRemindersBloc, AllRemindersState>(
        builder: (context, state) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: _appbar(context: context, state: state),
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
                  //   physics: NeverScrollableScrollPhysics(),
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
                                color: ColorConstants
                                    .colorMap[state.myLists[index].color]),
                          ),
                        ),
                      ),
                      state.remindersOfList[state.myLists[index].name].length ==
                              0
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
       physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.remindersOfList[state.myLists[index].name].length,
        itemBuilder: (context, index1) {
          String time = (DateTime.fromMillisecondsSinceEpoch(state
                  .remindersOfList[state.myLists[index].name][index1]
                  .dateAndTime)
              .hourHHmm);
          String date = DateTime.fromMillisecondsSinceEpoch(state
                  .remindersOfList[state.myLists[index].name][index1]
                  .dateAndTime)
              .dateDdMMyyyy;
          return Slidable(
              key:   Key(state.remindersOfList[state.myLists[index].name][index1].id.toString()),
              controller: slidableController,
        //   movementDuration: Duration(seconds: 1),
              closeOnScroll: true,
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: [
                IconSlideWidget.edit(
                        ()async{
                      int dateInt = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(state.remindersOfList[state.myLists[index].name][index1].dateAndTime)))
                          .millisecondsSinceEpoch;
                      int timeInt = state.remindersOfList[state.myLists[index].name][index1].dateAndTime-dateInt;

                      isUpdated = await Navigator.push(context,  MaterialPageRoute(
                          builder: (context) =>  BlocProvider<EditReminderBloc>(
                              create: (context) => locator<EditReminderBloc>()
                                ..add(SetInfoEvent(   id:state.remindersOfList[state.myLists[index].name][index1].id ,
                                  title: state.remindersOfList[state.myLists[index].name][index1].title,
                                  notes: state.remindersOfList[state.myLists[index].name][index1].notes,
                                  list: state.remindersOfList[state.myLists[index].name][index1].list,
                                  date:state.remindersOfList[state.myLists[index].name][index1].dateAndTime>0?dateInt:0,
                                  time:  timeInt==0?0:timeInt-1,
                                  priority: state.remindersOfList[state.myLists[index].name][index1].priority,
                                  createAt: state.remindersOfList[state.myLists[index].name][index1].createAt,))
                                ..add(GetAllGroupEventInEditScreen()), child:EditReminderScreen(

                          ))));
                      if(isUpdated )
                        BlocProvider.of<AllRemindersBloc>(context).add(UpdateAllListEvent(isUpdated: true));
                    }
                ),
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
                          onPressedOk: () => _deleteReminder(
                              index: index,
                              index1: index1,
                              state: state,
                              context: context)),
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
                            color: RemindersConstants.getPriorityColor(state
                                .remindersOfList[state.myLists[index].name]
                                    [index1]
                                .priority),
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
                                      state
                                          .remindersOfList[
                                              state.myLists[index].name][index1]
                                          .title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      softWrap: false,
                                      style: ThemeText.title),
                                ),
                                getDetails(index, index1, date, time, state) ==
                                        null
                                    ? SizedBox()
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(3)),
                                        child: Container(
                                          width: ScreenUtil().screenWidth - 85,
                                          child: Text(
                                            getDetails(index, index1, date,
                                                time, state),
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
    if (state.remindersOfList[state.myLists[index].name][index1].notes != '') {
      if (state
              .remindersOfList[state.myLists[index].name][index1].dateAndTime !=
          0) {
        if (state.remindersOfList[state.myLists[index].name][index1]
                    .dateAndTime %
                10 ==
            1) {
          return '${date == now ? 'Today' : date}, ${time} \n${state.remindersOfList[state.myLists[index].name][index1].notes}';
        } else {
          return '${date == now ? 'Today' : date}\n${state.remindersOfList[state.myLists[index].name][index1].notes}';
        }
      } else {
        return '${state.remindersOfList[state.myLists[index].name][index1].notes}';
      }
    } else {
      if (state
              .remindersOfList[state.myLists[index].name][index1].dateAndTime !=
          0) {
        if (state.remindersOfList[state.myLists[index].name][index1]
                    .dateAndTime %
                10 ==
            1) {
          return '${date == now ? 'Today' : date}, ${time}';
        } else {
          return '${date == now ? 'Today' : date}';
        }
      } else
        return null;
    }
  }

  void _deleteReminder(
      {int index, int index1, AllRemindersState state, BuildContext context}) {
    int id = state.remindersOfList[state.myLists[index].name][index1].id;
    BlocProvider.of<AllRemindersBloc>(context)
      ..add(DeleteReminderInAllScreenEvent(id: id))
      ..add(UpdateAllListEvent(isUpdated: true));
    ScaffoldMessenger.of(context).showSnackBar(FlashMessage(type: 'Success'));
    Navigator.pop(context);
  }

  Widget _appbar(
      {@required BuildContext context, @required AllRemindersState state}) {
    return AppbarWidgetForListScreen(
        context: context,
        onTapCreateNew: () async {
          isUpdated =
              await Navigator.pushNamed(context, RouteList.createNewScreen);

          if (isUpdated) {
            BlocProvider.of<AllRemindersBloc>(context)
                .add(UpdateAllListEvent(isUpdated: true));
          }
        },
        onTapCancel: () {
          Navigator.pop(context, state.isUpdated);
        });
  }
}
