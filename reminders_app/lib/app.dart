import 'package:flutter/material.dart';

import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:hive/hive.dart';
import 'common/constants/route_constants.dart';

import 'routes.dart';
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_MyApp();

}
class _MyApp extends State<MyApp> {
  @override
  void dispose()
  {
    Hive.close();
    super.dispose();
  }
  String get initialRoute {
    return RouteList.b10HomeScreen;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(400, 700),
      allowFontScaling: true,
      builder: () => MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'MS'
      ),
     ///  home: (build=>Navigator.pushNamed(context, RouteList.b10HomeScreen)) ,
      routes: Routes.getAll(),
      initialRoute: initialRoute,
    )
    );
  }
}

