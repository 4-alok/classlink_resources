import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeDatasource {
  final GetStorage box;
  const ThemeDatasource(this.box);

  Future<void> changeThemeMode(ThemeMode themeMode) async =>
      await saveTheme(themeMode)
          .then((value) => Get.changeThemeMode(themeMode));

  ThemeMode get getTheme {
    final res = box.read<int>("themeMode");
    return res == null ? ThemeMode.system : ThemeMode.values[res];
  }

  Future<void> saveTheme(ThemeMode themeMode) async =>
      await box.write("themeMode", themeMode.index);
}
