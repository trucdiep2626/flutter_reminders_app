import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/constants/route_constants.dart';
import '../bloc/homepage_bloc.dart';
import '../bloc/homepage_event.dart';

class BottomBar extends StatelessWidget
{BuildContext context1;

BottomBar(this.context1 );

  @override
  Widget build(BuildContext context) {
    //int value;
    Color listColor=Colors.blue;
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: GestureDetector(
                  onTap: () async
                  {await Navigator.pushNamed(context, RouteList.createNewScreen)
                      .whenComplete(()=>
                      BlocProvider.of<HomeBloc>(context1).add(UpdateEvent( ))) ;
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
                onTap: () async
                {await Navigator.pushNamed(context,RouteList.createNewList )
                    .whenComplete(()=>
                    BlocProvider.of<HomeBloc>(context1).add(UpdateEvent( ))) ;
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
