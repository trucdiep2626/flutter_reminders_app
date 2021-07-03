import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:reminders_app/common/enums/view_state.dart';
import 'package:reminders_app/reminders_app/theme/theme.dart';
import 'package:reminders_app/reminders_app/widgets_constants/flash_message.dart';
import '../../../../common/constants/layout_constants.dart';
import '../../../../common/constants/route_constants.dart';
import 'bloc/homepage_bloc.dart';
import 'bloc/homepage_event.dart';
import 'homepage_constants.dart';
import 'widget/my_lists_widget.dart';
import 'bloc/home_state.dart';
import 'widget/bottom_navigation_bar.dart';
import 'widget/grid_view_item.dart';
import 'widget/search_bar.dart';

class HomeScreen extends StatelessWidget {
  var isUpdated;
  final TextEditingController textName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      if (state.viewState == ViewState.success)
        ScaffoldMessenger.of(context).showSnackBar(FlashMessage(
          type: 'Success',
        ));
      else if (state.viewState == ViewState.error)
        ScaffoldMessenger.of(context).showSnackBar(FlashMessage(
          type: 'Fail',
        ));
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              SearchBar(),
              GridView(
                  padding: EdgeInsets.symmetric(
                    horizontal: LayoutConstants.paddingHorizontalItem,
                  ),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: ScreenUtil().setWidth(10),
                    childAspectRatio: 2.2,
                  ),
                  children: [
                    GestureDetector(
                      onTap: () async {
                        isUpdated = await Navigator.pushNamed(
                            context, RouteList.todayListScreen);
                        if (isUpdated) {
                          BlocProvider.of<HomeBloc>(context).add(UpdateEvent());
                          isUpdated = false;
                        }
                      },
                      child: GridViewItem(
                          icon: HomePageConstant.iconToday,
                          bgColor: Colors.blue,
                          title: 'Today',
                          count: state.todayListLength != null
                              ? state.todayListLength
                              : 0),
                    ),
                    GestureDetector(
                      onTap: () async {
                        isUpdated = await Navigator.pushNamed(
                            context, RouteList.scheduledListScreen);
                        if (isUpdated) {
                          BlocProvider.of<HomeBloc>(context).add(UpdateEvent());
                        }
                      },
                      child: GridViewItem(
                          icon: HomePageConstant.iconScheduled,
                          bgColor: Colors.red,
                          title: 'Scheduled',
                          count: state.scheduledListLength != null
                              ? state.scheduledListLength
                              : 0),
                    ),
                  ]),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: LayoutConstants.paddingHorizontalItem,
                    vertical: LayoutConstants.paddingVerticalItem),
                child: GestureDetector(
                  onTap: () async {
                    isUpdated = await Navigator.pushNamed(
                        context, RouteList.allListScreen);
                    log(isUpdated.toString());
                    if (isUpdated) {
                      BlocProvider.of<HomeBloc>(context).add(UpdateEvent());
                    }
                  },
                  child: GridViewItem(
                      icon: HomePageConstant.iconAll,
                      bgColor: Colors.grey,
                      title: 'All',
                      count: state.allListLength != null
                          ? state.allListLength
                          : 0),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: LayoutConstants.paddingHorizontalApp,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'My Lists',
                      style: ThemeText.headline2ListScreen
                          .copyWith(color: Colors.black),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: LayoutConstants.paddingHorizontalItem),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        state.myLists.length == null ? 0 : state.myLists.length,
                    itemBuilder: (context, index) {
                      return MyListsWidget(
                        state: state,
                        index: index,
                        length: state.listLength[state.myLists[index].name],
                      );
                    }),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(
          context1: context,
          homeState: state,
        ),
      );
    });
  }
}
