import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import '../../new_reminder_constants.dart';
import '../bloc/reminder_stream.dart';
import 'text_field.dart';

class ReminderFormWidget extends StatelessWidget {
  final Function(String) onChangeTitle;
  final Function(String) onChangeNotes;

  const ReminderFormWidget(
      {Key key, this.onChangeTitle, this.onChangeNotes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        ScreenUtil().setWidth(10),
      ),
      child: Container(
          padding: EdgeInsets.all(ScreenUtil().setHeight(15)),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              TextFieldWidget(
                  hintText: NewReminderConstants.titleTxt,
                  maxLine: 1,
                  onChanged: onChangeTitle,),
              TextFieldWidget(
                  hintText: NewReminderConstants.notesTxt,
                  maxLine: 5,
                  onChanged: onChangeNotes)
            ],
          )),
    );
  }
}
