import 'package:classlink_resources/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../global/widgets/card_box.dart';
import '../../../routes/app_pages.dart';

class NonKiitianView extends StatelessWidget {
  const NonKiitianView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        child: CardBox(
          child: Container(
            height: double.maxFinite,
            margin: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const FaIcon(FontAwesomeIcons.faceDizzy, size: 130),
                const SizedBox(height: 80),
                const Text(
                  "We apologise, this app is not available for you",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.onErrorContainer),
                  ),
                  onPressed: () async {
                    await Get.find<AuthServices>().logout();
                    Get.offAllNamed(Routes.AUTH);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.onError,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
