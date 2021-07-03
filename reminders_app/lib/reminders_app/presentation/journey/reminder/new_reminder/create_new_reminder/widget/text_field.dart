import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  int maxLine;
  Function onChanged;
  TextFieldWidget(
      {Key key,
      @required this.hintText,
      @required this.maxLine,
      this.onChanged,
      this.controller});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLine,
      textCapitalization: TextCapitalization.sentences,
      textAlign: TextAlign.start,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: ScreenUtil().setSp(15),
            fontFamily: 'MS',
            fontWeight: FontWeight.w500,
            color: Colors.grey),
        border:
            (hintText == 'Notes') ? InputBorder.none : UnderlineInputBorder(),
      ),
    );
  }
}
