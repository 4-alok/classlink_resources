// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

import '../../services/box/box_service.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/non_kiitian/view/non_kiitian_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static final INITIAL = Get.find<BoxService>().appUserBox.appUser == null
      ? Routes.AUTH
      : Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NON_KIITIAN,
      page: () => const NonKiitianView(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
  ];
}
