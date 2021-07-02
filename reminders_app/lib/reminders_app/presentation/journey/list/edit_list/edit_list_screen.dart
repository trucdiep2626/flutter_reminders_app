import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/edit_list/bloc/edit_list_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/edit_list/bloc/edit_list_state.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/new_list/create_new_list.dart';
import 'package:reminders_app/reminders_app/theme/theme.dart';
import 'package:reminders_app/reminders_app/widgets_constants/appbar.dart';
import 'package:reminders_app/reminders_app/widgets_constants/flash_message.dart';

import 'bloc/edit_list_bloc.dart';

class EditListScreen extends StatelessWidget{
  @override
    TextEditingController name = TextEditingController();

    Widget build(BuildContext context) {
      return BlocConsumer<EditListBloc, EditListState>(
        listener: (context, state) {
          if (state.viewState == ViewState.success) {
            ScaffoldMessenger.of(context).showSnackBar(FlashMessage(
              type: 'Success',
            ));
            Navigator.pop(context, true);
          } else if (state.viewState == ViewState.error) {
            ScaffoldMessenger.of(context).showSnackBar(FlashMessage(
              type: 'Fail',
            ));
            BlocProvider.of<EditListBloc>(context)
                .add(UpdateViewStateEvent(viewState: ViewState.busy));
          } else if (state.viewState == ViewState.showDialog) {
            showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    title: Text(
                      'Cannot edit list. A list with this name already exists',
                      style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(17),
                              color: Colors.blue,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ]));
            BlocProvider.of<EditListBloc>(context)
                .add(UpdateViewStateEvent(viewState: ViewState.busy));
          }
        },
        builder: (context, state) {
          name.text=state.oldName;
          log(state.selectedColor.toString()+"PPPPPPPPPPPPPPPPPpp");
          return Scaffold(
            appBar: _appbar(state: state, context: context),
            body: ListView(shrinkWrap: true, children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: state.selectedColor,
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
                          textCapitalization: TextCapitalization.sentences,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              BlocProvider.of<EditListBloc>(context).add(
                                  ActiveClearButtonEvent(activeClearButton: true));
                            } else {
                              BlocProvider.of<EditListBloc>(context).add(
                                  ActiveClearButtonEvent(activeClearButton: false));
                            }
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Visibility(
                          visible: state.activeClearBtn,
                          child: GestureDetector(
                            onTap: () => {
                              name.clear(),
                              BlocProvider.of<EditListBloc>(context).add(
                                  ActiveClearButtonEvent(activeClearButton: false)),
                            },
                            child: Container(
                              padding: EdgeInsets.all(ScreenUtil().setHeight(2)),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey),
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
              selectedColor(context, state),
            ]),
          );
        },
      );
    }

    Widget selectedColor(BuildContext context, EditListState state) {
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
            selectedColor: state.selectedColor,
            onColorChange: (selecteded) {
              BlocProvider.of<EditListBloc>(context)
                  .add(SelectColorEvent(color: selecteded));
            }),
      );
    }
    
    void onHandleDoneBtn(BuildContext context, EditListState state) {
      log(state.selectedColor.toString()+"PPPPPPPPPPPPP");
      BlocProvider.of<EditListBloc>(context)
          .add(UpdateListEvent(name: name.text, color: state.selectedColor));
    }
    
    Widget _appbar({
      @required EditListState state,
      @required BuildContext context,
    }) {
      return AppbarWidget(
        context,
        leadingText: 'Cancel',
        title: 'Edit List',
        onTapAction: GestureDetector(
          onTap: () {
            onHandleDoneBtn(context, state);
          },
          child: Container(
              width: ScreenUtil().screenWidth / 6,
              child: Align(
                alignment: Alignment.center,
                child: Text('Edit',
                    style: ThemeText.actionButton.copyWith(
                      color:  Colors.blue  ,
                    )),
              )),
        ),
      );
    }

   
  

}