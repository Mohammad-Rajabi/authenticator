import 'package:authenticator/pages/form_page.dart';
import 'package:authenticator/pages/home_page.dart';
import 'package:authenticator/utility/theme_service.dart';
import 'package:authenticator/utility/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Authenticator',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/form', page: () => FormPage())
      ],
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: HomePage(),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
