import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class NavigationPanel extends StatelessWidget {
  const NavigationPanel(this.controller, this.screenType, {Key? key})
      : super(key: key);
  final HomeController controller;
  final ScreenType screenType;

  CircleAvatar profilePhoto() => CircleAvatar(
        radius: 13,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
          controller.boxService.appUserBox.appUser?.photoURL ?? '',
        ),
      );

  bool get useNavigationRail =>
      screenType == ScreenType.Phone || screenType == ScreenType.Tablet;

  @override
  Widget build(BuildContext context) => useNavigationRail
      ? navigationRail(context)
      : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Obx(
                  () => "/"
                              .allMatches(controller.resController.currentPath)
                              .length >
                          1
                      ? ListTile(
                          onTap: () =>
                              (controller.resController.backButtonController)
                                  ? Navigator.canPop(context)
                                      ? Navigator.pop(context)
                                      : null
                                  : null,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: const FaIcon(FontAwesomeIcons.arrowLeft),
                        )
                      : const SizedBox(),
                ),
              ),
              const SizedBox(height: 5),
              // AnimatedSize(
              //   duration: const Duration(milliseconds: 300),
              //   child: screenType != ScreenType.Phone
              //       ? Column(
              //           mainAxisSize: MainAxisSize.min,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             TextField(
              //               controller: controller.searchController.search,
              //               onChanged: (value) =>
              //                   controller.searchController.key.value = value,
              //               decoration: InputDecoration(
              //                   contentPadding:
              //                       const EdgeInsets.symmetric(horizontal: 20),
              //                   filled: true,
              //                   fillColor: Theme.of(context)
              //                       .dividerColor
              //                       .withOpacity(.2),
              //                   hintText: "Search",
              //                   border: const OutlineInputBorder(
              //                     borderRadius:
              //                         BorderRadius.all(Radius.circular(10)),
              //                     borderSide: BorderSide.none,
              //                   ),
              //                   suffix: GestureDetector(
              //                     onTap: () =>
              //                         controller.searchController.clear(),
              //                     child: const FaIcon(
              //                       FontAwesomeIcons.xmark,
              //                       size: 15,
              //                     ),
              //                   )),
              //             ),
              //             const Divider(),
              //           ],
              //         )
              //       : const SizedBox(),
              // ),
              ListTile(
                onTap: () => controller.page.value = BodyPanelType.resources,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                leading: const FaIcon(FontAwesomeIcons.book),
                title: const Text("Resources"),
              ),
              ListTile(
                onTap: () => controller.page.value = BodyPanelType.fav,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                leading: const FaIcon(FontAwesomeIcons.star),
                title: const Text("Favorites"),
              ),
              const Spacer(),
              ListTile(
                onTap: () => controller.toggleThemeMode(
                  context.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                leading: context.isDarkMode
                    ? const FaIcon(FontAwesomeIcons.sun)
                    : const FaIcon(FontAwesomeIcons.moon),
                title: context.isDarkMode
                    ? const Text("Light Mode")
                    : const Text("Dark Mode"),
              ),
              const Divider(),
              Tooltip(
                message: "Logout",
                child: ListTile(
                  onTap: () => controller.logout(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  // title: const Text("Logout"),
                  leading: profilePhoto(),
                  title: Text(
                    controller.boxService.appUserBox.appUser?.displayName ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    controller.boxService.appUserBox.appUser?.email ?? "",
                    // style: Theme.of(context).textTheme./,
                  ),
                  trailing: const FaIcon(FontAwesomeIcons.signOutAlt),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );

  Widget navigationRail(BuildContext context) => SizedBox(
        height: double.maxFinite,
        // width: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: Obx(
                () => "/"
                            .allMatches(controller.resController.currentPath)
                            .length >
                        1
                    ? InkWell(
                        onTap: () =>
                            (controller.resController.backButtonController)
                                ? Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : null
                                : null,
                        borderRadius: BorderRadius.circular(18),
                        child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            child: FaIcon(FontAwesomeIcons.arrowLeft)),
                      )
                    : const SizedBox(),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: InkWell(
                onTap: () => controller.page.value = BodyPanelType.resources,
                borderRadius: BorderRadius.circular(18),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: FaIcon(FontAwesomeIcons.book),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: InkWell(
                onTap: () => controller.page.value = BodyPanelType.fav,
                borderRadius: BorderRadius.circular(18),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: FaIcon(FontAwesomeIcons.star),
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => controller.toggleThemeMode(
                context.isDarkMode ? ThemeMode.light : ThemeMode.dark,
              ),
              borderRadius: BorderRadius.circular(18),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: context.isDarkMode
                    ? const FaIcon(FontAwesomeIcons.sun)
                    : const FaIcon(FontAwesomeIcons.moon),
              ),
            ),
            InkWell(
              onTap: () => controller.logout(),
              borderRadius: BorderRadius.circular(18),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: FaIcon(FontAwesomeIcons.signOutAlt),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
}
