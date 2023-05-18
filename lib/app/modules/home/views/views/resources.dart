import 'package:classlink_resources/app/modules/home/controllers/home_controller.dart';
import 'package:classlink_resources/models/date_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../models/resources_entities.dart';
import '../widgets/hover_builder.dart';

class ResourcesBody extends StatelessWidget {
  const ResourcesBody(this.controller, {Key? key, required}) : super(key: key);
  final HomeController controller;

  Future<void> openDoc(BuildContext context, IndexFile file) async {
    await controller.boxService.recent.saveRecent(file.toJson());
    controller.rerender();
    await launchUrl(Uri.parse(file.id));
  }

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.resController.hasData
            ? Obx(
                () => FutureBuilder<List<IndexEntity>>(
                  future: controller.resController.sheetService
                      .getList(controller.resController.currentPath),
                  builder: (context, snapshot) {
                    if ((controller.resController.currentEntity.isEmpty)) {
                      return const Center(child: Text('No files found'));
                    } else {
                      final list = controller.resController.currentEntity;
                      list.removeWhere((element) =>
                          element is IndexFile && element.size == 0);
                      return resoursesListBuilder(list);
                    }
                  },
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      );

  AnimationLimiter resoursesListBuilder(List<IndexEntity> list) =>
      AnimationLimiter(
        key: UniqueKey(),
        child: GetBuilder<HomeController>(builder: (controller) {
          return ListView.builder(
            padding: const EdgeInsets.only(right: 15, top: 5, bottom: 5),
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) =>
                AnimationConfiguration.staggeredList(
              duration: const Duration(milliseconds: 300),
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: HoverBuilder(
                        builder: (context, isHovering) => ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onTap: () => (list[index] is IndexFolder)
                                  ? controller.resController.currentPath =
                                      "${list[index].path}/"
                                  : openDoc(context, list[index] as IndexFile),
                              leading: leadingIcon(
                                context,
                                isfolder: list[index] is IndexFolder,
                                fileName: list[index].name,
                              ),
                              title: Text(list[index].name),
                              trailing: tileTrailing(isHovering, list[index]),
                            )),
                  ),
                ),
              ),
            ),
          );
        }),
      );

  Widget? tileTrailing(bool isHovering, IndexEntity e) {
    final isFav = controller.boxService.favBox.isFav(e.path);
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      children: [
        e is IndexFile
            ? isFav
                ? glowingFavIcon(e, isFav)
                : AnimatedOpacity(
                    opacity: isHovering ? 1 : 0,
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 500),
                    child: isHovering
                        ? glowingFavIcon(e, isFav)
                        : const SizedBox(),
                  )
            : const SizedBox(),
        (e is IndexFolder
                ? null
                : Text(controller.resController
                    .kiloBytesToString((e as IndexFile).size))) ??
            const SizedBox(),
      ],
    );
  }

  Widget glowingFavIcon(IndexFile e, bool isFav) => GestureDetector(
      onTap: () async {
        isFav
            ? await controller.boxService.favBox.removeFav(e.path)
            : await controller.boxService.favBox
                .saveFav(DateWrapper(date: DateTime.now(), file: e).toJson());
        controller.rerender();
      },
      child: controller.boxService.favBox.isFav(e.path)
          ? const FaIcon(FontAwesomeIcons.solidStar, color: Colors.yellow)
          : const FaIcon(FontAwesomeIcons.star));

  Widget leadingIcon(BuildContext context,
      {required bool isfolder, String fileName = ''}) {
    if (isfolder) {
      return Theme(
        data: Theme.of(context),
        child: FaIcon(FontAwesomeIcons.folder,
            color: context.isDarkMode ? Colors.white : Colors.black),
      );
    } else {
      final fileName0 = fileName.toLowerCase();
      if (fileName0.endsWith('.pdf')) {
        return FaIcon(FontAwesomeIcons.filePdf, color: Colors.red[400]);
      } else if (fileName0.endsWith('.pptx') || fileName0.endsWith('.ppt')) {
        return FaIcon(FontAwesomeIcons.filePowerpoint,
            color: Colors.yellow[400]);
      } else if (fileName0.endsWith('.docx') || fileName0.endsWith('.doc')) {
        return const FaIcon(FontAwesomeIcons.fileWord, color: Colors.blue);
      } else if (fileName0.endsWith('.xlsx') || fileName0.endsWith('.xls')) {
        return const FaIcon(FontAwesomeIcons.fileExcel, color: Colors.green);
      } else if (fileName0.endsWith('.png') ||
          fileName0.endsWith('.jpg') ||
          fileName0.endsWith('.jpeg')) {
        return const FaIcon(FontAwesomeIcons.fileImage, color: Colors.purple);
      }
      return const FaIcon(FontAwesomeIcons.solidFile);
    }
  }
}
