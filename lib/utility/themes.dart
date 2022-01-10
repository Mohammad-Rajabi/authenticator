import 'package:authenticator/utility/colors.dart';
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
      backgroundColor: AppColors.LigtDark,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.LigtDark,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.LigtDark,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.LigtDark,
      ),
      textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white)),
      iconTheme: IconThemeData(color: Colors.white));
}
