import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminders_app/reminders_app/presentation/journey/home_page/bloc/home_state.dart';
import '../../../../../common/constants/route_constants.dart';
import '../bloc/homepage_bloc.dart';
import '../bloc/homepage_event.dart';

class BottomBar extends StatelessWidget {
  BuildContext context1;
  HomeState homeState;
  var isUpdated ;

  BottomBar({@required this.context1, @required this.homeState});

  @override
  Widget build(BuildContext context) {
    Color listColor = Colors.blue;
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: GestureDetector(
                  onTap: () async {
                    isUpdated = await Navigator.pushNamed(context,RouteList.createNewScreen);
                    log(isUpdated.toString() + "update");
                    if (isUpdated) {
                      BlocProvider.of<HomeBloc>(context).add(UpdateEvent());
                    }
                  },
                  child: Row(children: [
                    Container(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(2)),
                      decoration: BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: ScreenUtil().setSp(20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                      child: Text(
                        'New Reminder',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(15),
                            color: Colors.blue),
                      ),
                    )
                  ]))),
          Expanded(
              child: GestureDetector(
            onTap: () async {
              isUpdated =
                  await Navigator.pushNamed(context, RouteList.createNewList);
                if (isUpdated) {
                  BlocProvider.of<HomeBloc>(context).add(UpdateEvent());
                }

            },
            child: Text(
              'Add List',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(15),
                  color: Colors.blue),
            ),
          ))
        ],
      ),
    );
  }
}
