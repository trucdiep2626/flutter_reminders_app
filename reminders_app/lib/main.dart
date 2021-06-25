import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminders_app/common/config/local_config.dart';
import 'package:reminders_app/common/injector.dart';
import 'app.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
 setup();
final LocalConfig localConfig=locator<LocalConfig>();
await localConfig.init();
  runApp(MyApp());
}