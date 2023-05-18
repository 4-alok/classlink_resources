import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/app_user.dart';

const String _appUserKey = "appUser";

class AppUserDataSource {
  final GetStorage box;
  AppUserDataSource(this.box);

  final appUserRx = Rx<AppUser?>(null);

  Future<void> saveAppUser(AppUser appUser) async => await box
      .write(_appUserKey, appUser.toJson())
      .then((value) => appUserRx.value = appUser);

  AppUser? get appUser {
    final res = box.read<String>(_appUserKey);
    return res == null ? null : AppUser.fromJson(res);
  }

  Future<void> deleteAppUser() async =>
      await box.remove(_appUserKey).then((value) => appUserRx.value = null);

  void diospose() {
    appUserRx.close();
  }
}
