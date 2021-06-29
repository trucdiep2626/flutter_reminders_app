import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:reminders_app/common/injector.dart';
import 'package:reminders_app/reminders_app/domain/usecases/group_usecase.dart';
import 'package:reminders_app/reminders_app/presentation/journey/home_page/bloc/homepage_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/all_reminders/bloc/all_list_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/new_reminder/create_new_reminder/bloc/new_reminder_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/scheduled_list/bloc/scheduled_list_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/scheduled_list/bloc/scheduled_list_event.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/today_list/bloc/today_list_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/today_list/bloc/today_list_event.dart';
import '../../../common/constants/route_constants.dart';
import 'home_page/bloc/homepage_bloc.dart';
import 'reminder/all_reminders/all_list_screen.dart';
import 'reminder/all_reminders/bloc/all_list_bloc.dart';
import 'reminder/new_reminder/create_new_reminder/bloc/new_reminder_bloc.dart';
import 'reminder/new_reminder/create_new_reminder/create_new_reminder.dart';
import 'reminder/new_reminder/details/details_screen.dart';
import 'reminder/scheduled_list/scheduled_list_screen.dart';
import 'reminder/today_list/todaylist_screen.dart';
import 'home_page/home_screen.dart';
import 'list/new_list/bloc/add_list_bloc.dart';
import 'list/new_list/create_new_list.dart';
import 'reminder/new_reminder/details/bloc/add_details_bloc.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getAll() {
    return {
      RouteList.allListScreen: (_) => BlocProvider<AllRemindersBloc>(
            create: (context) => locator<AllRemindersBloc>()..add(UpdateAllListEvent(isUpdated: false)),
            child: AllRemindersList(),
          ),

      RouteList.todayListScreen: (_) => BlocProvider<TodayListBloc>(
            create: (context) => locator<TodayListBloc>()..add(UpdateTodayListEvent(isUpdated: false)),
            child: TodayList(),
          ),

      RouteList.homeScreen: (_) => BlocProvider<HomeBloc>(
            create: (context) => locator<HomeBloc>()
              ..add(SetDefaultGroupEvent())
              ..add(UpdateEvent()),
            child: HomeScreen(),
          ),

      RouteList.scheduledListScreen: (_) =>
          BlocProvider<ScheduledRemindersBloc>(
              create: (context) =>
                  locator<ScheduledRemindersBloc>()..add(UpdateScheduledEvent(isUpdated: false)),
              child: ScheduledList()),

      RouteList.createNewScreen: (_) => BlocProvider<NewReminderBloc>(
          create: (context) =>
              locator<NewReminderBloc>()
                ..add(GetAllGroupEvent()),
          child: CreateNewReminder()),

      RouteList.detailsScreen: (_) => BlocProvider<AddDetailsBloc>(
          create: (context) => AddDetailsBloc(), child: DetailsScreen()),

      RouteList.createNewList: (_) => BlocProvider<AddListBloc>(
          create: (context) => locator<AddListBloc>(), child: NewList()),
      //  ),
    };
  }
}
