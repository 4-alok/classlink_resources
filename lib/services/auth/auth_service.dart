import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../box/box_service.dart';
import '../box/models/app_user.dart';

class AuthServices extends GetxService {
  late final GoogleSignIn _googleSignIn;
  final googleSignInAccount = Rx<GoogleSignInAccount?>(null);

  static BoxService get box => Get.find<BoxService>();

  @override
  void onInit() {
    _googleSignIn = GoogleSignIn();
    googleSignInAccount.value = _googleSignIn.currentUser;
    super.onInit();
  }

  Future<GoogleSignInAccount?> googleSignIn() async {
    try {
      googleSignInAccount.value = kIsWeb
          ? await _googleSignIn.signInSilently()
          : await _googleSignIn.signIn();

      if (googleSignInAccount.value != null) {
        await box.appUserBox
            .saveAppUser(googleSignInAccount.value!.fromGoogleSignInAccount);
      }

      return googleSignInAccount.value;
    } catch (error) {
      Get.snackbar('Error', error.toString());
      return null;
    }
  }

  Future<bool> printIsSignIn() async => await _googleSignIn.isSignedIn();

  String googleUserInfo() => _googleSignIn.currentUser?.displayName ?? '';

  Future<void> logout() async {
    try {
      await box.appUserBox.deleteAppUser();
      await _googleSignIn.signOut();
    } catch (error) {
      null;
    }
  }

  @override
  void onClose() {
    _googleSignIn.disconnect();
    super.onClose();
  }
}
