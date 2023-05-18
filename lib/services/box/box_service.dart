import 'package:classlink_resources/services/box/datasource/recent_datasources.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'datasource/fav_datasources.dart';
import 'datasource/theme_datasource.dart';
import 'datasource/user_datasources.dart';

class BoxService extends GetxService {
  late final ThemeDatasource themeBox;
  late final AppUserDataSource appUserBox;
  late final FavDatasources favBox;
  late final RecentDatasources recent;
  final box = GetStorage();

  Future<void> init() async {
    themeBox = ThemeDatasource(box);
    appUserBox = AppUserDataSource(box);
    favBox = FavDatasources(box);
    recent = RecentDatasources(box);
  }

  @override
  void onClose() {
    appUserBox.diospose();
    super.onClose();
  }
}
