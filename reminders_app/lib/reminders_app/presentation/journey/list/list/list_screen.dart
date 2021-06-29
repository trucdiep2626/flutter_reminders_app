import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:reminders_app/common/constants/color_constants.dart';
import 'package:reminders_app/common/injector.dart';
import 'package:reminders_app/reminders_app/domain/entities/reminder.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/list/bloc/list_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/list/bloc/list_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/new_reminder/create_new_reminder/bloc/new_reminder_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/new_reminder/create_new_reminder/bloc/new_reminder_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/new_reminder/create_new_reminder/create_new_reminder.dart';
import 'package:reminders_app/reminders_app/theme/theme.dart';
import 'package:reminders_app/reminders_app/widgets_constants/flash_message.dart';
import '../../../../../common/constants/route_constants.dart';
import 'bloc/list_state.dart';
import 'bloc/list_stream.dart';
import '../../reminder/reminders_constants.dart';
import '../../../../widgets_constants/appbar_for_list_screen.dart';
import '../../../../widgets_constants/confirm_dialog.dart';
import '../../../../widgets_constants/icon_slide_widget.dart';
import '../../reminders_list.dart';

import '../../../../../common/extensions/date_extensions.dart';

class ListScreen extends StatelessWidget {
  int index;
  int id;
  var isUpdated;
  String now = DateTime.now().dateDdMMyyyy;
  final SlidableController slidableController =   SlidableController();
  ListScreen(this.index);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(builder: (context, state) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: _appbar(context: context, state: state),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10),
                  left: ScreenUtil().setWidth(20)),
              child: Text(
                state.list.name ?? '',
                style: ThemeText.headlineListScreen.copyWith(
                  color: ColorConstants.colorMap[state.list.color],
                ),
              ),
            ),
            state.reminderList.length != 0
                ? listWidget(state: state, context: context)
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

  Widget listWidget({BuildContext context, ListState state}) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(
              bottom: ScreenUtil().setHeight(12),
              right: ScreenUtil().setWidth(12),
              left: ScreenUtil().setWidth(20),
            ),
            child: ListView.builder(
             //   physics: NeverScrollableScrollPhysics(),
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
                    key: Key(state.reminderList[index1].id.toString()),
                      controller: slidableController,
                      closeOnScroll: true,
                      actionPane: SlidableDrawerActionPane(),
                      secondaryActions: [
                        IconSlideWidget.edit(),
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
                                    index1: index1,
                                    state: state,
                                    context: context),
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
                                        getDetails(
                                            index1, date, time, state)==null? SizedBox(): Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(3)),
                                          child: Container(
                                            width:
                                                ScreenUtil().screenWidth - 85,
                                            child: Text(
                                                getDetails(
                                                    index1, date, time, state),
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

  deleteReminder(
      {@required int index1,
      @required ListState state,
      @required BuildContext context}) {
    id = state.reminderList[index1].id;
    BlocProvider.of<ListBloc>(context)
      ..add(DeleteReminderInListScreenEvent(id: id))
      ..add(UpdateListEvent(index: index, isUpdated: true));
    ScaffoldMessenger.of(context).showSnackBar(FlashMessage(type: 'Success'));
    Navigator.pop(context);
  }

  String getDetails(int index1, String date, String time, ListState state) {

    if (state.reminderList[index1].notes != '') {
      if (state
          .reminderList[index1].dateAndTime !=
          0) {
        if (state.reminderList[index1]
            .dateAndTime %
            10 ==
            1) {
          return '${date == now ? 'Today' : date}, ${time} \n${state.reminderList[index1].notes}';
        } else {
          return '${date == now ? 'Today' : date}\n${state.reminderList[index1].notes}';
        }
      } else {
        return '${state.reminderList[index1].notes}';
      }
    } else {
      if (state
          .reminderList[index1].dateAndTime !=
          0) {
        if (state.reminderList[index1]
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


  Widget _appbar({@required BuildContext context, @required ListState state}) {
    return AppbarWidgetForListScreen(
        context: context,
        onTapCreateNew: () async {
          isUpdated =
              await Navigator.pushNamed(context, RouteList.createNewScreen);

          if (isUpdated) {
            await BlocProvider.of<ListBloc>(context)
                .add(UpdateListEvent(index: index, isUpdated: true));
          }
        },
        onTapCancel: () {
          //  log(state.isUpdated.toString());
          Navigator.pop(context, state.isUpdated);
        });
  }
}
