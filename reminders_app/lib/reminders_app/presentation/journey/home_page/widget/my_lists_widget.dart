import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:reminders_app/common/injector.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/list/bloc/list_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/list/bloc/list_event.dart';
import 'package:reminders_app/reminders_app/theme/theme.dart';
import '../bloc/home_state.dart';
import '../bloc/homepage_bloc.dart';
import '../bloc/homepage_event.dart';
import '../../list/list/list_screen.dart';
import '../../../../widgets_constants/confirm_dialog.dart';
import '../../../../widgets_constants/icon_slide_widget.dart';

import '../../reminders_list.dart';
import '../homepage_constants.dart';

class MyListsWidget extends StatelessWidget{
 String name;
 int index;
 Color color;
 int length;
 bool isUpdated;
 
  MyListsWidget({@required this.color, @required this.name ,@required this.index,@required this.length });

  @override
  Widget build(BuildContext context) {
 //   log(color.toString());
          return Slidable(
            closeOnScroll: true,
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                child: IconSlideWidget.edit(
                    (){

                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                child: IconSlideWidget.delete(() => {
                   name == 'Reminders'
                      ? showDialog(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(15)),
                          title: Text(
                            'Default list cannot be deleted',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(15)),
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
                          ]))
                      : showDialog(
                      context: context,
                      builder: (dialogContext) => ConfirmDialog(
                        confirmText: 'Delete',
                        onPressedCancel: () {
                          Navigator.pop(context);
                        },
                        content:
                        'This will delete all reminders in this list',
                        title: 'Delete?',
                        onPressedOk: ()=>deleteList(context, index),
                      )),
                }),
              )
            ],
            actionExtentRatio: 0.2,
            child: GestureDetector(
              onTap: () async {
               isUpdated =  await Navigator.push(context,
                    MaterialPageRoute(builder: (_) =>  BlocProvider<ListBloc>(
                      create: (context) => locator<ListBloc>()..add(UpdateListEvent(index: index,isUpdated: false)),
                      child: ListScreen(index),
                    ),));
               log(isUpdated.toString());
                     if(isUpdated)
                    {
                      BlocProvider.of<HomeBloc>(context).add(UpdateEvent());
                     // isUpdated=false;
                    }


              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: HomePageConstant.listIconWidget(color),
                      ),
                    ),
                    Expanded(
                      flex: 22,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                         name,
                          style: ThemeText.title2,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          '${length}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(15),
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        )),
                    Expanded(flex: 1, child: HomePageConstant.iconArrow),
                  ],
                ),
              ),
            ),
          );

  }

  deleteList(BuildContext context, int index) {

    BlocProvider.of<HomeBloc>(context)
      ..add(DeleteGroupEvent(indexGroup: index))
        ..add(UpdateEvent( ))
       ;
   // BlocProvider.of<HomeBloc>(context).add(UpdateEvent( ));
    Navigator.pop(context);
  }

}