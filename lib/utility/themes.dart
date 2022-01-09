import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
      backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),
      textTheme: TextTheme(
          headline6: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(color: Colors.black));

  static final dark = ThemeData.dark().copyWith(
      backgroundColor: Color(0xff202124),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Color(0xff202124),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xff202124),
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xff202124),
      ),
      textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white)),
      iconTheme: IconThemeData(color: Colors.white));
}
