import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:reminders_app/common/constants/color_constants.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/list/bloc/list_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/list/bloc/list_event.dart';
import 'package:reminders_app/reminders_app/theme/theme.dart';
import '../../../../../common/constants/route_constants.dart';
import 'bloc/list_state.dart';
import 'bloc/list_stream.dart';
import '../../reminder/reminders_constants.dart';
import '../../../../widgets_constants/appbar_for_list_screen.dart';
import '../../../../widgets_constants/confirm_dialog.dart';
import '../../../../widgets_constants/icon_slide_widget.dart';
import '../../reminders_list.dart';

import '../../../../../common/extensions/date_extensions.dart';

class ListScreen extends StatefulWidget {
  int index;

  ListScreen(this.index);

  @override
  State<StatefulWidget> createState() => _ListScreen(this.index);
}

class _ListScreen extends State<ListScreen> {
  _ListScreen(this.index);

  int index;
  int id;
  String now = DateTime.now().dateDdMMyyyy;

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppbarWidgetForListScreen(context, () {
                Navigator.pushNamed(context, RouteList.createNewScreen)
                    .whenComplete(() async => await BlocProvider.of<ListBloc>(context).add(UpdateListEvent(index: index)));
              }),
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(20)),
                      child: Text(
                        state.list.name??'',
                        style: ThemeText.headlineListScreen.copyWith(
                          color:ColorConstants.colorMap[ state.list.color],
                        ),
                      ),
                    ),
                    state.reminderList.length != 0
                        ? listWidget(state:state,context: context)
                        : Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().screenHeight / 2 - 100),
                            child: Align(
                                alignment: Alignment.center,
                                child: RemindersConstants.noReminders),
                          )
                  ]));
        });
  }



  Widget listWidget( { BuildContext context,ListState state}) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(
              bottom: ScreenUtil().setHeight(12),
              right: ScreenUtil().setWidth(12),
              left: ScreenUtil().setWidth(20),
            ),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.reminderList.length,
                itemBuilder: (context, index1) {
                  String time = DateTime.fromMillisecondsSinceEpoch(
                          state.reminderList[index1].dateAndTime)
                      .hourHHmm;
                  String date = DateTime.fromMillisecondsSinceEpoch(
                          state.reminderList[index1].dateAndTime)
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
                              builder: (_) => ConfirmDialog(      confirmText: 'Delete',
                                content:
                                    'Are you sure you want to delete this reminder ?',
                                title: 'Delete ?',
                                onPressedCancel: () {
                                  Navigator.pop(context);
                                },
                                onPressedOk: () => deleteReminder(index1,state),
                              ),
                            )
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
                                        state.reminderList[index1].priority),
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
                                              state.reminderList[index1].title,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 5,
                                              softWrap: false,
                                              style: ThemeText.title),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(3)),
                                          child: Container(
                                            width:
                                                ScreenUtil().screenWidth - 85,
                                            child: Text(
                                                getDetails(index1, date, time,state),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 5,
                                                softWrap: false,
                                                style: ThemeText.subtitle),
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

  deleteReminder(int index1,ListState state) {
    String delDate;
    id = state.reminderList[index1].id;
    BlocProvider.of<ListBloc>(context).add(DeleteReminderInListScreenEvent(id: id));
    BlocProvider.of<ListBloc>(context).add(UpdateListEvent(index: index));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted')));
     Navigator.pop(context);
  }

  String getDetails(int index1, String date, String time,ListState state) {
    return state.reminderList[index1].dateAndTime != 0
        ? ((state.reminderList[index1].dateAndTime % 10 == 1)
            ? '${date == now ? 'Today' : date}, ${time} \n${state.reminderList[index1].notes}'
            : '${date == now ? 'Today' : date}\n${state.reminderList[index1].notes}')
        : '${state.reminderList[index1].notes}';
  }
}
