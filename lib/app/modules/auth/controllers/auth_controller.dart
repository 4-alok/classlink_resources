import 'package:classlink_resources/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/box/box_service.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  final loading = RxBool(false);
  final boxService = Get.find<BoxService>();
  final authService = Get.find<AuthServices>();

  Future<void> toggleThemeMode(ThemeMode themeMode) async =>
      await boxService.themeBox.changeThemeMode(themeMode);

  Future<void> login() async {
    loading.value = true;
    final res = await authService.googleSignIn();
    if (res != null) {
      if (res.email.endsWith("@kiit.ac.in")) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.NON_KIITIAN);
      }
    }
    loading.value = false;
  }
}
