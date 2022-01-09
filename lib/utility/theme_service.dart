import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ThemeService {
  static final ThemeService _instance = ThemeService._internal();

  factory ThemeService() => _instance;

  ThemeService._internal();

  final _box = GetStorage();
  final String _key = "isDarkMode";

  bool _loadTheme() => _box.read(_key) ?? false;

  _saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);

  ThemeMode get theme => _loadTheme() ? ThemeMode.light : ThemeMode.dark;

  void switchTheme() {
    _saveTheme(!_loadTheme());
    Get.changeThemeMode(_loadTheme() ? ThemeMode.light : ThemeMode.dark);
  }
}
