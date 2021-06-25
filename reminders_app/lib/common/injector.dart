import 'package:get_it/get_it.dart';
import 'package:reminders_app/common/config/local_config.dart';
import 'package:reminders_app/reminders_app/data/data_sources/local/group_data_source.dart';
import 'package:reminders_app/reminders_app/data/data_sources/local/reminder_data_source.dart';
import 'package:reminders_app/reminders_app/data/repositories/group_repository_impl.dart';
import 'package:reminders_app/reminders_app/data/repositories/reminder_repository_impl.dart';
import 'package:reminders_app/reminders_app/domain/repositories/group_repository.dart';
import 'package:reminders_app/reminders_app/domain/repositories/reminder_repository.dart';
import 'package:reminders_app/reminders_app/domain/usecases/group_usecase.dart';
import 'package:reminders_app/reminders_app/domain/usecases/reminder_usecase.dart';
import 'package:reminders_app/reminders_app/presentation/journey/home_page/bloc/homepage_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/list/bloc/list_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/list/new_list/bloc/add_list_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/all_reminders/bloc/all_list_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/new_reminder/create_new_reminder/bloc/new_reminder_bloc.dart';
import 'package:reminders_app/reminders_app/presentation/journey/reminder/today_list/bloc/today_list_bloc.dart';

GetIt locator = GetIt.instance;

void setup() {
  locator.registerFactory<HomeBloc>(() => HomeBloc(
      groupUc: locator<GroupUsecase>(),
      reminderUc: locator<ReminderUseCase>()));
  locator.registerFactory<AddListBloc>(
      () => AddListBloc(groupUc: locator<GroupUsecase>()));
  locator.registerFactory<NewReminderBloc>(() => NewReminderBloc(
      reminderUc: locator<ReminderUseCase>(),
      groupUc: locator<GroupUsecase>()));
  locator.registerFactory<ListBloc>(() => ListBloc( reminderUc: locator<ReminderUseCase>(),
      groupUc: locator<GroupUsecase>()));
  locator.registerFactory<AllRemindersBloc>(() => AllRemindersBloc( reminderUc: locator<ReminderUseCase>(),
      groupUc: locator<GroupUsecase>()));
  locator.registerFactory<TodayListBloc>(() => TodayListBloc( reminderUc: locator<ReminderUseCase>()));

  locator.registerFactory<GroupUsecase>(
      () => GroupUsecase(groupRepo: locator<GroupRepository>()));
  locator.registerFactory<ReminderUseCase>(
      () => ReminderUseCase(reminderRepository: locator<ReminderRepository>()));

  locator.registerFactory<GroupRepository>(
      () => GroupRepositoryImpl(groupDs: locator<GroupDataSource>()));
  locator.registerFactory<ReminderRepository>(
      () => ReminderRepositoryImpl(reminderDs: locator<ReminderDataSource>()));

  locator.registerLazySingleton<GroupDataSource>(
      () => GroupDataSource(config: locator<LocalConfig>()));
  locator.registerLazySingleton<ReminderDataSource>(
      () => ReminderDataSource(config: locator<LocalConfig>()));

  locator.registerLazySingleton<LocalConfig>(() => LocalConfig());
}
