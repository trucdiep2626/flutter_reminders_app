import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:intl/intl.dart';
import 'package:reminders_app/common/constants/color_constants.dart';
import 'package:reminders_app/common/enums/priority_type.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/common/utils/priority_type_utils.dart';
import 'package:reminders_app/reminders_app/presentation/journey/home_page/homepage_constants.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/new_reminder/create_new_reminder/widget/container_button_widget.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/new_reminder/create_new_reminder/widget/list_dialog_item.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/new_reminder/create_new_reminder/widget/reminder_form_widget.dart';
 
import 'package:reminders_app/reminders_app/presentation/journey/reminder/new_reminder/details/details_constants.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/new_reminder/details/widget/details_item.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/new_reminder/details/widget/priority_item.dart';
import 'package:reminders_app/reminders_app/theme/theme.dart';
import 'package:reminders_app/reminders_app/widgets_constants/appbar.dart';
import 'package:reminders_app/reminders_app/widgets_constants/flash_message.dart';
import '../../../../../../common/extensions/date_extensions.dart';
import 'bloc/edit_reminder_bloc.dart';
import 'bloc/edit_reminder_event.dart';
import 'bloc/edit_reminder_state.dart';
class EditReminderScreen extends StatelessWidget{
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer <EditReminderBloc,EditReminderState>(
        listener: (context,state){
          if(state.viewState==ViewState.success)
          {
            ScaffoldMessenger.of(context).showSnackBar(FlashMessage( type: 'Success',));
            Navigator.pop(context,true);
          }
          else if(state.viewState==ViewState.error)
            ScaffoldMessenger.of(context).showSnackBar(FlashMessage( type: 'Fail',));
        },
        builder: (context,state) {
          titleController.text=state.title;
          notesController.text=state.notes;
          return  Scaffold(
            appBar: _appbar( context,state),
            body: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(10),
            ),
                  child: ReminderFormWidget(
                    titleController: titleController,
                      notesController: notesController,
                     ),
                ),
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 6,
                      ),
                      children: [
                        DetailsItem(
                          title: DetailConstants.dateTxt,
                          subtitle: state.hasDate == true
                              ? DateTime.fromMillisecondsSinceEpoch(state.date)
                              .isToday
                              : '',
                          icon: Icons.calendar_today_sharp,
                          bgIcon: Colors.red,
                          switchValue: state.hasDate,
                          switchOnChanged: (bool value) {
                            selectDate(context: context, hasDate: value);
                            selectTime(context: context, hasTime: false);
                          },
                          onTapItem: () {
                            if (state.hasDate) {
                              selectDate(
                                  context: context, hasDate: state.hasDate);
                            }
                          },
                        ),
                        DetailsItem(
                          title: DetailConstants.timeTxt,
                          subtitle: (state.hasDate && state.hasTime)
                              ? DateTime.fromMillisecondsSinceEpoch(
                              state.date + state.time)
                              .hourHHmm
                              :  '',
                          icon: Icons.timer,
                          bgIcon: Colors.blue,
                          switchValue: state.hasTime,
                          switchOnChanged: (bool value) {
                          if (state.hasDate)
                              selectTime(context: context, hasTime: value);
                            else { selectTime(context: context, hasTime: value);
                            selectDate(
                                context: context,
                                hasDate: true,
                                now: DateTime.now());
                            }
                          },
                          onTapItem: () {
                         if (state.hasDate && state.hasTime)
                              selectTime(
                                  context: context, hasTime: state.hasTime);
                          },
                        ),
                      ]),
                ),
                Container(
                  margin: EdgeInsets.only(
               left:     DetailConstants.marginHorizontal,
                    right:  DetailConstants.marginHorizontal,
                    top: ScreenUtil().setWidth(10)
                  ),
                  padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: GestureDetector(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (dialogContext) =>
                              priorityDialog(context: context));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: Text(DetailConstants.priorityTxt,
                              style: ThemeText.title2),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(getPriorityTypeText(state.priority),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(12.5),
                                color: Colors.grey,
                              )),
                        ),
                        Expanded(flex: 1, child: HomePageConstant.iconArrow),
                      ],
                    ),
                  ),
                ),
                Padding(padding:    EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(10)),
                  child: ContainerButtonWidget(
                    title: 'List',
                    subTitle: state.list != null
                        ? state.list
                        : 'Reminders',
                    onPressed: () => showDialog(
                        context: context, builder: (dialogContext) => listDialog(state,context)),
                  ),
          ),
              ],
            ),
          );
        }
    );
  }

  Widget priorityDialog({BuildContext context}) {
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
            BlocProvider.of<EditReminderBloc>(context)
                .add(EditPriorityEvent(priority: 0)),
            Navigator.pop(context),
          },
          isNotLast: true,
        ),
        PriorityItemWidget(
            name: priorityTypeUtil(PriorityType.LOW),
            color: Colors.yellow,
            onTap: () => {
              BlocProvider.of<EditReminderBloc>(context)
                  .add(EditPriorityEvent(priority: 1)),
              Navigator.pop(context),
            },
            isNotLast: true),
        PriorityItemWidget(
            name: priorityTypeUtil(PriorityType.MEDIUM),
            color: Colors.orange,
            onTap: () => {
              BlocProvider.of<EditReminderBloc>(context)
                  .add(EditPriorityEvent(priority: 2)),
              Navigator.pop(context),
            },
            isNotLast: true),
        PriorityItemWidget(
            name: priorityTypeUtil(PriorityType.HIGH),
            color: Colors.red,
            onTap: () => {
              BlocProvider.of<EditReminderBloc>(context)
                  .add(EditPriorityEvent(priority: 3)),
              Navigator.pop(context),
            },
            isNotLast: false),
      ],
    );
  }

  void selectTime({BuildContext context, bool hasTime}) async {
  int  time = 0;
    if (hasTime) {
      final TimeOfDay newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (newTime != null) {
        time = (newTime.hour * 60 * 60 + newTime.minute * 60) * 1000 ;
        BlocProvider.of<EditReminderBloc>(context)
            .add(EditTimeEvent(hasTime: hasTime, time: time));
      }
    } else {
      BlocProvider.of<EditReminderBloc>(context)
          .add(EditTimeEvent(hasTime: false, time: 0));
    }
  }

  void selectDate({BuildContext context, bool hasDate, DateTime now}) async {
    int date =0;
    if (now == null) {
      if (hasDate) {
        final DateTime picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2015, 8),
            lastDate: DateTime(2101));
        if (picked != null) {
          date = DateTime.parse(DateFormat('yyyy-MM-dd').format(picked))
              .millisecondsSinceEpoch;
          BlocProvider.of<EditReminderBloc>(context)
              .add(EditDateEvent(hasDate: hasDate, date: date));
        }
      } else {
        date = 0;
        BlocProvider.of<EditReminderBloc>(context)
            .add(EditDateEvent(hasDate: hasDate, date: 0));
      }
    } else {
      date= now.millisecondsSinceEpoch- (TimeOfDay.now().hour* 60 * 60 + TimeOfDay.now().minute * 60) * 1000;
      BlocProvider.of<EditReminderBloc>(context).add(
          EditDateEvent(hasDate: true, date: now.millisecondsSinceEpoch));
    }
  }

  Widget _appbar(BuildContext context,EditReminderState state)
  {
    return AppbarWidget(context,
    leadingText: 'Cancel',
      title: 'Edit',
      onTapAction: (state == null ||
          state.title == null ||
          state.title == '')
          ? Container(
        width: ScreenUtil().screenWidth / 6,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Done',
            style: TextStyle(
                color: Colors.grey,
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.w600),
          ),
        ),
      )
          : GestureDetector(
        onTap: () => {
          _onHandleDoneBtn(context),
        },
        child: Container(
          //color: Colors.blue,
          width: ScreenUtil().screenWidth / 6,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Done',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
  Widget listDialog(EditReminderState state, BuildContext context)
  {
    return   SimpleDialog(
        contentPadding: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(10),
          top: ScreenUtil().setHeight(10),
        ),
        title: Text(
          'Lists',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(20),
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        children: [
          Container(
              height: ScreenUtil().screenWidth - 20,
              width: ScreenUtil().screenWidth - 20,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.myLists.length,
                  itemBuilder: (listcontext, index) {
                    return ListItemWidget(
                      onTap: () => {
                        BlocProvider.of<EditReminderBloc>(context).add(EditListEvent(list:  state.myLists[index].name)),
                        Navigator.pop(context)
                      },
                      bgIcon: ColorConstants.colorMap[state.myLists[index].color],
                      name: state.myLists[index].name,
                    );
                  }))
        ]);
  }
  void _onHandleDoneBtn(BuildContext context)
  {
     BlocProvider.of<EditReminderBloc>(context)
       ..add(EditTitleEvent(title: titleController.text))
       ..add(EditNotesEvent(notes: notesController.text))
       ..add(UpdateReminderEvent( ));
  }

  String getContent(content) {
    if (content['date'] != 0) {
      if (content['time'] != 0) {
        return '${DateTime.fromMillisecondsSinceEpoch(content['date']).isToday},'
            ' ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(content['date'] + content['time']))},'
            ' ${getPriorityTypeText(content['priority'])}';
      } else {
        return '${DateTime.fromMillisecondsSinceEpoch(content['date']).isToday},'
            ' ${getPriorityTypeText(content['priority'])}';
      }
    } else {
      return '${getPriorityTypeText(content['priority'])}';
    }
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
}

