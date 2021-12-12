import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:todo_notif_sqflite/controllers/home_controller.dart';

class ThemeServices {
  final HomeController _homeController = Get.put(HomeController());
  final _box = GetStorage();
  final _key = "isDarkMode";

  Future<void> _saveThemeToBox(bool isDark) => _box.write(_key, isDark);

  bool loadThemeFromBox() => _box.read(_key) ?? false;

  ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!loadThemeFromBox());
    _homeController.isDarkMode.value = loadThemeFromBox();
  }
}
