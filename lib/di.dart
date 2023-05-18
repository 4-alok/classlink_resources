import 'package:classlink_resources/services/auth/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';
import 'services/box/box_service.dart';
import 'services/sheet/sheet_service.dart';

/// Initializing the app.
Future<void> init() async {
  if (GetPlatform.isAndroid || GetPlatform.isWeb) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
        );
  }

  await GetStorage.init();
  await Get.put<BoxService>(BoxService()).init();
  Get.put(AuthServices());
  Get.put<SheetService>(SheetService());
}
