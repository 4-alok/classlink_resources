import 'package:classlink_resources/app/global/widgets/card_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../global/widgets/app_title.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: CardBox(
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    onPressed: () => controller.toggleThemeMode(
                      context.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                    ),
                    icon: context.isDarkMode
                        ? const FaIcon(FontAwesomeIcons.sun)
                        : const FaIcon(FontAwesomeIcons.moon),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 100),
                      SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/icons/favicon.png')),
                      const SizedBox(height: 20),
                      const AppTitleWidget(
                        fontSize: 40,
                      ),
                      const Text(
                        " Resources",
                        style: TextStyle(
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          // color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const Spacer(),
                      googleLoginButton(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget googleLoginButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // pageIndicator(context),
              // const SizedBox(height: 50),
              ElevatedButton(
                onPressed:
                    controller.loading.value ? null : () => controller.login(),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/google.svg",
                          semanticsLabel: 'A red up arrow',
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 10),
                        const Text("Login"),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
