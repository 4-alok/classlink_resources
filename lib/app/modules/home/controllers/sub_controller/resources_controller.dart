import 'package:get/get.dart';

import '../../../../../services/auth/auth_service.dart';
import '../../../../../services/box/box_service.dart';
import '../../../../../services/sheet/sheet_service.dart';
import '../../../../data/credentials.dart';
import '../../../../../models/resources_entities.dart';

class ResourcesController {
  SheetService get sheetService => Get.find<SheetService>();
  BoxService get boxService => Get.find<BoxService>();
  AuthServices get authServices => Get.find<AuthServices>();

  bool get hasData => sheetService.hasData.value;
  String get currentPath => sheetService.currentPath.value;
  set currentPath(String value) => sheetService.currentPath.value = value;
  List<IndexEntity> get currentEntity => sheetService.currentEntity.value;

  void init() {
    sheetService.getDataTest;
  }

  bool get backButtonController {
    if (sheetService.currentPath.value != baseFolder) {
      final k = sheetService.currentPath.value
          .substring(0, sheetService.currentPath.value.lastIndexOf('/'));
      sheetService.currentPath.value = "${k.substring(0, k.lastIndexOf('/'))}/";
      return false;
    } else {
      return true;
    }
  }

  String get rootTitle => sheetService.currentPath.value;
  String kiloBytesToString(double size) => size < 0
      ? "Unknown"
      : size < 1024
          ? "${size.toStringAsFixed(2)} KB"
          : "${(size / 1024).toStringAsFixed(2)} MB";
}
