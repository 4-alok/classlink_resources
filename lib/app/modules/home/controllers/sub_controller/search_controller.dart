import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ResSearchController {
  final key = Rx<String>('');
  final search = TextEditingController();

  void clear() => search.text = "";

  void dispose() {
    key.close();
    search.dispose();
  }
}
