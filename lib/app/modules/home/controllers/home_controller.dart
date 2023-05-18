import 'package:classlink_resources/app/modules/home/controllers/sub_controller/fav_controller.dart';
import 'package:classlink_resources/app/modules/home/controllers/sub_controller/resources_controller.dart';
import 'package:classlink_resources/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/box/box_service.dart';
import '../../../routes/app_pages.dart';
import 'sub_controller/search_controller.dart';

enum BodyPanelType { resources, fav, search }

class HomeController extends GetxController {
  BoxService get boxService => Get.find<BoxService>();
  AuthServices get authServices => Get.find<AuthServices>();

  late final FavController favController;

  final page = Rx<BodyPanelType>(BodyPanelType.resources);
  final resController = ResourcesController();
  final searchController = ResSearchController();

  @override
  void onInit() {
    resController.init();
    favController = FavController(this);
    super.onInit();
  }

  Future<void> toggleThemeMode(ThemeMode themeMode) async =>
      await boxService.themeBox.changeThemeMode(themeMode);

  Future<void> logout() async {
    authServices.logout();
    Get.offAllNamed(Routes.AUTH);
  }

  void rerender() => update();

  @override
  void onClose() {
    searchController.dispose();
    favController.dispose();
    super.onClose();
  }
}
