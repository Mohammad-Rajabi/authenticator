
import 'package:authenticator/src/config/app_routes.dart';
import 'package:authenticator/src/core/binding/app_binding.dart';
import 'package:authenticator/src/data/local/theme_service.dart';
import 'package:authenticator/src/config/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: AppRoutes.homeRoute,
      getPages: AppRoutes.getPages(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeService().theme,
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
