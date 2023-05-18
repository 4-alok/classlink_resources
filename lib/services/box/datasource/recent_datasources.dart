import 'package:get_storage/get_storage.dart';

import '../../../models/resources_entities.dart';

const _recentKey = "recents";

class RecentDatasources {
  final GetStorage box;
  const RecentDatasources(this.box);

  List<String> get _recents =>
      (box.read<List?>(_recentKey) ?? []).cast<String>();

  Future<void> saveRecent(String value) async {
    final recents = _recents;
    if (recents.contains(value)) {
      recents.remove(value);
    }
    recents.insert(0, value);
    if (recents.length > 10) {
      recents.removeLast();
    }
    await box.write(_recentKey, recents);
  }

  List<IndexFile> get getRecents => (box.read<List?>(_recentKey) ?? [])
      .cast<String>()
      .map((e) => IndexFile.fromJson(e))
      .toList();

  Future<void> clearRecents() async => await box.remove(_recentKey);
}
