import 'package:classlink_resources/app/modules/home/views/views/fav.dart';
import 'package:classlink_resources/app/modules/home/views/views/navigation.dart';
import 'package:classlink_resources/app/modules/home/views/widgets/responsive_desktop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'views/fav_option_panel.dart';
import 'views/resents.dart';
import 'views/resources.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(context),
        body: ResponsiveUIBuilder(
          leftChild: (t) => NavigationPanel(controller, t),
          centerChild: (t) => body(t),
          rightChild: (t) => rightChild(),
        ),
      );

  Widget rightChild() => Obx(() {
        switch (controller.page.value) {
          case BodyPanelType.resources:
            return const ResentsPanel();
          case BodyPanelType.fav:
            return const FavOptionPanel();
          case BodyPanelType.search:
            return Container();
        }
      });

  Widget body(ScreenType screenType) => Obx(() {
        switch (controller.page.value) {
          case BodyPanelType.resources:
            return ResourcesBody(controller);
          case BodyPanelType.fav:
            return FavBody(screenType: screenType);
          case BodyPanelType.search:
            return Container();
        }
      });

  AppBar appBar(BuildContext context) => AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: "/".allMatches(controller.resController.currentPath).length > 1
            ? Text(
                controller.resController.rootTitle
                    .substring(0, controller.resController.rootTitle.length - 1)
                    .split("/")
                    .last,
              )
            : const Text("Resources"),
      );
}
