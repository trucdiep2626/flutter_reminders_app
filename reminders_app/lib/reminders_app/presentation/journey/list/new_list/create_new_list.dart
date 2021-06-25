import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:hive/hive.dart';
import 'package:reminders_app/common/constants/color_constants.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/reminders_app/theme/theme.dart';
import 'bloc/add_list_bloc.dart';
import 'bloc/add_list_event.dart';
import 'bloc/add_list_state.dart';
import 'bloc/create_list_state.dart';
import 'bloc/list_stream.dart';
import '../../reminders_list.dart';
import '../../../../widgets_constants/appbar.dart';

import '../../../../../common/extensions/date_extensions.dart';
class NewList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewList();
}

class _NewList extends State<NewList> {
  TextEditingController name = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<AddListBloc, AddListState>
      (
      listener: (context,state){
        if(state.viewState==ViewState.success)
          Navigator.pop(context);
      },
    builder: (context,state){
        return Scaffold(
          appBar: _appbar(state),
          body: ListView(shrinkWrap: true, children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: state.selectColor,
                ),
                child: Icon(
                  Icons.list,
                  size: ScreenUtil().setSp(80),
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade300,
                  ),
                  child: Row(children: [
                    Expanded(
                      flex: 5,
                      child: TextField(
                        controller: name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(23)),
                        maxLines: 1,
                        textCapitalization:
                        TextCapitalization.sentences,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            BlocProvider.of<AddListBloc>(context)
                                .add(ActiveAddButtonEvent(activeAddButton: true));
                          } else {
                            BlocProvider.of<AddListBloc>(context)
                                .add(ActiveAddButtonEvent(activeAddButton: false));
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Visibility(
                        visible: state.activeAddBtn,
                        child: GestureDetector(
                          onTap: () => {
                            name.clear(),
                            BlocProvider.of<AddListBloc>(context)
                                .add(ActiveAddButtonEvent(activeAddButton: false)),
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                ScreenUtil().setHeight(2)),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey),
                            child: Icon(
                              Icons.clear,
                              size: ScreenUtil().setSp(15),
                            ),
                          ),
                        ),
                      ),
                    )
                  ])),
            ),
            selectColor(context, state),
          ]),
        );
      },
    );
  }



  Widget selectColor(BuildContext context, AddListState state) {
    return Container(
      alignment: Alignment.center,
      height: ScreenUtil().screenWidth,
      width: ScreenUtil().screenWidth - 20,
      child: MaterialColorPicker(
          colors: [
            Colors.blue,
            Colors.green,
            Colors.red,
            Colors.pink,
            Colors.orange,
            Colors.yellow,
            Colors.brown,
          ],
          selectedColor: state.selectColor,
          onColorChange: (selected) {
            // listStream.setColor(selected),
            BlocProvider.of<AddListBloc>(context)
                .add(SelectColorEvent(color: selected));
            // log(state.selectColor.toString())
          }),
    );
  }

  Widget _appbar(AddListState state) {
    return AppbarWidget(
      context,
      leadingText: 'Cancel',
      title: 'New List',
      onTapAction: GestureDetector(
        onTap: () {
          if (state.activeAddBtn) {
           // log(ColorConstants.getColorString(state.selectColor));
            RemindersList.addList(name.text, ColorConstants.getColorString(state.selectColor));
            onHandleAddBtn(context);
          }
        },
        child: Container(
            width: ScreenUtil().screenWidth / 6,
            child: Align(
              alignment: Alignment.center,
              child: Text('Add',
                  style: ThemeText.actionButton.copyWith(
                    color:
                    state.activeAddBtn ? Colors.blue : Colors.grey,
                  )),
            )),
      ),
    );
  }
  void onHandleAddBtn(BuildContext context )
  {
    log('event add to box');
    BlocProvider.of<AddListBloc>(context).add(CreateNewListEvent(name:name.text));
  }
}
